(use-package pdf-tools :ensure t)
(use-package dirvish
  :ensure t
  :after pdf-tools
  :hook (elpaca-after-init . dirvish-override-dired-mode)
  :config
  (setq dirvish-attributes '(
                             vc-state
                             subtree-state
                             collapse
                             git-msg
                             file-time
                             file-size
                             ))
  (general-define-key
   :states 'normal
   :prefix t3mpt0n/leader
   "d" '(:which-key "Dirvish")
   "d d" '(dirvish :which-key "Open Dirvish in current directory")))
