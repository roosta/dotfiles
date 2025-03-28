#!/bin/bash
pac=$(checkupdates | wc -l)
aur=$(cower -u | wc -l)

check=$((pac + aur))
if [[ "$check" != "0" ]]; then
  echo "%{F#5573A3 B#00000000 T4}%{F- B- T-}%{F#FCE8C3 B#5573A3} $pac %{T3}%{T-} $aur %{F- B-}%{F#5573A3 B#1C1B19 T4} %{F- B- T-}"
else
  echo "%{F#2D2B28 B#00000000 T4}%{F- B- T-}%{F#FCE8C3 B#2D2B28} $pac %{T3}%{T-} $aur %{F- B-}%{F#2D2B28 B#1C1B19 T4} %{F- B- T-}"
  # echo "%{B#2D2B28 F#FCE8C3} $pac  $aur "
fi

# echo "$pac % $aur"
# echo "$pac  $aur"
