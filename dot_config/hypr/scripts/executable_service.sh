#!/bin/zsh

notify() {
  appname=$1
  summary=$2
  body=$3
  expire_time="${4:-0}"
  dbus-send \
    --session \
    --dest=org.freedesktop.Notifications \
    --type=method_call \
    --print-reply \
    /org/freedesktop/Notifications org.freedesktop.Notifications.Notify \
    string:$appname \
    uint32:0 \
    string: \
    string:$summary \
    string:$body \
    array:string: \
    dict:string:string: \
    int32:$expire_time > /dev/null
}

service=$(rc-service -l | fuzzel --dmenu -p "Service: ")

if [[ -z $service ]]; then
  exit 1
fi

local -a actions=(${(f)"$(rc-service -C $service describe 2>&1)"})
shift actions                                          
actions=(${actions# \* })                              
actions=(${actions/:*})                                
actions=(stop start restart describe zap ${actions[@]})
action=$(echo ${(j.\n.)actions} | fuzzel --dmenu -p "Action for $service: ")

if [[ -z $action ]]; then
  exit 1
fi

out=$(doas rc-service $service $action 2>&1)

if [[ $? -eq 0 ]]; then
  notify OpenRC "$service $action" $out 5000
else
  notify OpenRC "$service $action" $out
fi
