;;; ...  -*- lexical-binding: t -*-

(leaf t3mpt0n/theme
  :straight catppuccin-theme
  :config
  (load-theme 'catppuccin :no-confirm)
  :setq (catppuccin-flavor . 'mocha)
  :defer-config (catppuccin-reload))

(leaf t3mpt0n/font
  :straight ligature all-the-icons
  :config
  (add-to-list 'default-frame-alist '(width . 120))
  (add-to-list 'default-frame-alist '(height . 65))
  (add-to-list 'default-frame-alist '(font . "Cascadia Code NF 15"))
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
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
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t)
  (global-visual-line-mode +1))

(leaf t3mpt0n/transparency
  :straight nil
  :config
  (set-frame-parameter nil 'alpha-background 85) ; For current frame
  (add-to-list 'default-frame-alist '(alpha-background . 85)) ; For all new frames henceforth
  )

(leaf t3mpt0n/modeline
  :straight doom-modeline
  :setq
  (doom-modeline-time-icon . nil)
  :config (doom-modeline-mode 1))

(leaf t3mpt0n/line-numbers
  :straight nil
  :hook (prog-mode-hook . display-line-numbers-mode))

(leaf which-key
  :straight nil
  :config
  (which-key-mode)
  :setq (which-key-idle-delay . 0.1))

(leaf marginalia
  :straight t
  :bind (:minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init (marginalia-mode))
