;;; ...  -*- lexical-binding: t -*-

(leaf t3mpt0n/delimiters
  :straight rainbow-delimiters
  :hook
  (prog-mode-hook . rainbow-delimiters-mode)
  (prog-mode-hook . electric-pair-mode))

(leaf ivy/swiper/counsel
  :straight ivy swiper counsel
  :setq
  (ivy-use-virtual-buffers . t)
  (ivy-count-format . "(%d/%d) ")
  :config
  (ivy-mode 1)
  (counsel-mode 1))

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

(leaf company
  :straight t
  :setq
  (company-dabbrev-ignore-case . 'keep-prefix)
  (company-dabbrev-other-buffers . nil)
  (company-files-exclusions . '(".git/" ".DS_Store" ".devenv/" ".direnv/"))
  (company-idle-delay . 0)
  (company-tooltip-idle-delay . 1)
  :hook (after-init-hook . global-company-mode))

(leaf t3mpt0n/yasnippet
  :require company
  :straight yasnippet yasnippet-snippets
  :config
  (yas-global-mode 1)
  (add-to-list 'company-backends '(company-capf :with company-yasnippet)))
