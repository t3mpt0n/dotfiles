;;; ...  -*- lexical-binding: t -*-

(leaf magit
  :straight t)

(leaf pinentry
  :straight t
  :setq (epa-pinentry-mode . 'loopback)
  :config
  (pinentry-start))
