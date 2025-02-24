(setq-default indent-tabs-mode nil)
(setq next-line-add-newlines t)
(defconst t3mpt0n/leader "C-;")
(show-paren-mode 1)
(use-package general :ensure t
  :config
  (general-define-key
   :prefix t3mpt0n/leader
   "C-w" '(:which-key "Windows")
   "C-w C-n" '(windmove-down :which-key "Move down")
   "C-w C-p" '(windmove-up :which-key "Move up")
   "C-w C-b" '(windmove-left :which-key "Move left")
   "C-w C-f" '(windmove-right :which-key "Move right")
   "C-w C-v" '(split-window-horizontally :which-key "Split Vertcally")
   "C-w C-s" '(split-window-vertically :which-key "Split Horizontally")))

(use-package which-key
  :ensure nil
  :config
  (which-key-mode))

(use-package smartparens
  :ensure t
  :hook ((prog-mode text-mode markdown-mode) . smartparens-mode)
  :config
  (require 'smartparens-config))






