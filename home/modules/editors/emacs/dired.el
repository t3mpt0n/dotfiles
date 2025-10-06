;;; Code:
(leaf dired
  :doc "Convient Dired."
  :straight all-the-icons-dired
  :hook (dired-mode-hook . all-the-icons-dired-mode)
  :setq
  (dired-kill-when-opening-new-dired-buffer . t))

(leaf pdf-tools
  :doc "Hastle-less PDF Management."
  :straight t
  :config
  (pdf-tools-install))

(leaf nov
  :straight t
  :mode ("\\.epub\\'" . nov-mode))
