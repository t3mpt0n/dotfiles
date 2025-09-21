;;; -*- lexical-binding: t -*-

(leaf t3mpt0n/flycheck-setup
  :straight flycheck flycheck-eglot
  :after eglot
  :hook
  (after-init-hook . global-flycheck-mode))

(leaf direnv
  :straight t
  :config (direnv-mode))

(leaf projectile
  :straight t
  :bind ("C-c p" . projectile-command-map)
  :setq (projectile-known-projects-file . "~/.local/share/emacs/projectile-bookmarks.eld")
  :config (projectile-mode +1))

(leaf t3mpt0n/nix-setup
  :straight nix-mode nix-ts-mode
  :mode ("\\.nix\\'" . nix-ts-mode)
  :hook
  (nix-ts-mode-hook . eglot-ensure)
  (nix-ts-mode-hook . flycheck-eglot-mode)
  :config
  (add-to-list 'eglot-server-programs '(nix-ts-mode . ("nil" :initializationOptions (
                                                                                     :nil (:formatting (:command ["nixfmt"])
                                                                                                       :nix (:flake (:autoArchive t
                                                                                                                                  :autoEvalInputs t
                                                                                                                                  :nixpkgsInputName "nixpkgs"))))))))

(leaf t3mpt0n/yaml-setup
  :straight yaml-pro prettier-js
  :mode
  ("\\.yaml\\'" . yaml-ts-mode)
  ("\\.yaml\\'" . yaml-pro-ts-mode)
  ("\\.yaml\\'" . prettier-js-mode)
  :setq (prettier-js-use-modules-bin . t)
  :config
  (add-to-list 'eglot-server-programs '((yaml-ts-mode yaml-pro-ts-mode) . ("yaml-language-server"))))
