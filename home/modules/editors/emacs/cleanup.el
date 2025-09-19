;;; ...  -*- lexical-binding: t -*-

(leaf t3mpt0n/cleanup-files
  :straight nil
  :setq
  (backup-directory-alist . '(("." . "~/.config/emacs/backup")))
  (backup-by-copying . t)
  (version-control . t)
  (delete-old-versions . t)
  (kept-old-versions . 5)
  (kept-new-versions . 10)
  (create-lockfiles . nil))
