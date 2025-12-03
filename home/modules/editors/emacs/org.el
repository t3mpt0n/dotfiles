(leaf cdlatex :straight t)
(leaf org
  :straight org-modern
  :bind (("C-c a" . org-agenda))
  :hook
  (org-mode-hook . org-modern-mode)
  (org-agenda-finalize-hook . org-modern-agenda)
  (org-mode-hook . turn-on-org-cdlatex)
  :setq
  (org-auto-align-tags . nil)
  (org-tags-column . 0)
  (org-catch-invisible-edits . 'show-and-error)
  (org-special-ctrl-a/e . t)
  (org-insert-heading-respect-content . t)
  (org-hide-emphasis-markers . t)
  (org-pretty-entities . t)
  (org-agenda-tags-column . 0)
  (org-ellipsis . "...")
  (org-default-notes-file . "~/Documents/Org/Notes.org")

  :config
  (setq-default org-todo-keywords '((sequence "TODO(t)" "HOMEWORK(h)" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-agenda-files '("~/Documents/Org/Agenda.org")))

;; (leaf org-roam
;;   :straight t
;;   :bind ((:org-mode-map
;;           ("C-c n i" . org-roam-node-insert)
;;           ("C-M-i" . completion-at-point)
;;           ("C-c n o" . org-id-get-create)
;;           ("C-c n t" . org-roam-tag-add)
;;           ("C-c n a" . org-roam-alias-add)
;;           ("C-c n l" . org-roam-buffer-toggle)))
;;   :setq
;;   (org-roam-completion-system . 'ido)
;;   :config
;;   (org-roam-setup)
;;   
;;   :custom
;;   (org-roam-directory . "~/Documents/Org/Roam")
;;   (org-roam-completion-everywhere . t))
;; 
;; (leaf org-roam-ui :straight t)
;; (leaf consult-org-roam
;;   :straight t
;;   :bind (("C-c n e" . consult-org-roam-file-find)
;;          ("C-c n s" . consult-org-roam-search))
;;   :init
;;   (consult-org-roam 1)
;; 
;;   :config
;;   (consult-customize
;;    consult-org-roam-forward-links :preview-key "M-."))

(leaf ob-mermaid
  :straight t
  :setq (ob-mermaid-cli-path . "mmdc"))

(leaf obsidian
  :straight t
  :config
  (global-obsidian-mode t)
  (obsidian-backlinks-mode t)

  :custom
  (obsidian-directory . "~/Documents/Obsidian")
  (obsidian-inbox-directory . "Inbox")
  (markdown-enable-wiki-links . t)

  :bind ((:obsidian-mode-map
          ("C-c C-n" . obsidian-capture)
          ("C-c C-l" . obsidian-insert-link)
          ("C-c C-o" . obsidian-follow-link-at-point)
          ("C-c C-p" . obsidian-jump)
          ("C-c C-b" . obsidian-backlink-jump))))
