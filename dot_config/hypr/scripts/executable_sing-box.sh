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
    int32:$expire_time >/dev/null
}

doas rc-service sing-box status
if [ $? -ne 0 ]; then
  output=$(doas rc-service sing-box start 2>&1)
  if [ $? -ne 0 ]; then
    notify sing-box "Failed to start sing-box" "$output"
  fi
  sleep 0.1
fi

proxies=$(curl localhost:9090/proxies 2>/dev/null | jq -r '.proxies.proxy | .all[]')

if [[ -z $proxies ]]; then
  notify sing-box "" "sing-box is not running" 5000
  exit 1
fi

proxy=$(echo "$proxies\ndirect" | fuzzel --dmenu -p "Proxies: ")

if [[ -z $proxy ]]; then
  exit 1
fi

if [[ $proxy == "direct" ]]; then
  doas rc-service sing-box stop
  exit 0
fi

respons=$(curl -w "%{http_code}" -X PUT -d '{"name":"'$proxy'"}' localhost:9090/proxies/proxy 2>/dev/null)
code=$(echo $respons | tail -n 1)
body=$(echo $respons | head -n -1)
message=$(echo $body | jq -r '.message')
echo $code

if [[ $code -eq 204 ]]; then
  notify sing-box $proxy OK 5000
else
  notify sing-box $proxy $message
fi
