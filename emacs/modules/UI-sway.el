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
