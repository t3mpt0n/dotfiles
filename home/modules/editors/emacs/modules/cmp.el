(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
         ("C-x r b" . helm-filtered-bookmarks)
         ("C-x C-f" . helm-find-files)
         ("C-; b m" . helm-buffers-list))
  :config
  (helm-mode 1))

(use-package corfu
  :ensure t
  :bind (:map corfu-map
              ("TAB" . corfu-next)
              ([tab] . corfu-next)
              ("S-TAB" . corfu-previous)
              ([backtab] . corfu-previous))
  :init
  (global-corfu-mode)
  :config
  (setq corfu-auto t)
  :custom
  (corfu-cycle t)
  (corfu-preselect 'prompt))
(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)
  (setq nerd-icons-corfu-mapping
        '((array :style "cod" :icon "symbol_array" :face font-lock-type-face)
          (boolean :style "cod" :icon "symbol_boolean" :face font-lock-builtin-face)
          (file :fn nerd-icons-icon-for-file :face font-lock-string-face)
          (t :style "cod" :icon "code" :face font-lock-warning-face))))

(use-package dabbrev
  :ensure nil
  :bind (
         ("M-/" . dabbrev-completion)
         ("C-M-/" . dabbrev-expand)
         )
  :config
  (add-to-list 'dabbrev-ignored-buffer-modes 'doc-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'tags-table-mode))

(use-package cape
  :ensure t
  :bind ("C-c p" . cape-prefix-map)
  :hook (
         (completion-at-point-functions . cape-dabbrev)
         (completion-at-point-functions . cape-file)
         (completion-at-point-functions . cape-keyword)
         (completion-at-point-functions . cape-dict)
         )
  :config
  )

(use-package emacs
  :ensure nil
  :config
  (electric-pair-mode 1)
  :custom
  (tab-always-indent 'complete)
  (text-mode-ispell-word-completion nil)
  (read-extended-command-predicate #'command-completion-default-include-p))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  (setq yas-snippet-dirs '("~/.emacs.d/snippets")))

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1))


