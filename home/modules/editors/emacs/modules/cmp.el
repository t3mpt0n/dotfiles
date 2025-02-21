(use-package helm
  :ensure t
  :hook (elpaca-after-init . helm-mode)
  :bind (("M-x" . helm-M-x)
         ("C-x r b" . helm-filtered-bookmarks)
         ("C-x C-f" . helm-find-files))
  :config
  (general-define-key
   :states 'normal
   :prefix t3mpt0n/leader
   "f f" '(helm-find-files :which-key "Find Files")
   "f r" '(helm-recentf :which-key "Recent Files")
   "SPC" '(helm-M-x :which-key "M-x")
   "B l" '(helm-filtered-bookmarks :which-key "List Bookmarks")))

(use-package corfu
  :ensure t
  :hook (elpaca-after-init . global-corfu-mode))

(use-package emacs
  :ensure nil
  :custom
  (tab-always-indent 'complete)
  (text-mode-ispell-word-completion nil)
  (read-extended-command-predicate #'command-completion-default-include-p))
