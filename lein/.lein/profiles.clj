{:user {:aliases  {"rebl" ["trampoline" "run" "-m" "rebel-readline.main"]}
        :signing {:gpg-key "mail@roosta.sh"}
        :dependencies [
                       ; [com.bhauman/rebel-readline "0.1.4"]
                       [hashp "0.2.1"]]
        :injections [(require 'hashp.core)]
        :plugins [;; check deps for new versions
                  [lein-ancient "0.6.15"]

                  [cider/cider-nrepl "0.25.3"]

                  [lein-auto "0.1.3"]

                  ;; clojure syntax checking
                  [jonase/eastwood "0.3.11" :exclusions [org.clojure/clojure]]

                  ;; try libraries in a repl
                  ;; Emacs: In your *scratch* buffer, set your inferior-lisp-program var...
                  ; (setq inferior-lisp-program "lein try tentacles")
                  ; and then launch M-x inferior-lisp.
                  [lein-try "0.4.3"]

                  ;; pretty print
                  [lein-pprint "1.3.2"]

                  ;; clojure/script syntax checking
                  [lein-kibit "0.1.8" :exclusions [org.clojure/clojure]]]}}
