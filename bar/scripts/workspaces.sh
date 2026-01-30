#!/bin/bash
tot_ws=$(hyprctl workspaces | grep "workspace ID" | awk '{print($3)}')
sel_ws=$(hyprctl activeworkspace | awk '{for(i=1;i<=NF;i++) if ($i == "ID") print($(i+1))}')
echo $tot_ws | sed "s/\b$sel_ws\b//g" | sed "s/[0-9]//g" | tr ' ' '\n' 