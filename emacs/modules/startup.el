  (setq backup-directory-alist '("" . "~/.cache/emacs/")
        backup-by-copying t
        version-control t
        delete-old-backups t
        kept-new-versions 20
        kept-old-versions 5)

  (defun t3mpt0n/show-and-copy-buffer-path ()
    "Show and copy the full path to the current file in the minibuffer."
    (interactive)
    ;; list-buffers-directory is the variable set in dired buffers
    (let ((file-name (or (buffer-file-name) list-buffers-directory)))
      (if file-name
          (message (kill-new file-name))
        (error "Buffer not visiting a file"))))

  (use-package dashboard
    :hook
    (elpaca-after-init . dashboard-insert-startupify-lists)
    (elpaca-after-init . dashboard-initialize)

    :config
    (dashboard-setup-startup-hook)
    (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))
          dashboard-items '((bookmarks . 7)
                            (agenda . 3)
                            (recents . 5))
          dashboard-banner-ascii "NIXMACS"
          dashboard-center-content t
          dashboard-set-init-info t
          dashboard-filter-agenda-entry 'dashboard-no-filter-agenda))

  (use-package hydra)
  (use-package which-key
    :init
    (setq which-key-side-window-location 'bottom
          which-key-sort-order #'which-key-key-order-alpha
          which-key-idle-delay 0.2
          which-key-allow-imprecise-window-fit t)
    (which-key-mode)
    :diminish
    which-key-mode)

  (use-package general
    :init
    (general-create-definer t3mpt0n/leader-keys
      :keymaps 'override
      :states '(normal visual)
      :prefix "SPC"
      :global-prefix "M-SPC")
    (winner-mode 1)

    :config
    (general-evil-setup t)

  (global-set-key (kbd "<escape>") 'keyboard-escape-quit)

  (t3mpt0n/leader-keys
    "q" '(:which-key "Quits")
    "q q" '(save-buffers-kill-terminal :which-key "Save Buffers Kill Frame")
    "q 3" 'server-edit
    "q 5 0" '(delete-frame :which-key "Delete Frame")
    "q k" '(save-buffers-kill-emacs :which-key "Kill Daemon Gracefully"))

  (t3mpt0n/leader-keys
    "b" '(:which-key "Buffers")
    "b m" '(counsel-ibuffer :which-key "Switch to Another Buffer")
    "b c" '(clone-indirect-buffer-other-window :which-key "Clone indirect buffer other window")
    "b b" '(ibuffer-list-buffers :which-key "List Buffers in Seperate Window")
    "b B" '(ibuffer :which-key "List Buffers in Same Window")
    "b d" '(kill-current-buffer :which-key "Kill Current Buffer")
    "b D" '(kill-buffer :which-key "Choose Which Buffer to Kill")
    "b l" '(next-buffer :which-key "Next Buffer")
    "b h" '(previous-buffer :which-key "Previous Buffer"))

  (t3mpt0n/leader-keys
    "w" '(:which-key "Windows")
    "w k" '(evil-window-delete :which-key "Close window")
    "w n" '(evil-window-new :which-key "New window")
    "w s" '(evil-window-split :which-key "Horizontal split window")
    "w v" '(evil-window-vsplit :which-key "Vertical split window")
    "w q" '(evil-quit :which-key "Quit Window")
    "w h" '(evil-window-left :which-key "Window left")
    "w j" '(evil-window-down :which-key "Window down")
    "w k" '(evil-window-up :which-key "Window up")
    "w l" '(evil-window-right :which-key "Window right")
    "w w" '(evil-window-next :which-key "Goto next window")
    "w >" '(evil-window-increase-width :which-key "Increase Width")
    "w <" '(evil-window-decrease-width :which-key "Decrease Width")
    "w +" '(evil-window-increase-height :which-key "Increase Height")
    "w -" '(evil-window-decrease-height :which-key "Decrease Height")
    "w <left>"  '(winner-undo :which-key "Winner undo")
    "w <right>" '(winner-redo :which-key "Winner redo"))

  (t3mpt0n/leader-keys
    "f"   '(:which-key "File")
    "f f" '(counsel-find-file :which-key "Find File")
    "f r" '(counsel-recentf :which-key "Recent Files")
    "f s" '(save-buffer :which-key "Save File")
    "f u" '(sudo-edit-find-file :which-key "Sudo Find File")
    "f y" '(t3mpt0n/show-and-copy-buffer-path :which-key "Yank File Path")
    "f C" '(copy-file :which-key "Copy file")
    "f D" '(delete-file :which-key "Delete file")
    "f R" '(rename-file :which-key "Rename file")
    "f S" '(write-file :which-key "Save File As...")
    "f U" '(sudo-edit :which-key "Sudo Edit File")
    "f b" '(byte-compile-file :which-key "Byte Compile File")
    "f r" '(counsel-recentf :which "Recent Files"))

  (t3mpt0n/leader-keys
    "h" '(:which-key "Help")
    "h v" '(describe-variable :which-key "Describe Variable")
    "h k" '(describe-key :which-key "Describe Key")
    "h f" '(describe-function :which-key "Describe Function"))

  (t3mpt0n/leader-keys
    "SPC" '(counsel-M-x :which-key "M-x")
    "R 3" '((lambda () (interactive) (load-file "/etc/nixos/emacs/init.el")) :which-key "Reload Emacs Config")))

  (setq custom-tab-width 2)
  (defun disable-tabs () (setq indent-tabs-mode nil))
  (defvar untabify-this-buffer)

  (defun tab-all ()
    "Tabify current buffer"
    (tabify (point-min) (point-max)))

  (defun untab-all ()
    "Untabify current buffer, unless `untabify-this-buffer' is nil."
    (and untabify-this-buffer (untabify (point-min) (point-max))))

  (define-minor-mode lunarix-mode
    "Untabify buffer on save." nil " untab" nil
    (make-variable-buffer-local 'untabify-this-buffer)
    (setq untabify-this-buffer (not (derived-mode-p 'makefile-mode)))
    (add-hook 'before-save-hook #'untab-all))

  (setq-default electric-indent-inhibit t)
  (setq-default evil-shift-width custom-tab-width)

  (use-package whitespace
    :elpaca nil
    :init
    (global-whitespace-mode -1)

    :config
    (setq whitespace-mode '(face tabs tab-mark trailing) ;; Visualize tabs as a pipe char = "|"
          whitespace-display-mappings '((tab-mark 9 [124 9] [92 9]))))

  (use-package undo-tree)
  (use-package evil
    :after undo-tree
    :init
    (setq evil-want-keybinding nil)
    (global-undo-tree-mode 1)

    :config
    (evil-mode 1)
    (evil-set-undo-system 'undo-tree)
    (setq undo-tree-history-directory-alist '(("." . "~/.cache/emacs/undo-tree"))))

  (use-package evil-collection
    :after evil
    :init
    (evil-collection-init)

    :config
    (setq evil-collection-mode-list '(dashboard ibuffer dired)))

  (use-package evil-tutor :after evil)

  (use-package sudo-edit)

  (use-package tramp
    :elpaca nil
    :init
    (setq tramp-default-method "ssh"))
