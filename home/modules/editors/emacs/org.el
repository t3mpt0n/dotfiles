(leaf t3mpt0n/org-setup
  :straight org-modern
  :hook
  (org-mode-hook . org-modern-mode)
  (org-agenda-finalize-hook . org-modern-agenda)
  :setq
  (org-auto-align-tags . nil)
  (org-tags-column . 0)
  (org-catch-invisible-edits . 'show-and-error)
  (org-special-ctrl-a/e . t)
  (org-insert-heading-respect-content . t)
  (org-hide-emphasis-markers . t)
  (org-pretty-entities . t)
  (org-agenda-tags-column . 0)
  (org-ellipsis . "..."))

(leaf org-roam
  :straight t
  :require org-roam-protocol
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-setup)
  (org-roam-db-autosync-mode)
  :custom
  (org-roam-completion-everywhere . t)
  (org-roam-directory . "~/Documents/Org/Roam")
  (org-roam-capture-templates . '(("d" "default" plain
                                   "%?"
                                   :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
                                   :unnarrowed t))))
