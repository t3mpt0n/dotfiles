;;; -*- lexical-binding: t -*-
;;; Code:
;; (leaf t3mpt0n/lsp-setup
;;   :require ivy company which-key
;;   :straight lsp-mode lsp-ui lsp-ivy dap-mode
;;   :hook (lsp-mode-hook . lsp-enable-which-key-integration)
;;   :bind
;;   ("C-c o l" . org-store-link)
;;   ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
;;   ([remap xref-find-references] . lsp-ui-peek-find-references)
;;   :setq
;;   (lsp-keymap-prefix . "C-c l")
;;   (lsp-keep-workspace-alive . nil)
;;   (lsp-headerline-breadcrumb-segments . '(path-up-to-project file symbols)))

(leaf flycheck
  :straight t
  :hook
  (after-init-hook . global-flycheck-mode))

(leaf direnv
  :straight t
  :config (direnv-mode))

(leaf projectile
  :straight t
  :bind ("C-c p" . projectile-command-map)
  :config (projectile-mode +1))

(leaf t3mpt0n/nix-setup
  :straight nix-ts-mode
  :mode ("\\.nix\\'" . nix-ts-mode)
  :hook
  (nix-ts-mode-hook . eglot-ensure)
  :setq
  (add-to-list 'eglot-server-programs '(nix-ts-mode . ("nil"))))

(leaf rust-mode
  :straight t
  :setq (rust-mode-treesitter-derive . t))
(leaf rustic
  :straight t
  :after rust-mode
  :mode
  ("\\.rs\\'" . rust-mode)
  ("\\.rs\\'" . rustic-mode)
  :hook
  (eglot--managed-mode-hook . (lambda () (flymake-mode -1)))
  :setq
  (rustic-format-on-save . t)
  (rustic-lsp-client . 'eglot)
  :custom (rustic-cargo-use-last-stored-arguments . t))

(leaf clojure-mode
  :straight t
  :hook ((clojure-mode clojurec-mode clojurescript-mode) . eglot-ensure)
  :config
  (dolist (m '(clojure-mode clojurec-mode clojurescript-mode clojurex-mode))
    (add-to-list 'eglot-server-programs `(,m . "clojure-lsp"))))

(leaf t3mpt0n/python-setup
  :straight elpy
  :mode ("\\.py\\'" . python-ts-mode)
  :init (elpy-enable)
  :hook
  (python-ts-mode-hook . eglot-ensure)
  (python-ts-mode-hook . elpy-mode)
  (elpy-mode-hook . flycheck-mode)
  (elpy-mode-hook . (lambda ()
                      (add-hook 'before-save-hook
                                'elpy-black-fix-code nil t)))
  :setq (elpy-modules . (delq 'elpy-module-flymake elpy-modules))
  :config
  (add-to-list 'eglot-server-programs '(python-ts-mode . "basedpyright-langserver"))
  (add-to-list 'company-backends '(elpy-company-backend :with company-yasnippet)))

(leaf prog/markdown
  :mode ("\\.md\\'" . markdown-mode)
  :hook (markdown-mode-hook . eglot-ensure)
  :config (add-to-list 'eglot-server-programs '(markdown-mode . "marksman")))
