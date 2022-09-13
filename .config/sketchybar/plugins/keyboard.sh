#!/usr/bin/env bash

SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)

case ${SOURCE} in
'com.apple.keylayout.ABC') LABEL='英' ;;
'com.apple.keylayout.WubixingKeyboard') LABEL='五' ;;
'com.apple.keylayout.PinyinKeyboard') LABEL='拼' ;;
esac

color='0xffF3C583'

if [[ $LABEL == "en" ]]; then
  color='0xffF85C50'
fi

sketchybar --set $NAME label="$LABEL" 
#label.color="$color"
