(use-package company
  :init
  (global-company-mode)

  :config
  (push 'company-files company-backends)
  (define-key company-mode-map [remap indent-for-tab-command] #'company-indent-or-complete-common))

(use-package tree-sitter
  :init (global-tree-sitter-mode))

(use-package tree-sitter-langs :after tree-sitter)
(use-package tree-sitter-indent :after tree-sitter)

(use-package flycheck
  :init
  (global-flycheck-mode))

(use-package flycheck-color-mode-line
  :after flycheck
  :hook (flycheck-mode . flycheck-color-mode-line-mode))
(use-package flycheck-pos-tip :after flycheck)

(use-package magit
  :after general
  :config
  (general-def
    :states '(normal visual)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC"
    "g" '(:which-key "Magit")
    "g S" '(magit-status :which-key "Magit Status")
    "g s" '(:which-key "Staging")
    "g s f" '(magit-stage-file :which-key "Stage Current File")
    "g b" '(:which-key "Branch")
    "g b c" '(magit-branch-create :which-key "Create")
    "g b d" '(magit-branch-delete :which-key "Delete")
    "g c" '(magit-commit :which-key "Commit")))

(use-package smartparens
  :init
  (smartparens-global-mode 1)
  (show-smartparens-global-mode 1))

(use-package rainbow-delimiters ;; Colorful Parantheses
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/Docs/YASnippet/snippets"))
  (yas-global-mode 1))

(use-package eglot
  :hook
  (prog-mode . lunarix-mode)
  (prog-mode . disable-tabs)

  :config (setq debug-on-error t)
  :custom (defalias 'eglot--major-mode 'eglot--major-modes))

(use-package nix-mode
  :mode "\\.nix\\'"
  :interpreter "nix"
  :after (eglot smartparens tree-sitter tree-sitter-langs)
  :hook
  (nix-mode . eglot-ensure)
  :config
  (push '(nix-mode . ("nil")) eglot-server-programs)
  (sp-with-modes 'nix-mode
    (sp-local-pair "\"" "\"")
    (sp-local-pair "{" "};" :unless '(sp-in-comment-p
                                      sp-in-string-quotes-p))
    (sp-local-pair "[" "];" :unless '(sp-in-comment-p
                                      sp-in-string-quotes-p))))

(use-package emacs
  :after (general company)
  :elpaca nil
  :config
  (push 'company-elisp company-backends)
  (general-def
    :states '(normal visual)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC"
    "e"   '(:which-key "Elisp")
    "e b" '(eval-buffer :which-key "Eval Elisp in Buffer")
    "e d" '(eval-defun :which-key "Eval Defun")
    "e e" '(eval-expression :which-key "Eval Elisp Expression")
    "e l" '(eval-last-sexp :which-key "Eval Last Expression")
    "e r" '(eval-region :which-key "Eval Region")))

(use-package sh-script
  :elpaca nil
  :after eglot
  :hook
  (sh-mode . eglot-ensure))

(use-package python-mode
  :after eglot
  :hook
  (python-mode . eglot-ensure)

  :config
  (push '(python-mode . "jedi-language-server") eglot-server-programs))

(use-package jedi-core :after python-mode)

(use-package company-jedi
  :after company
  :init
  (push 'company-jedi company-backends))

(use-package robe)
(use-package ruby-mode
  :elpaca nil
  :after (eglot robe)
  :init
  (push '(ruby-mode . robe-mode) major-mode-remap-alist)

  :hook
  (robe-mode . eglot-ensure)
  (robe-mode . tree-sitter-hl-mode)

  :config
  (push 'company-robe company-backends))

(use-package crystal-mode
  :after eglot
  :hook (crystal-mode . eglot-ensure)
  :config (push '(crystal-mode . ("crystalline")) eglot-server-programs))

(use-package flycheck-crystal :after crystal-mode)
(use-package inf-crystal :after crystal-mode)

(use-package ameba
  :after crystal-mode
  :init (flycheck-ameba-setup))
(use-package flycheck-ameba :after ameba)

(use-package typst-ts-mode
  :after (eglot tree-sitter tree-sitter-langs company)
  :mode "\\.typ\\'"
  :interpreter "typst"
  :hook (typst-ts-mode . eglot-ensure)
  :elpaca
  (
   :repo "https://git.sr.ht/~meow_king/typst-ts-mode"
   :branch "main"
   :protocol https
   :main "typst-ts-mode.el"
   :files (:defaults "highlight.compare.scm")
   )

  :config
  (push '(typst "https://github.com/uben0/tree-sitter-typst") treesit-language-source-alist)
  (push '(typst-ts-mode . ("typst-lsp")) eglot-server-programs))
