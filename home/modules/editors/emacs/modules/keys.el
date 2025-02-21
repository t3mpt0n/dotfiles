(setq-default indent-tabs-mode nil)
(defconst t3mpt0n/leader "SPC")
(show-paren-mode 1)
(use-package general :ensure t
  :config
  (general-define-key
   :states 'normal
   :prefix t3mpt0n/leader
   "f" '(:which-key "Files")
   "B" '(:which-key "Bookmarks")
   "b" '(:which-key "Buffers")
   "h" '(help-command :which-key "Help Functions")))
(use-package evil
  :ensure t
  :after general
  :hook (elpaca-after-init . evil-mode)
  :config
  (setq evil-shift-width 2
        evil-undo-system 'undo-redo)
  (general-evil-setup)

  (general-define-key
   :states 'normal
   :prefix t3mpt0n/leader
   "w" '(evil-window-map :which-key "Windows")))

(use-package which-key
  :ensure nil
  :hook (elpaca-after-init . which-key-mode))

(use-package smartparens
  :ensure t
  :hook (prog-mode text-mode markdown-mode)
  :config
  (require 'smartparens-config))
