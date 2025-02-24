(defvar t3mpt0n/font "GeistMono Nerd Font")
(defvar t3mpt0n/font/size "16")
(defvar t3mpt0n/alpha 85)

(setq inhibit-startup-message t) ;Remove annoying startup message
(scroll-bar-mode -1) ;Remove scroll bar
(tool-bar-mode -1) ;Remove tool bar
(menu-bar-mode -1) ;Remove menu bar
(setq visible-bell t) ;Flash upon error
(set-fringe-mode 10) ;Expand fringe
(column-number-mode) ;Display numbers on columns
(add-hook #'prog-mode-hook #'display-line-numbers-mode) ;Display current line number on very left column in all buffers

;; Frame modification
(add-to-list 'default-frame-alist '(font . "GeistMono Nerd Font 14"))
(set-frame-parameter nil 'alpha-background t3mpt0n/alpha)

;Theme
(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)
  (load-theme 'doom-gruvbox t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :config
  (doom-modeline-mode))

(use-package nerd-icons
  :ensure t
  :custom
  (nerd-icons-font-family t3mpt0n/font))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package indent-bars
  :ensure t
  :hook (prog-mode . indent-bars-mode))

