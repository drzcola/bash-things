#!/bin/bash

PATH=$PATH:/usr/bin:/bin:/sbin:/usr/sbin

ATTEMPTS=10;    # NUMBER OF ATTEMPTS IN A GIVEN INTERVAL
INTERVAL=300;   # INTERVAL (IN SECONDS) TO WATCH FOR FAILED ATTEMPTS - HISTORICALLY FROM CURRENT TIME
PERMBAN=100;    # AFTER THIS NUM OF FAILED ATTEMPTS, BAN UNTIL LOG ROTATES
BLOCKSECS=3600;   # AFTER THIS TIME (IN SECONDS), UNBLOCK A BLOCKED IP
BLOCKED_ALREADY=""
BLOCKED_NOW=""
SKIPPED=""
EXPIRED_BLOCK=""
NOW=`date '+%s'`

isip() {
        ISIP=$1
        if [ $(echo $IP | sed 's/[^.]//g' | awk '{print length; }' 2> /dev/null) -eq 3 ]; then
                ISIP=1
        fi
}

fail2ban() {
        # echo failing $IP with count $COUNT and lastcount $LASTCOUNT
        IP=$IP
        EXISTS=`iptables -n -L | grep $IP | wc -l`
        IS_LOCAL=`echo $IP | grep -E '^10\.|192\.168|127\.' | wc -l`
        if [ $EXISTS -gt 0 ]; then
                BLOCKED_ALREADY+=",$IP:$COUNT"
                # echo "IP $IP is already blocked"
        elif [ $IS_LOCAL -eq 1 ]; then
                SKIPPED+=",$IP:$COUNT"
                # echo "IP is local IP.  Not blocking"
        else
                if [ ! "$IP" == "" ]; then
                        # echo "Blocking IP $IP after $COUNT abuses."
                        BLOCKED_NOW+=",$IP:$COUNT"
                        iptables -I INPUT 1 -j DROP -s $IP
                        echo "`date`:$IP:$NEWCOUNT:$COUNT" >> /tmp/banned.log
                fi
        fi
}

updateList() {
        NOW=`date '+%s'`
        sed -i /tmp/ip-list.log -e "s/"$IP":"$LASTCOUNT".*$/"$IP":"$COUNT":"$NOW"/"
}


showList() {
        LIST="$2"
        DESCRIPTION="$1"
        if [ ! "$LIST" == "" ]; then  
                echo "$DESCRIPTION"
                for i in `echo "$LIST"`                                                                       
                do                                                                                                   
                        BIP=$(echo $i | sed -e 's/:.*$//')                                                           
                        BCOUNT=$(echo $i | sed -e 's/^.*://')                                                        
                        if [ ! "$BIP" == "" ]; then
                                echo $BIP $BCOUNT                                                                            
                        fi
                done
        fi
}

checkExpired() {
        BLOCKED=$(iptables -L INPUT -n | grep "^DROP" | sed -e 's/^.*--  //' | sed -e 's/ .*$//')
        for i in `grep -e "$BLOCKED" /tmp/ip-list.log`                                                                                                                                              
        do                                                                                                                                                                           
                IP=`echo $i | cut -d':' -f1`                                                                                                                                         
                isip $IP                                                                                                                                                             
                COUNT=`echo $i | cut -d':' -f2`                                                                                                                                      
                LASTACTION=`echo $i | cut -d':' -f3`                                                                                                                                 
                                                                                                                                                                                     
                if [ $((NOW-LASTACTION)) -gt $BLOCKSECS ] && [ ! "$IP" == "" ] && [ $ISIP -eq 1 ] && [ $COUNT -lt $PERMBAN ]; then                                                   
                        LINE=`iptables -L -n --line-numbers | grep "$IP" | cut -d' ' -f1`                                                                                            
                        if [ ! "$LINE" == "" ]; then                                                                                                                                 
                                echo "Removing block on $IP"                                                                                                                         
                                # EXPIRED_BLOCK+=",$IP"                                                                                                                              
                                echo iptables -D INPUT $LINE                                                                                                                         
                                iptables -D INPUT $LINE                                                                                                                              
                        fi                                                                                                                                                           
                fi                                                                                                                                                                   
        done                                   
}


if [ ! -f /tmp/ip-list.log ]; then
        touch /tmp/ip-list.log
fi

# Do some checking to see if the logs actually changed
if [ -f /tmp/this-run ]; then
        mv /tmp/this-run /tmp/last-run
else
        touch /tmp/last-run
fi
ls -al /var/log/asterisk/security > /tmp/this-run
CHANGE=$(diff /tmp/last-run /tmp/this-run | wc -l)
if [ $CHANGE -eq 0 ]; then
        echo "No change since last run"
        checkExpired
        exit
fi

IPLIST=$(/bin/grep -E "InvalidAccount|ChallengeResponseFailed" /var/log/asterisk/security | sed -e 's/^.*RemoteAddress="IPV4\/UDP\/\([0-9.]*\)\/.*$/\1/' | sort | uniq -c | sed -e 's/^ *//' | sed -e 's/ /:/')

for i in `echo "$IPLIST"`
do
        #echo $i
        COUNT=`echo $i | cut -d':' -f1`
        IP=`echo $i | cut -d':' -f2`
        isip $IP
        LASTCOUNT=`cat /tmp/ip-list.log | grep "^$IP:" | cut -d':' -f2`
        ELAPSED=`cat /tmp/ip-list.log | grep "^$IP:" | cut -d':' -f3 | sed -e 's/\n//g'`
        ELAPSED=$((NOW-ELAPSED))
        if [ "$COUNT" == "" ]; then
                COUNT=0
        fi
        if [ "$LASTCOUNT" == "" ]; then
                LASTCOUNT=0
        fi
        NEWCOUNT=$((COUNT-LASTCOUNT))
        if [ ! "$LASTCOUNT" == "" ] && [ $LASTCOUNT -eq 0 ] && [ $ISIP -eq 1 ]; then
                echo "$IP:$COUNT:$NOW" >> /tmp/ip-list.log
               # echo "Adding $IP to the IP tracking log with count $COUNT"
        fi
        if [ $NEWCOUNT -ge $ATTEMPTS ] && [ $ISIP -eq 1 ] && ( [ $ELAPSED -le $INTERVAL ]  ||  [ $COUNT -gt $PERMBAN ] ); then
                if [ $LASTCOUNT -ne 0 ]; then
                        # echo "Updating IP:$IP with NEWCOUNT:$NEWCOUNT ATTEMPTS:$ATTEMPTS ELAPSED:$ELAPSED INTERVAL:$INTERVAL ISIP:$ISIP"
                        updateList

                fi
                fail2ban
        fi
done

checkExpired

IFS=","

showList "Blocked | Attempts" "$BLOCKED_ALREADY"
showList "Newly Blocked | Attempts" "$BLOCKED_NOW"
showList "Skipped | Attempts" "$SKIPPED"
showList "Expired" "$EXPIRED_BLOCK"
