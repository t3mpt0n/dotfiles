;;; Code:
(leaf dired
  :straight all-the-icons-dired
  :hook (dired-mode-hook . all-the-icons-dired-mode)
  :setq
  (dired-kill-when-opening-new-dired-buffer . t))

(leaf pdf-tools
  :straight t
  :config
  (pdf-tools-install))
