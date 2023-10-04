(use-package company
  :hook
  (after-init . global-company-mode)

  :config
  (setq company-backends (list company-files))
  (define-key company-mode-map [remap indent-for-tab-command] #'company-indent-or-complete-common))

(use-package tree-sitter
  :init (global-tree-sitter-mode)
  :config (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist)))

(use-package flycheck
  :init
  (elpaca-after-init . global-flycheck-mode))

(use-package flycheck-color-mode-line
  :after flycheck
  :hook (flycheck-mode . flycheck-color-mode-line-mode))
(use-package flycheck-pos-tip :after flycheck)

(use-package magit
  :config
  (t3mpt0n/leader-keys
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

(use-package elec-pair
  :after smartparens
  :hook
  (prog-mode . electric-pair-local-mode)
  (smartparens-mode . (lambda () electric-pair-local-mode -1)))

(use-package parens
  :after smartparens
  :hook
  (prog-mode . show-paren-mode)
  (smartparens-mode . (lambda () show-paren-mode -1)))

(use-package rainbow-delimiters ;; Colorful Parantheses
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package eglot
  :hook
  (prog-mode . lunarix-mode)
  (prog-mode . disable-tabs)

  :config (setq debug-on-error t)
  :custom (defalias 'eglot--major-mode 'eglot--major-modes))

(use-package nix-mode
  :after eglot
  :hook
  (nix-mode . eglot-ensure)
  (nix-mode . tree-sitter-hl-mode)
  :config
  (push '(nix-mode . ("nil")) eglot-server-programs)
  (push 'company-nixos-options company-backends)
  (sp-with-modes 'nix-mode
    (sp-local-pair "\"" "\"")
    (sp-local-pair "{" "};" :unless '(sp-in-comment-p
                                      sp-in-string-quotes-p))
    (sp-local-pair "[" "];" :unless '(sp-in-comment-p
                                      sp-in-string-quotes-p))))

(push 'company-elisp company-backends)

(t3mpt0n/leader-keys
  "e"   '(:which-key "Eval")
  "e b" '(eval-buffer :which-key "Eval Elisp in Buffer")
  "e d" '(eval-defun :which-key "Eval Defun")
  "e e" '(eval-expression :which-key "Eval Elisp Expression")
  "e l" '(eval-last-sexp :which-key "Eval Last Expression")
  "e r" '(eval-region :which-key "Eval Region"))

(use-package sh-script
  :after eglot
  :hook
  (sh-mode . eglot-ensure))

(use-package python-mode
  :after eglot
  :hook
  (python-mode . eglot-ensure)
  (python-mode . tree-sitter-hl-mode)

  :config
  (push '(python-mode . "jedi") eglot-server-programs)
  (push '(python "https://github.com/tree-sitter/tree-sitter-python") treesit-language-source-alist))

(use-package jedi-core :after python-mode)

(use-package company-jedi
  :after company
  :init
  (push 'company-jedi company-backends))

(use-package robe)
(use-package ruby-mode
  :after (eglot robe)
  :init
  (push '(ruby-mode . robe-mode) major-mode-remap-alist)

  :hook
  (robe-mode . eglot-ensure)
  (robe-mode . tree-sitter-hl-mode)

  :config
  (push 'company-robe company-backends)
  (push '(ruby "https://github.com/tree-sitter/tree-sitter-ruby") treesit-language-source-alist))

(use-package crystal-mode
  :after eglot
  :hook (crystal-mode . eglot-ensure)
  :config (push '(crystal-mode . ("crystalline") eglot-server-programs)))

(use-package flycheck-crystal :after crystal-mode)
(use-package inf-crystal :after crystal-mode)

(use-package ameba
  :after crystal-mode
  :init (flycheck-ameba-setup))
(use-package flycheck-ameba :after ameba)

(use-package org-src
  :hook (org-src-mode . eglot-ensure))
