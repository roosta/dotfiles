;;; init-gui-frames.el --- Behaviour specific to non-TTY frames -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;----------------------------------------------------------------------------
;; Suppress GUI features
;;----------------------------------------------------------------------------
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)

;;----------------------------------------------------------------------------
;; Window size and features
;;----------------------------------------------------------------------------
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'set-scroll-bar-mode)
  (set-scroll-bar-mode nil))
(when (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))


; ;; Non-zero values for `line-spacing' can mess up ansi-term and co,
; ;; so we zero it explicitly in those cases.
; (add-hook 'term-mode-hook
;           (lambda ()
;             (setq line-spacing 0)))

(provide 'init-gui-frames)
;;; init-gui-frames.el ends here