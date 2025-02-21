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
   "h" '(help-command :which-key "Help Functions")
   "o" '(:which-key "Open Commands")
   "f s" '(save-buffer :which-key "Save file")
   "f S" '(write-file :which-key "Save file as...")))
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
   "w" '(evil-window-map :which-key "Windows")
   "b d" '(evil-delete-buffer :which-key "Delete Buffer")
   "b +" '(evil-buffer-new :which-key "New Empty Buffer")
   "b p" '(evil-prev-buffer :which-key "Prev. Buffer")
   "b n" '(evil-next-buffer :which-key "Next Buffer")))

(use-package evil-collection
  :ensure t
  :after evil
  :hook (elpaca-after-init . evil-collection-init))

(use-package which-key
  :ensure nil
  :hook (elpaca-after-init . which-key-mode))

(use-package smartparens
  :ensure t
  :hook (prog-mode text-mode markdown-mode)
  :config
  (require 'smartparens-config))
