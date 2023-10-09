(use-package vterm
  :after general
  :config
  (setq shell-file-name "/run/current-system/sw/bin/fish"
        vterm-max-scrollback 5000)
  (general-def
    :states '(normal visual)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC"
    "O" '(:which-key "Open Misc. Programs")))

(use-package multi-vterm
  :after vterm
  :config
  (general-def
    :states '(normal visual)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC"
    "O v" '(multi-vterm :which-key "Open new Vterm buffer")))

(use-package recentf
  :elpaca nil
  :init
  (recentf-mode))

(use-package projectile
  :init
  (projectile-mode +1)

  :bind (:map projectile-mode-map
    ("C-c p" . projectile-command-map))

  :config
  (setq projectile-sort-order 'recentf
        projectile-enable-caching t
        projectile-file-exists-remote-cache-expire (* 10 60)
        projectile-completion-system 'ivy
        projectile-switch-project-action #'projectile-dired))
