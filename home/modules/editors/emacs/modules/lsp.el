(use-package eglot
  :ensure nil
  :hook ((prog-mode . eglot-ensure)
         (eglot--managed-mode . corfu-mode)))

(use-package format-all
  :ensure t
  :commands format-all-mode
  :hook (prog-mode . format-all-mode))

(use-package flycheck
  :ensure t
  :hook (after-init . global-flycheck-mode))

(use-package direnv
  :ensure t
  :config
  (direnv-mode))

(use-package tree-sitter
  :ensure t
  :hook (tree-sitter-after-on . tree-sitter-hl-mode)
  :config
  (global-tree-sitter-mode))

(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)
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
                                         '(("Kotlin" (ktlint))))))
         (kotlin-mode . format-all-mode)
         (kotlin-mode . eglot-ensure)
         )
  :config
  (add-to-list 'eglot-server-programs '(kotlin-mode . ("kotlin-language-server"))))

(use-package flycheck-irony
  :ensure t
  :after (eglot format-all flycheck company)
  :hook (flycheck-mode . flycheck-irony-setup))

(use-package irony
  :ensure t
  :mode "\\.c\\'" "\\.cpp\\'" "\\.h\\'"
  :after flycheck-irony
  :hook (
         ((c-mode c++-mode objc-mode) . irony-mode)
         (irony-mode . irony-cdb-autosetup-compile-options)
         (irony-mode . eglot-ensure)
         )
  :config
  (add-to-list 'eglot-server-programs '(irony-mode . ("clangd"))))

(use-package irony-eldoc
  :ensure t
  :after irony
  :hook (irony-mode . irony-eldoc))

(use-package company-web
  :ensure t
  :after company)

(use-package web-mode
  :ensure t
  :after (eglot format-all flycheck company-web)
  :mode (
         ("\\.html?\\'" . web-mode)
         ("\\.html?\\'" . (lambda () (add-to-list 'eglot-server-programs '(web-mode . ("vscode-html-language-server" "--stdio")))))
         ("\\.html?\\'" . (lambda () (setq format-all-formatters
                                           '("HTML/XHTML/XML" (tidy)))))
         )
  :hook (
         (web-mode . format-all-mode)
         (web-mode . eglot-ensure)
         ))

(use-package cargo-mode
  :ensure t)

(use-package rustic
  :ensure t
  :after (eglot format-all flycheck cargo-mode)
  :mode "\\.rs\\'"
  :hook (
         (rustic-mode . (lambda () (setq format-all-formatters
                                       '("Rust" (rustfmt)))))
         (rustic-mode . cargo-minor-mode)
         (rustic-mode . format-all-mode)
         (rustic-mode . eglot-ensure)
         )
  :config
  (setq rustic-lsp-client 'eglot
        rustic-format-on-save t)
  (add-to-list 'eglot-server-programs '(rustic-mode . ("rust-analyzer"))))

(use-package python-mode
  :ensure nil
  :after (eglot format-all flycheck)
  :mode "\\.py\\'"
  :hook (
         (python-mode . (lambda () (setq format-all-formatters
                                         '("Python" (black)))))
         (python-mode . format-all-mode)
         (python-mode . eglot-ensure)
         )
  :config
  (add-to-list 'eglot-server-programs '(python-mode . ("pyright"))))

(use-package typst-ts-mode
  :ensure t
  :after (eglot format-all flycheck tree-sitter-langs)
  :mode "\\.typ\\'"
  :hook (
         (typst-ts-mode . eglot-ensure)
         )
  :config
  (add-to-list 'eglot-server-programs
               `((typst-ts-mode) .
                 ,(eglot-alternatives `("tinymist")))))
