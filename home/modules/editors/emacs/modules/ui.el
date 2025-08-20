(setq inhibit-startup-message t) ;Remove annoying startup message
(scroll-bar-mode -1) ;Remove scroll bar
(tool-bar-mode -1) ;Remove tool bar
(menu-bar-mode -1) ;Remove menu bar
(setq visible-bell t) ;Flash upon error
(set-fringe-mode 10) ;Expand fringe
(column-number-mode) ;Display numbers on columns
(add-hook #'prog-mode-hook #'display-line-numbers-mode) ;Display current line number on very left column in all buffers

;; Frame modification
(set-frame-parameter nil 'alpha-background 85)
(add-to-list 'default-frame-alist '(alpha-background . 85))

;Theme
;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   (setq doom-themes-enable-bold t)
;;   (setq doom-themes-enable-italic t)
;;   (doom-themes-visual-bell-config)
;;   (doom-themes-org-config))
(use-package ef-themes
  :ensure t
  :init
  (mapc #'disable-theme custom-enabled-themes)
  :config
  (ef-themes-select 'ef-dream))

;; (use-package doom-modeline
;;   :ensure t
;;   :config
;;   (doom-modeline-mode))

(use-package nerd-icons
  :ensure t
  :custom
  (nerd-icons-font-family "Terminess Nerd Font"))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package indent-bars
  :ensure t
  :hook (prog-mode . indent-bars-mode))

(global-prettify-symbols-mode)

(set-face-attribute 'default nil :family "Terminess Nerd Font" :height 180)
(set-face-attribute 'italic nil :family "3270 Nerd Font" :height 175)
