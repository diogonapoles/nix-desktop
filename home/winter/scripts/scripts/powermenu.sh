#! /usr/bin/env bash

orange='#d65d0e'
green='#98971a'
blue='#83a598'
yellow='#fabd2f'

shutdown="<span color='${orange}'>󰐥</span>"
reboot="<span color='${green}'>󰜉</span>"
lock="<span color='${blue}'>󰣫</span>"
suspend="<span color='${yellow}'>󰒲</span>"

theme="$HOME/.config/rofi/powermenu/powermenu.rasi"

rofi_cmd() {
  rofi -dmenu -theme ${theme} -markup-rows
}

run_rofi() {
  echo -e "$shutdown\n$reboot\n$lock\n$suspend" | rofi_cmd
}

run_cmd() {
  if [[ $1 == '--shutdown' ]]; then
    systemctl poweroff
  elif [[ $1 == '--reboot' ]]; then
    systemctl reboot
  elif [[ $1 == '--lock' ]]; then
    sleep 0.1
    hyprlock
  elif [[ $1 == '--suspend' ]]; then
    hyprlock &
    systemctl suspend
  fi
}

chosen="$(run_rofi)"
case ${chosen} in
$shutdown)
  run_cmd --shutdown
  ;;
$reboot)
  run_cmd --reboot
  ;;
$lock)
  run_cmd --lock
  ;;
$suspend)
  sleep 0.1
  run_cmd --suspend
  ;;
esac
