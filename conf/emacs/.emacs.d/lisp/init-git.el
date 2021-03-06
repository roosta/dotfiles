;;; init-git.el --- Git SCM support -*- lexical-binding: t -*-
;;; Commentary:

;; See also init-github.el.

;;; Code:

(use-package git-commit)

(use-package magit
  :general
  ('(normal visual insert emacs) :prefix "SPC" :non-normal-prefix "C-SPC"
   "gb"  #'magit-blame
   "gfh" #'magit-log-buffer-file
   "gm"  #'magit-dispatch-popup
   "gs"  #'magit-status
   "gS"  #'magit-stage-file
   "gU"  #'magit-unstage-file))

(use-package evil-magit
  :after (magit))

(use-package diff-hl
  :functions
  (global-diff-hl-mode
   diff-hl-margin-mode)
  :config
  (diff-hl-margin-mode)
  (global-diff-hl-mode))

(use-package git-link)

;; Use auto commit for org-mode
(use-package git-auto-commit-mode)

(provide 'init-git)
;;; init-git.el ends here
