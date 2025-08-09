(use-package org
  :ensure nil
  :config
  (setq org-directory "~/Documents/Org"
        org-agenda-files '(
                           "~/Documents/Org/Agenda/"
                           )
        org-hide-leading-stars t
        org-return-follows-link t
        org-startup-indented t
        org-file-apps '(
                        (auto-mode . emacs)
                        ("\\.x?html?\\'" . "firefox %s")
                        )
        ))

(use-package cdlatex
  :ensure t
  :requires org
  :hook (org-mode . turn-on-org-cdlatex))

(use-package org-ref
  :ensure t
  :after org
  :bind (
         :map org-mode-map
         ("C-c ]" . org-ref-insert-link)
         )
  :config
  (setq bibtex-completion-bibliography '(
                                         "~/Docs/masterRef.bib"
                                         )
        bibtex-completion-library-path '(
                                         "~/Docs/bib.pdfs"
                                         )))

(use-package org-roam
  :ensure t
  :after org
  :requires org
  :custom
  (org-roam-directory (file-truename "/home/jd/Documents/ORG-ROAM"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n j" . org-roam-dailies-capture-today)
         )
  :config
  (require 'org-roam-protocol))

(use-package org-modern
  :ensure t
  :after org
  :hook (
         (org-mode . org-modern-mode)
         (org-agenda-finalize . org-modern-agenda)
         ))
