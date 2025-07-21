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
        ))

(use-package org-bullets
  :ensure t
  :after org
  :hook (org-mode . (lambda () (org-bullets-mode 1))))

(use-package org-ref
  :ensure t
  :after org
  :bind (
         :map org-mode-map
         ("C-c ]" . org-ref-insert-link)
         )
  :config
  (setq bibtex-completion-bibliography '(
                                         "~/Documents/masterRef.bib"
                                         )
        bibtex-completion-library-path '(
                                         "~/Documents/bib.pdfs"
                                         )))

(use-package org-roam
  :ensure t
  :after org
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
