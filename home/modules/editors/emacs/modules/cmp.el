(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
         ("C-x r b" . helm-filtered-bookmarks)
         ("C-x C-f" . helm-find-files))
  :config
  (helm-mode 1)
  (general-define-key
   :states '(normal emacs)
   :prefix t3mpt0n/leader
   "f f" '(helm-find-files :which-key "Find Files")
   "f r" '(helm-recentf :which-key "Recent Files")
   "SPC" '(helm-M-x :which-key "M-x")
   "B l" '(helm-filtered-bookmarks :which-key "List Bookmarks")
   "b m" '(helm-buffers-list :which-key "Buffer Menu")))

(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)
  (corfu-preselect 'prompt)
  :bind (:map corfu-map
              ("<tab>" . corfu-next)
              ("C-<tab>" . corfu-previous))
  :config
  (global-corfu-mode))

(use-package cape
  :ensure t
  :bind ("C-c p" . cape-prefix-map)
  :hook (
         (completion-at-point-functions . cape-dabbrev)
         (completion-at-point-functions . cape-file)
         (completion-at-point-functions . cape-elisp-block)
         ))

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
