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
