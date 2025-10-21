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

(leaf prog/nix
  :straight nix-ts-mode nix-mode
  :mode ("\\.nix\\'" . nix-mode)
  :hook
  (nix-mode-hook . nix-ts-mode)
  (nix-ts-mode-hook . eglot-ensure)
  :setq
  (add-to-list 'eglot-server-programs '(nix-mode . ("nil"))))

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

(leaf prog/go
  :require project go-mode
  :mode ("\\.go\\'" . go-ts-mode)
  :init
  (defun project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

  (defun eglot-format-buffer-before-save ()
    (add-hook 'before-save-hook #'eglot-format-buffer -10 t))

  (cl-defmethod project-root ((project (head go-module)))
    (cdr project))
  
  :hook
  (project-find-functions . project-find-go-module)
  (go-ts-mode-hook . eglot-ensure)
  (go-ts-mode-hook . eglot-format-buffer-before-save)

  :config
  (add-to-list 'eglot-server-programs '(go-ts-mode . ("gopls" :initializationOptions (:gopls (:staticcheck t
                                                                                                           :matcher "CaseSensitive"))))))

(leaf markup/markdown
  :mode ("\\.md\\'" . markdown-mode)
  :hook (markdown-mode-hook . eglot-ensure)
  :config (add-to-list 'eglot-server-programs '(markdown-mode . "marksman")))

(leaf markup/tex
  :straight auctex
  :setq-default (TeX-master . nil)
  :setq
  (TeX-parse-self . t)
  (TeX-auto-save . t))

(leaf markup/mermaidjs
  :straight mermaid-mode
  :mode ("\\.mermaid\\'" . mermaid-mode))

(leaf markup/plantuml
  :straight plantuml-mode
  :mode ("\\.plantuml\\'" . plantuml-mode)
  :setq
  (plantuml-jar-path . "plantuml")
  (plantuml-default-exec-mode . 'jar)
  :config
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t))))

(leaf db/csv
  :straight csv-mode
  :mode ("\\.csv\\'" . csv-mode)
  :hook (csv-mode-hook . csv-guess-set-seperator))
