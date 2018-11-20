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
tmux rename-window -t${SESSION}:0 "PULTR02"
tmux send-keys 'ssh pultr02' Enter
tmux new-window
tmux rename-window -t${SESSION}:1 "PULTR03"
tmux send-keys 'ssh pultr03' Enter
tmux new-window
tmux rename-window -t${SESSION}:2 "PVIVO01"
tmux send-keys 'ssh pvivo01' Enter
tmux new-window
tmux rename-window -t${SESSION}:3 "PVIVO02"
tmux send-keys 'ssh pvivo02' Enter
tmux new-window
tmux rename-window -t${SESSION}:4 "PVIVO04"
tmux send-keys 'ssh pvivo04' Enter
tmux new-window
tmux rename-window -t${SESSION}:5 "NVIVO01"
tmux send-keys 'ssh nvivo01' Enter
tmux attach-session -t $SESSION
