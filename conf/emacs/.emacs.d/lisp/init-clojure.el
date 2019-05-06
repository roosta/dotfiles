;;; init-clojure.el --- Setup clojure and clojurescript language  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:


(use-package clojure-mode)

;;----------------------------------------------------------------------------
;; Snippets for yasnippet
;;----------------------------------------------------------------------------
(use-package clojure-snippets
  :after (yasnippet))

;;----------------------------------------------------------------------------
;; Cider
;;----------------------------------------------------------------------------
(use-package cider
  :commands (cider-repl-newline-and-indent
             cider-repl-clear-buffer
             cider-switch-to-last-clojure-buffer
             cider-repl-handle-shortcut))

;;----------------------------------------------------------------------------
;; highlight evals
;;----------------------------------------------------------------------------
(use-package cider-eval-sexp-fu
  :after (cider))

;;----------------------------------------------------------------------------
;; Clojure util functions
;;----------------------------------------------------------------------------
(after-load 'cider
  (after-load 'evil
    (require 'clojure-utils)))

;;----------------------------------------------------------------------------
;; Key definitions
;;----------------------------------------------------------------------------
(general-def cider-repl-mode-map
  "RET" #'cider-repl-newline-and-indent)

(general-def '(normal visual evilified) cider-repl-mode-map :prefix ","
  "sc"  #'cider-repl-clear-buffer
  "ss"  #'cider-switch-to-last-clojure-buffer
  ","   #'cider-repl-handle-shortcut)

(general-def '(normal visual evilified) clojure-mode-map :prefix ","
  "ha" 'cider-apropos
  "hh" 'cider-doc

  "hg" 'cider-grimoire
  "hj" 'cider-javadoc
  "hn" 'cider-browse-ns

  "eb" 'cider-eval-buffer
  "ee" 'cider-eval-last-sexp
  "ef" 'cider-eval-defun-at-point
  "em" 'cider-macroexpand-1
  "eM" 'cider-macroexpand-all
  "er" 'cider-eval-region
  "ew" 'cider-eval-last-sexp-and-replace

  "="  'cider-format-buffer
  "fb" 'cider-format-buffer

  "gb" 'cider-pop-back
  "gC" 'cider-classpath
  "ge" 'cider-jump-to-compilation-error
  ;; "gr" 'cider-jump-to-resource
  "gn" 'cider-browse-ns
  "gN" 'cider-browse-ns-all

  "'"  'cider-jack-in
  "\"" 'cider-jack-in-clojurescript
  "sb" 'cider-load-buffer
  "sB" 'spacemacs/cider-send-buffer-in-repl-and-focus
  "sc" 'cider-connect
  "sC" 'cider-find-and-clear-repl-output
  "se" 'spacemacs/cider-send-last-sexp-to-repl
  "sE" 'spacemacs/cider-send-last-sexp-to-repl-focus
  "sf" 'spacemacs/cider-send-function-to-repl
  "sF" 'spacemacs/cider-send-function-to-repl-focus
  "si" 'cider-jack-in
  "sI" 'cider-jack-in-clojurescript
  "sn" 'spacemacs/cider-send-ns-form-to-repl
  "sN" 'spacemacs/cider-send-ns-form-to-repl-focus
  "so" 'cider-repl-switch-to-other
  "sq" 'cider-quit
  "sr" 'spacemacs/cider-send-region-to-repl
  "sR" 'spacemacs/cider-send-region-to-repl-focus
  "ss" 'cider-switch-to-repl-buffer
  "sx" 'cider-ns-refresh

  "Te" 'cider-enlighten-mode
  "Tf" 'spacemacs/cider-toggle-repl-font-locking
  "Tp" 'spacemacs/cider-toggle-repl-pretty-printing
  "Tt" 'cider-auto-test-mode

  "ta" 'spacemacs/cider-test-run-all-tests
  "tb" 'cider-test-show-report
  "tl" 'spacemacs/cider-test-run-loaded-tests
  "tp" 'spacemacs/cider-test-run-project-tests
  "tn" 'spacemacs/cider-test-run-ns-tests
  "tr" 'spacemacs/cider-test-rerun-failed-tests
  "tt" 'spacemacs/cider-test-run-focused-test

  "db" 'cider-debug-defun-at-point
  "de" 'spacemacs/cider-display-error-buffer
  "dv" 'cider-inspect

  ;; refactorings from clojure-mode
  "rc{" 'clojure-convert-collection-to-map
  "rc(" 'clojure-convert-collection-to-list
  "rc'" 'clojure-convert-collection-to-quoted-list
  "rc#" 'clojure-convert-collection-to-set)

(provide 'init-clojure)
;;; init-clojure.el ends here