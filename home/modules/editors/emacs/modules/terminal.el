(use-package eat
  :elpaca (eat :type git
               :host codeberg
               :repo "akib/emacs-eat"
               :files ("*.el" ("term" "term/*.el") "*.texi"
                       "*.ti" ("terminfo/e" "terminfo/e/*")
                       ("terminfo/65" "terminfo/65/*")
                       ("integration" "integration/*")
                       (:exclude ".dir-locals.el" "*-tests.el")))

  :config
  (general-define-key
   :states '(normal emacs)
   :prefix t3mpt0n/leader
   "o T" '(eat :which-key "Open Terminal")))
