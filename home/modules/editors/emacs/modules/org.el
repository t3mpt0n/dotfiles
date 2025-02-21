(use-package org
  :ensure nil
  :config
  (setq org-directory "~/Documents/Org"
        org-agenda-files '(
                           "~/Documents/Org/Agenda/"
                           )
        org-hide-leading-stars t
        org-return-follows-link t))
