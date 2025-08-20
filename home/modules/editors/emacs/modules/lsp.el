(use-package eglot
  :ensure nil)

(use-package format-all
  :ensure t
  :commands format-all-mode
  :hook (prog-mode . format-all-mode))

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

(use-package direnv
  :ensure t
  :config
  (direnv-mode))

(use-package tree-sitter
  :ensure t
  :config
  (global-tree-sitter-mode))

(use-package tree-sitter-ispell :ensure t :after tree-sitter)
(use-package tree-sitter-langs :ensure t :after tree-siter)
(use-package tree-sitter-indent :ensure t :after tree-sitter)

(use-package websocket :ensure t)

(use-package nix-mode
  :ensure t)
(use-package nix-ts-mode
  :ensure t
  :requires nix-mode
  :mode ("\\.nix$" . nix-ts-mode)
  :hook (
         ((nix-mode nix-ts-mode) . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs '((nix-mode nix-ts-mode) . ("nixd" "--inlay-hints" :initializationOptions (:nixd (:nixpkgs (:expr "import (builtins.getFlake \"/etc/nixos\").inputs.nixpkgs")
                                                                         :formatting (:command [ "alejandra" ])
                                                                         :options (:nixos (:expr "(builtins.getFlake \"/etc/nixos\").nixosConfigurations.<name>.options")
                                                                                          :home-manager (:expr "(builtins.getFlake \"/etc/nixos\").nixosConfigurations.<name>.options.home-manager.users.type.getSubOptions []"))
                                                                         )))))
  )

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
  :requires flycheck
  :after (eglot format-all)
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
  :mode ("\\.py\\'" . python-ts-mode)
  :hook ((python-mode python-ts-mode) . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '((python-mode python-ts-mode) . ("basedpyright-langserver" "--stdio"))))
(use-package flymake-ruff
  :ensure t
  :hook ((python-mode python-ts-mode) . flymake-ruff-load))

(use-package typst-ts-mode
  :ensure t
  :demand t
  :requires tree-sitter
  :after eglot
  :mode ("\\.typ\\'" . typst-ts-mode)
  :hook (typst-ts-mode . eglot-ensure)
  :config
  (keymap-set typst-ts-mode-map "C-c C-e" #'typst-ts-tmenu)
  (add-to-list 'eglot-server-programs '(typst-ts-mode . ("tinymist")))
  :custom
  (typst-ts-mode-watch-options "--open")
  (typst-ts-mode-enable-raw-blocks-highlight t)
  (typst-ts-mode-grammar-location (expand-file-name "tree-sitter/libtree-sitter-typst.so" user-emacs-directory)))


(use-package typst-preview
  :ensure (:type git
                 :host github
                 :repo "havarddj/typst-preview.el")
  :after (typst-ts-mode websocket)
  :bind (:map typst-preview-mode-map
              ("C-c C-j" . typst-preview-send-position))
  :config
  (setq typst-preview-browser "firefox"))

(use-package geiser-guile
  :ensure t
  :mode ("\\.scm\\'" . geiser-mode))

(use-package julia-mode :ensure t)
(use-package eglot-jl
  :ensure t
  :init
  (eglot-jl-init))
(use-package julia-repl
  :ensure t)
(use-package julia-ts-mode
  :ensure t
  :requires julia-mode
  :after eglot-jl
  :mode "\\.jl$"
  :hook (
         (julia-ts-mode . (lambda () (flymake-mode 1)))
         ((julia-mode julia-ts-mode) . eglot-ensure)
         )
  )
