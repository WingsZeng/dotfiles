#/bin/zsh

dbus-send \
  --session \
  --dest=org.freedesktop.Notifications \
  --type=method_call \
  --print-reply \
  /org/freedesktop/Notifications org.freedesktop.Notifications.Notify \
  string:'goimapnotify' \
  uint32:0 \
  string: \
  string:'New Email' \
  string:$1 \
  array:string: \
  dict:string:string: \
  int32:0
