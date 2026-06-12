#!/bin/bash

theme=$(xfconf-query -c xsettings -p /Net/ThemeName)

FILE="$HOME/test.jsonc"

css_file="$HOME/.themes/$theme/gtk-3.0/gtk.css"
if [ ! -f "$css_file" ]; then
    css_file="/usr/share/themes/$theme/gtk-3.0/gtk.css"
fi

if [ -f "$css_file" ]; then
    hex=$(grep "@define-color theme_selected_bg_color" "$css_file" | grep -oE '#[0-9A-Fa-f]{6}' | head -n1)
fi

if [ -z "$hex" ]; then
    hex="#FFFFFF" 
fi

hex2=${hex#\#}
r=$((16#${hex2:0:2}))
g=$((16#${hex2:2:2}))
b=$((16#${hex2:4:2}))

new_color="38;2;"$r";"$g";"$b"m"


sed -i "s/\"keys\": \"[^\"]*\"/\"keys\": \"${hex}\"/g" $FILE
sed -i "s/\"title\": \"[^\"]*\"/\"title\": \"${hex}\"/g" $FILE

sed -i "s/\\\\u001b\[.*/\\\\u001b[$new_color\"/g" "$FILE"

fastfetch -c ~/test.jsonc