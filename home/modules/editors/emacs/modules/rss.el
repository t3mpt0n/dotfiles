(use-package elfeed
  :ensure t
  :defer t
  :bind ("C-; r" . elfeed)
  :config
  (setq-default elfeed-search-filter "@2-weeks-ago -junk +unread"))

(use-package elfeed-org
  :ensure t
  :demand t
  :after elfeed
  :config
  (elfeed-org)
  :custom
  (rmh-elfeed-org-files (list "~/Docs/Org/FEEDS.org")))

(use-package elfeed-goodies
  :ensure t
  :after elfeed
  :defer t
  :config
  (elfeed-goodies/setup))

(use-package elfeed-tube
  :ensure t
  :after elfeed
  :demand t
  :bind (:map elfeed-show-mode-map
         ("F" . elfeed-tube-fetch)
         ([remap save-buffer] . elfeed-tube-save)
         :map elfeed-search-mode-map
         ("F" . elfeed-tube-fetch)
         ([remap save-buffer] . elfeed-tube-save))
  :config
  (elfeed-tube-setup))

(use-package elfeed-tube-mpv
  :ensure t
  :after elfeed-tube
  :bind (:map elfeed-show-mode-map
              ("C-c C-f" . elfeed-tube-mpv-follow-mode)
              ("C-c C-w" . elfeed-tube-mpv-where)))
