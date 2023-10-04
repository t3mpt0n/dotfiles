(use-package vterm
  :config
  (setq shell-file-name "/run/current-system/sw/bin/fish"
        vterm-max-scrollback 5000))

(use-package multi-vterm :after vterm)

(use-package recentf
  :init
  (recentf-mode)

  :config
  (t3mpt0n/leader-keys
    "f r" '(counsel-recentf :which "Recent Files")))

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
