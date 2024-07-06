#!/bin/zsh

emails=(${(f)"$(ls $XDG_DATA_HOME/mail)"})
echo $emails

for email in $emails; do
  echo $email
  mbsync -c $XDG_CONFIG_HOME/isync/isyncrc $email
  if ! notmuch new | grep -q "No new mail"; then
    $XDG_CONFIG_HOME/goimapnotify/notify.sh $email
  fi
done
