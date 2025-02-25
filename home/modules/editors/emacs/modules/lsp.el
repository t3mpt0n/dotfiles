(use-package eglot
  :ensure nil
  :hook (prog-mode . eglot-ensure))

(use-package format-all
  :ensure t
  :commands format-all-mode
  :hook (prog-mode . format-all-mode))

(use-package nix-mode
  :ensure t
  :after (eglot format-all)
  :hook (nix-mode . (lambda () (setq format-all-formatters
                                     '(("Nix" (alejandra))))))
  :config
  (add-to-list 'eglot-server-programs '(nix-mode . ("nixd"))))

(use-package latex-mode
  :ensure nil
  :after (eglot format-all)
  :hook (
         (latex-mode . format-all-mode)
         (latex-mode . eglot-ensure)
         (latex-mode . (lambda () (setq format-all-formatters
                                        '(("LaTeX" (auctex)))))))
  :config
  (add-to-list 'eglot-server-programs '(latex-mode . ("texlab"))))

(use-package markdown-mode
  :ensure t
  :after (eglot format-all)
  :hook (
         (markdown-mode . format-all-mode)
         (markdown-mode . (lambda () (setq format-all-formatters
                                           '(("Markdown" (prettierd))))))
         (markdown-mode . eglot-ensure)
         )
  :config
  (add-to-list 'eglot-server-programs '(markdown-mode . ("marksman"))))

(use-package kotlin-mode
  :ensure t
  :after (eglot format-all)
  :hook (
         (kotlin-mode . (lambda () (setq format-all-formatters
                                         '(("Kotlin" (ktlint))))))
         (kotlin-mode . format-all-mode)
         (kotlin-mode . eglot-ensure)
         )
  :config
  (add-to-list 'eglot-server-programs '(kotlin-mode . ("kotlin-language-server"))))
