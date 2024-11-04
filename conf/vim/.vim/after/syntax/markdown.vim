scriptencoding utf-8
syntax match todoCheckbox '\v.*\[\ \]'hs=e-2 conceal cchar=
syntax match todoCheckbox '\v.*\[x\]'hs=e-2 conceal cchar=
syntax match todoCheckbox '\v.*\[-\]'hs=e-2 conceal cchar=

setlocal  conceallevel=2

