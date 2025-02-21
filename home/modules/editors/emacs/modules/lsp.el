(use-package eglot
  :ensure nil
  :hook (prog-mode . eglot-ensure))

(use-package nix-mode
  :ensure t
  :after eglot
  :config
  (add-to-list 'eglot-server-programs '(nix-mode . ("nixd")))
  ((nix-mode . ((eglot-workspace-configuration . (
                                                  :formatting (:command ["alejandra"])
                                                              ))))))
