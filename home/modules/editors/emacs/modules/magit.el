(use-package transient :ensure t)
(use-package magit
  :ensure t
  :after transient
  :bind (("C-x g" . magit-status)
         ("C-c g" . magit-dispatch)
         ("C-c f" . magit-file-dispatch)))
