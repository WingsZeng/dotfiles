#!/bin/zsh

export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"

emails=(${(f)"$(ls $XDG_DATA_HOME/mail)"})

for email in $emails; do
  mbsync -c $XDG_CONFIG_HOME/isync/isyncrc $email
  result=$(notmuch new)
  logger -t "check email" "$email: $result"
  if ! echo $result | grep -q "No new mail"; then
    $XDG_CONFIG_HOME/goimapnotify/notify.sh $email
  fi
done
