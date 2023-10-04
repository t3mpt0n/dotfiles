(setq-default user-emacs-directory "/etc/nixos/modules/emacs")
(let ((default-directory (expand-file-name "modules" user-emacs-directory)))
  (normal-top-level-add-subdirs-to-load-path))
