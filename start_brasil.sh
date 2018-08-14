#!/bin/bash

SESSION="brasil"
RUN="ssh"

printf "Looking for existing session : "
$(tmux has -t $SESSION)
if [ $? == 0 ] 
then
		printf "Session already exists. Attaching to previous session.\n"
				tmux a -d -t $SESSION
				exit
fi

tmux new -d -s $SESSION 
tmux rename-window -t${SESSION}:0 "PULTR01"
tmux send-keys C-a 'ssh pultr01' Enter
tmux new-window
tmux rename-window -t${SESSION}:1 "PULTR02"
tmux send-keys C-a 'ssh pultr02' Enter
tmux new-window
tmux rename-window -t${SESSION}:2 "PULTR03"
tmux send-keys C-a 'ssh pultr03' Enter
tmux new-window
tmux rename-window -t${SESSION}:3 "PVIVO01"
tmux send-keys C-a 'ssh pvivo01' Enter
tmux new-window
tmux rename-window -t${SESSION}:4 "PVIVO02"
tmux send-keys C-a 'ssh pvivo02' Enter
tmux attach-session -t $SESSION
