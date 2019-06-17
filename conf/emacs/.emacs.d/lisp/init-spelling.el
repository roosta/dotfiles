;;; init-spelling.el --- Spell checking              -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(defvar flyspell-correct-interface)

(use-package flyspell
  :init
  ;; printing messages for every word (when checking the entire
  ;; buffer) causes an enormous slowdown
  (setq flyspell-issue-message-flag nil)

  ;; Don't spell check strings, only comments
  ;; (setq flyspell-prog-text-faces
  ;;       (delq 'font-lock-string-face
  ;;             flyspell-prog-text-faces))
  :commands
  (spell-checking/change-dictionary)
  :config
  (add-hook #'git-commit-setup-hook #'git-commit-turn-on-flyspell)
  ;; (add-hook 'prog-mode-hook #'flyspell-prog-mode) ; Check comments and strings
  :general
  ('(normal visual insert emacs) :prefix "SPC" :non-normal-prefix "C-SPC"
   "Sb" #'flyspell-buffer
   "Sd" #'spell-checking/change-dictionary
   "Sn" #'flyspell-goto-next-error))

(use-package flyspell-correct
  :commands
  (flyspell-correct-word-generic
   flyspell-correct-previous-word-generic)
  :general
  ('(normal visual insert emacs)  :prefix "SPC" :non-normal-prefix "C-SPC"
   "Sc" #'flyspell-correct-word-generic))

(use-package flyspell-correct-ivy
  :commands (flyspell-correct-ivy)
  :init
  (setq flyspell-correct-interface #'flyspell-correct-ivy))

(provide 'init-spelling)

;;; init-spelling.el ends here
