(use-package eshell
  :commands eshell
  :bind (:map eshell-mode-map
              ("C-c M-o" . t3mpt0n/fancy-eshell-clear)
              ))

(use-package eat
  :requires eshell
  :elpaca (eat :type git
               :host codeberg
               :repo "akib/emacs-eat"
               :files ("*.el" ("term" "term/*.el") "*.texi"
                       "*.ti" ("terminfo/e" "terminfo/e/*")
                       ("terminfo/65" "terminfo/65/*")
                       ("integration" "integration/*")
                       (:exclude ".dir-locals.el" "*-tests.el")))
  :hook (eshell-load . eat-eshell-mode))
(use-package multi-vterm
  :after vterm
  :ensure t
  :bind (
         ("C-; o T" . multi-vterm)
         ))
