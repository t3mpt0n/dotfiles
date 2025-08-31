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

(use-package nix-ts-mode
  :ensure t
  :mode ("\\.nix$" . nix-ts-mode)
  :hook (
         (nix-ts-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs '(nix-ts-mode . ("nixd" "--inlay-hints" :initializationOptions (:nixd (:nixpkgs (:expr "import (builtins.getFlake \"/etc/nixos\").inputs.nixpkgs")
                                                                         :formatting (:command [ "alejandra" ])
                                                                         :options (:nixos (:expr "(builtins.getFlake \"/etc/nixos\").nixosConfigurations.<name>.options")
                                                                                          :home-manager (:expr "(builtins.getFlake \"/etc/nixos\").nixosConfigurations.<name>.options.home-manager.users.type.getSubOptions []"))
                                                                         ))))))

(use-package zigger
  :ensure zig-mode zig-ts-mode
  :mode ("\\.zig$" . zig-ts-mode)
  :hook ((zig-ts-mode . eglot-ensure)
         (zig-ts-mode . (lambda ()
                       (add-hook 'before-save-hook
                                 (lambda ()
                                   (eglot-code-actions nil nil "source.fixAll" t))))))
  :config
  (add-to-list 'eglot-server-programs '(zig-ts-mode . ("zls"))))

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

(use-package t3mpt0n/rust-ide
  :ensure rustic cargo-mode flycheck-rust rust-mode
  :mode ("\\.rs$" . rustic-mode) 
  :hook ((rustic-mode . cargo-minor-mode)
         (rustic-mode . eglot-ensure)
         (rustic-mode . rustic-mode-auto-save-hook)
         (flycheck-mode . flycheck-rust-setup))
  :init
    (defun rustic-mode-auto-save-hook ()
    "Enable auto-saving in rustic-mode buffers."
    (when buffer-file-name
      (setq-local compilation-ask-about-save nil)))
  (setq rust-mode-treesitter-derive t)
  :config
  (setq rustic-lsp-client 'eglot
        rustic-format-on-save t)
  (push 'rustic-clippy flycheck-checkers)
  (add-to-list 'eglot-server-programs '(rustic-mode . ("rust-analyzer")))
  :custom
  (rustic-format-trigger 'on-save))

(use-package t3mpt0n/python-ide
  :ensure pyenv-mode anaconda-mode python-black company-anaconda
  :init
  (add-hook 'completion-at-point-functions (cape-company-to-capf #'company-anaconda))
  :mode
  ("\\.py\\'" . python-ts-mode)
  :hook ((python-ts-mode . (lambda ()
                             (progn
                               (flycheck-mode 1)
                               (anaconda-mode)
                               (anaconda-eldoc-mode)
                               (python-black-on-save-mode)))))
  :config
  (add-to-list 'eglot-server-programs '((python-mode python-ts-mode) . ("basedpyright-langserver" "--stdio"))))

(use-package geiser-guile
  :ensure t
  :mode ("\\.scm\\'" . geiser-mode))

;; Minimal Julia IDE
(use-package t3mpt0n/julia-ide
  :ensure julia-mode eglot-jl julia-repl julia-ts-mode
  :init
  (eglot-jl-init)
  :mode ("\\.jl$" . julia-ts-mode)
  :hook (julia-ts-mode . eglot-ensure))
