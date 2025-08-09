(use-package pdf-tools
  :ensure t
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (pdf-tools-install))

(use-package dirvish
  :ensure t
  :after pdf-tools
  :config
  (dirvish-override-dired-mode)
  (setq dirvish-attributes '(
                             vc-state
                             subtree-state
                             collapse
                             git-msg
                             file-time
                             file-size
                             )))
