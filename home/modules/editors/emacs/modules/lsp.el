(use-package eglot
  :ensure nil
  :hook (prog-mode . eglot-ensure))

(use-package format-all
  :ensure t
  :commands format-all-mode
  :hook (prog-mode . format-all-mode))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'"
  :after (eglot format-all flycheck)
  :hook (nix-mode . (lambda () (setq format-all-formatters
                                     '(("Nix" (alejandra))))))
  :config
  (add-to-list 'eglot-server-programs '(nix-mode . ("nixd"))))

(use-package latex-mode
  :ensure nil
  :mode "\\.tex\\'"
  :after (eglot format-all flycheck)
  :hook (
         (latex-mode . format-all-mode)
         (latex-mode . eglot-ensure)
         (latex-mode . (lambda () (setq format-all-formatters
                                        '(("LaTeX" (auctex)))))))
  :config
  (add-to-list 'eglot-server-programs '(latex-mode . ("texlab"))))

(use-package markdown-mode
  :ensure t
  :mode "\\.md\\'"
  :after (eglot format-all flycheck)
  :hook (
         (markdown-mode . format-all-mode)
         (markdown-mode . (lambda () (setq format-all-formatters
                                           '(("Markdown" (prettierd))))))
         (markdown-mode . eglot-ensure)
         )
  :config
  (add-to-list 'eglot-server-programs '(markdown-mode . ("marksman"))))


(use-package flycheck-kotlin
  :ensure t
  :after (eglot format-all flycheck)
  :config (flycheck-kotlin-setup))

(use-package kotlin-mode
  :ensure t
  :after flycheck-kotlin
  :mode "\\.kts?\\'"
  :hook (
         (kotlin-mode . (lambda () (setq format-all-formatters
                                         '(("Kotlin" . (ktlint))))))
         (kotlin-mode . format-all-mode)
         (kotlin-mode . eglot-ensure)
         )
  :config
  (add-to-list 'eglot-server-programs '(kotlin-mode . ("kotlin-language-server"))))

(use-package flycheck-irony
  :ensure t
  :after (eglot format-all flycheck)
  :hook (flycheck-mode . flycheck-irony-setup))

(use-package irony
  :ensure t
  :after flycheck-irony
  :hook (
         ((c-mode c++-mode objc-mode) . irony-mode)
         (irony-mode . irony-cdb-autosetup-compile-options)))

(use-package irony-eldoc
  :ensure t
  :after irony
  :hook (irony-mode . irony-eldoc))

