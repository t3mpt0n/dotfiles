(use-package transient :ensure t)
(use-package magit
  :ensure t
  :after transient
  :bind (
         ("C-; g" . magit-dispatch)))
