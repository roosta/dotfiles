vpn=$(pgrep -x openvpn)
if [[ -n $vpn ]]; then
  echo "%{F#2D2B28 B#00000000 T4}%{B- F- T-}%{F#98BC37 B#2D2B28}%{T3}%{T-} VPN %{F- B-}%{F#2D2B28 B#1C1B19 T4}%{F- B- T-}"
else
  echo "%{F#2D2B28 B#00000000 T4}%{B- F- T-}%{F#F75341 B#2D2B28}%{T3}%{T-} VPN %{F- B-}%{F#2D2B28 B#1C1B19 T4}%{F- B- T-}"
fi
