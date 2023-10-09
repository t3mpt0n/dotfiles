(use-package org
  :elpaca nil
  :hook (org-mode . org-indent-mode)
  :config
  (setq org-directory "~/Docs/Org"
        org-agenda-files '("Agenda.org")
        org-default-notes-file (expand-file-name "Notes.org" org-directory)
        org-log-done 'time
        org-journal-dir "~/Docs/Org/Journal"
        org-journal-date-format "%B %d, %Y (%A) "
        org-journal-file-format "%d-%m-%Y.org"
        org-hide-emphasis-markers t
        org-todo-keywords
        '((sequence
           "TODO(t!)" ; Initial Creation
           "DOING(g@)" ; WIP
           "HOMEWORK(h@)" ; Homework
           "EXAM(e@)"
           "WAIT(w@)" ; Pause Task (My Choice)
           "BLOCKED(b@)" ; Pause Task (Not My Choice)
           "REVIEW(r!)" ; Inspect or Share Time
           "|" ; Remaining Close Task
           "DONE(d@)" ; Normal Completion
           "CANCELED(c@)" ; Not Going to do it
           "DUPLICATE(p@)" ; Already did it
           ))
        org-src-preserve-indentation t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 2
        org-src-tab-acts-natively t
        org-src-fontify-natively t
        org-confirm-babel-evaluate nil
        org-edit-src-content-indentation 0
        org-highlight-latex-and-related '(latex script entities))

  :custom
  (defun risky-local-variable-p (sym &optional _ignored) nil))

(use-package org-contrib :after org)

(use-package org-roam
  :after (org general)
  :custom
  (org-roam-directory "~/Docs/Org/Roam")
  (org-roam-completion-everywhere t)
  (defun org-roam-node-insert-immediate (arg &rest args)
    (interactive "P")
    (let ((args (cons arg args))
          (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                    '(:immediate-finish t)))))
      (apply #'org-roam-node-insert args)))

  :config
  (org-roam-setup)
  (general-def
    :states '(normal visual)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC"
    "o" '(:which-key "Org Mode")
    "o r" '(:which-key "Org Roam")
    "o r b" '(:which-key "Org Roam Buffer")
    "o r b t" '(org-roam-buffer-toggle :which-key "Open/Close Org Roam Buffer")
    "o r n" '(:which-key "Org Roam Node")
    "o r n f" '(org-roam-node-find :which-key "Find Org Roam Node")
    "o r n i" '(org-roam-node-insert :which-key "Insert Org Roam Node")
    "o r n I" '(org-roam-node-insert-immediate :which-key "Insert Org Roam Node No New Buffer")
    "o r u"   '(:which-key "Org Roam UI")
    "o r u o" '(org-roam-ui-open :which-key "Org Roam UI Open")))

(use-package org-roam-ui
  :after (org-roam general)
  :hook (org-roam-mode . org-roam-ui-mode)

  :config
  (general-def
    :states '(normal visual)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC"
    "o r u"   '(:which-key "Org Roam UI")
    "o r u o" '(org-roam-ui-open :which-key "Org Roam UI Open"))
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(use-package org-bullets
  :after org
  :hook (org-mode . (lambda () org-bullets-mode 1)))

(use-package cdlatex)

(use-package ob-tmux
  ;; Install package automatically (optional)
  :ensure t
  :config
  (setq vterm-enable-manipulate-selection-data-by-osc52 t)
  :custom
  (org-babel-default-header-args:tmux
   '((:results . "silent")                  ;
     (:session . "default")                 ; The default tmux session to send code to
     (:socket  . nil)))                     ; The default tmux socket to communicate with
  ;; The tmux sessions are prefixed with the following string.
  ;; You can customize this if you like.
  (org-babel-tmux-session-prefix "ob-")
  ;; The terminal that will be used.
  ;; You can also customize the options passed to the terminal.
  ;; The default terminal is "gnome-terminal" with options "--".
  (org-babel-tmux-terminal (concat user-emacs-directory "ob-tmux-defterm.sh"))
  (org-babel-tmux-terminal-opts nil))

(use-package org-alert
  :after org
  :config
  (run-with-timer 0 (* 5 60) 'org-alert-enable)
  (setq alert-default-style 'libnotify
        org-alert-interval 100
        org-alert-notify-cutoff 15
        org-alert-after-event-cutoff 15))
