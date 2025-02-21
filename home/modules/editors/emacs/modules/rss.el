(use-package elfeed
  :ensure t
  :config
  (setq elfeed-search-set-filter "@2-weeks-ago -junk +unread"))

(use-package elfeed-org
  :ensure t
  :after elfeed)
