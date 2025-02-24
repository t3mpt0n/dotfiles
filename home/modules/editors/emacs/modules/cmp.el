(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
         ("C-x r b" . helm-filtered-bookmarks)
         ("C-x C-f" . helm-find-files))
  :config
  (helm-mode)
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
  :config
  (global-corfu-mode))

(use-package emacs
  :ensure nil
  :custom
  (tab-always-indent 'complete)
  (text-mode-ispell-word-completion nil)
  (read-extended-command-predicate #'command-completion-default-include-p))
