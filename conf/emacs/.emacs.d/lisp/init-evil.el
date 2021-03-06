;;; init-evil.el --- Configure the extensible vi layer for Emacs.  -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package evil
  :defines
  (evil-want-Y-yank-to-eol)
  :init
  (setq evil-ex-search-vim-style-regexp t)
  (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil) ;; required by evil-collection
  (setq evil-want-C-u-scroll t)
  (setq evil-move-beyond-eol t)
  (setq evil-want-Y-yank-to-eol t) ;; Yank to end of line with Y instead of whole line
  :general
  ('(normal)
   "j" 'evil-next-visual-line
   "k" 'evil-previous-visual-line)
  ('(normal visual insert emacs) :prefix "SPC" :non-normal-prefix "C-SPC"
   "sc" #'evil-ex-nohighlight)
  :config
  (evil-mode))

;; Various evil bindings for emacs features
(use-package evil-collection
  :after (evil)
  :custom (evil-collection-setup-minibuffer t)
  :config (evil-collection-init))

;; Surround text objects
(use-package evil-surround
  :config (global-evil-surround-mode))

;; Comment text using motions (gc) or line (gcc)
(use-package evil-commentary
  :diminish evil-commentary-mode
  :config (evil-commentary-mode))

;; 2-char searching ala vim-sneak & vim-seek,
(use-package evil-snipe
  :init
  (setq evil-snipe-scope 'whole-buffer)
  :config
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1)
  (diminish 'evil-snipe-mode)
  (diminish 'evil-snipe-local-mode)
  (diminish 'evil-snipe-override-mode)
  (add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)
  (add-hook 'git-rebase-mode-hook 'turn-off-evil-snipe-mode))

;; Visual previews for certain evil-ex commands.
(use-package evil-traces
  :demand t
  :diminish evil-traces-mode
  :commands
  (evil-traces-use-diff-faces
   evil-traces-mode)
  :config
  (evil-traces-use-diff-faces) ; if you want to use diff's faces
  (evil-traces-mode))

;; Multiple cursors
(use-package evil-mc
  :diminish evil-mc-mode
  :config
  (global-evil-mc-mode 1))

;; Press “%” to jump between matched tags in Emacs. For example, in HTML “<div>” and “</div>” are a pair of tags.
(use-package evil-matchit
  :demand t
  :commands
  (global-evil-matchit-mode)
  :config
  (global-evil-matchit-mode 1))

;; Easily align text
(use-package evil-lion
  :demand t
  :commands
  (evil-lion-mode)
  :config
  (evil-lion-mode))

;; Increment numbers, ala c-a c-x in vim
(use-package evil-numbers
  :general
  ('(normal visual insert emacs) :prefix "SPC" :non-normal-prefix "C-SPC"
   "n+" '(evil-numbers/inc-at-pt :which-key "Inc")
   "n-" '(evil-numbers/dec-at-pt :which-key "Dec")))

(provide 'init-evil)
;;; init-evil.el ends here
