  (use-package emacs
    :elpaca nil
    :init
    (setq inhibit-startup-message t
          visible-bell t
          frame-resize-pixelwise t
          package-native-compile t)
    (scroll-bar-mode -1)
    (tool-bar-mode -1)
    (tooltip-mode -1)
    (set-fringe-mode 10)
    (menu-bar-mode -1)
    (global-prettify-symbols-mode 1)
    :hook
    (prog-mode . menu-bar--display-line-numbers-mode-relative)
    (org-mode . menu-bar--display-line-numbers-mode-relative)
    (find-file . (lambda () (set-face-attribute 'default nil :font t3mpt0n/font :height 148))))

  (if (and (= (string-search "FiraCode" t3mpt0n/font) 0) (> emacs-major-version 28))
        (use-package fira-code-mode
          :after emacs
          :hook prog-mode
          :custom (fira-code-mode-disabled-ligatures '("www" ":" "*" "x" "&&")))
    (use-package ligature
      :after emacs
      :config
      (ligature-set-ligatures 't '("www"))
      (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                           ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                           "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                           "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                           "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                           "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                           "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                           "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                           ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                           "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                           "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                           "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                           "\\\\" "://"))
      (global-ligature-mode t)))
(defun t3mpt0n/prog-mode/customligs ()
  "Custom Ligatures for prog-mode"
  (mapc (lambda (pair) (push pair prettify-symbols-alist))
        '(
          ("defun" . #x1d453)
          ("def" . #x1d453)
          ("or" . #x2228)
          ("||" . #x2228)
          ("&&" . #x2227)
          ("and" . #x2227)
          ("in" . #x2208)
          ("true" . #x22a5)
          ("false" . #x22a4)
          ("int" . #x2124)
          ("float" . #x211d)
          ("not" . #xac)
          ("from" . #x21a6)
          ("import" . #x21a7))))

  (use-package all-the-icons)
  (use-package all-the-icons-nerd-fonts :after all-the-icons)
  (use-package nerd-icons)
  (use-package nerd-icons-completion :after nerd-icons)
  (use-package emojify
    :hook (elpaca-after-init . global-emojify-mode))

  (use-package spaceline
    :init
    (setq powerline-default-seperator nil
          spacemacs-theme-underline-parens t))

  (use-package spaceline-all-the-icons
    :after (all-the-icons all-the-icons-nerd-fonts))

  (use-package doom-themes
    :init
    (progn
      (load-theme 'doom-tomorrow-night t)
      (enable-theme 'doom-tomorrow-night)))

  (use-package doom-modeline
    :init (doom-modeline-mode 1))

  (use-package counsel
    :bind (
     ("M-x" . counsel-M-x)
     ("C-x b" . counsel-ibuffer)
     ("C-x C-f" . counsel-find-file)))

  (use-package prescient
    :config (setq prescient-persist-mode t))

  (use-package ivy
    :diminish
    :bind (("C-s" . swiper)))

  (use-package ivy-prescient
    :after counsel
    :config
    (ivy-prescient-mode 1))

  (use-package ivy-rich
    :init
    (ivy-rich-mode 1))

  (use-package vertico
    :init
    (vertico-mode))

  (use-package savehist
    :elpaca nil
    :init
    (savehist-mode))

  (use-package marginalia
    :after vertico
    :demand t
    :custom
    (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
    :init
    (marginalia-mode))

  (use-package shackle
    :demand t
    :config
    (setq frame-title-format '("%b — GNU Emacs [" (:eval (frame-parameter (selected-frame) 'window-id)) "]"))
    (add-to-list 'default-frame-alist '(alpha-background . 90)))

  (use-package sway
    :config
    (sway-socket-tracker-mode)
    (sway-undertaker-mode)
    (sway-x-focus-through-sway-mode))
