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
  :hook (org-mode . turn-on-org-cdlatex)
  :config
  (setq org-latex-create-formula-image-program 'imagemagick
        org-format-latex-options (plist-put org-format-latex-options :scale 2.5)))

(use-package org-ref
  :ensure t
  :after org
  :bind (
         :map org-mode-map
         ("C-c ]" . org-ref-insert-link)
         ("C-M-i" . completion-at-point)
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
  :requires org
  :custom
  (org-roam-directory "/home/jd/Docs/ORG-ROAM")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t
      )
     ("m" "mathematics notes" plain
      "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+options: toc:nil\n#+LATEX_CLASS: article\n#+LATEX_CLASS_OPTIONS: [11pt, letterpaper]\n#+LATEX_HEADER: \\usepackage{amsmath, amssymb, geometry, amsfonts, amsthm}\n#+LATEX_HEADER: \\usepackage{tikz, tkz-euclide, pgfplots}\n#+LATEX_HEADER: \\usepackage{gensymb}\n")
      :unnarrowed t)))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n j" . org-roam-dailies-capture-today)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow)
         )
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies)
  (org-roam-db-autosync-mode))

(use-package org-modern
  :ensure t
  :after org
  :hook (
         (org-mode . org-modern-mode)
         (org-agenda-finalize . org-modern-agenda)
         ))
