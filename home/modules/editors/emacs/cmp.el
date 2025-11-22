;;; ...  -*- lexical-binding: t -*-

(leaf t3mpt0n/delimiters
  :straight rainbow-delimiters
  :hook
  (prog-mode-hook . rainbow-delimiters-mode)
  (prog-mode-hook . electric-pair-mode))

(leaf consult
  :straight t
  :hook (completion-list-mode-hook . consult-preview-at-point-mode))

(leaf marginalia
  :straight t
  :config (marginalia-mode))

(leaf savehist
  :straight t
  :init
  (savehist-mode))

(leaf vertico
  :straight t
  :init
  (vertico-mode))

(leaf embark
  :straight t
  :bind (("C-." . embark-act)
         ("C-;" . embark-dwim)
         ("C-h B" . embark-bindings))

  :config
  (setq prefix-help-command #'embark-prefix-help-command)

  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(leaf embark-consult
  :straight t
  :hook
  (embark-collect-mode-hook . consult-preview-at-point-mode))

(leaf orderless
  :straight t
  :custom
  (completion-styles . '(orderless basic))
  (completion-category-overrides . '((file (styles partial-completion))))
  (completion-category-defaults . nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard . t)) ;; Emacs 31: partial-completion behaves like substring

(leaf multiple-cursors
  :straight t
  :bind ("C-S-c C-S-c" . 'mc/edit-lines))

(leaf corfu
  :straight t
  :custom
  (corfu-auto . t)
  :init (global-corfu-mode))

(leaf t3mpt0n/yasnippet
  :straight yasnippet yasnippet-snippets
  :config
  (yas-global-mode 1))
