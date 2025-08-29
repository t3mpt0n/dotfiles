(use-package eshell
  :commands eshell
  :requires ef-themes
  :ensure nil
  :hook (eshell-mode . (lambda ()
                         ;; Aliases
                         (eshell/alias "e" "find-file $1")
                         (eshell/alias "ff" "find-file $1")
                         (eshell/alias "ee" "find-file-other-window $1")
                         (eshell/alias "d" "dired $1")
                         ;; ENVVARS
                         (setenv "PAGER" "cat")
                         (setenv "PATH" (getenv "PATH"))
                         (setenv "TERM" "xterm-256color")))
  :init
  (setq
   eshell-destroy-buffer-when-process-dies t
   eshell-prefer-lisp-functions nil
   eshell-save-history-on-exit t
   eshell-scroll-to-bottom-on-input 'all
   eshell-error-if-no-glob t
   eshell-hist-ignoredups t)

  :config
  (setq eshell-prompt-function
        (lambda ()
          (concat
           (propertize "[" 'face `(:foreground ,(ef-themes-get-color-value 'fg-main)))
           (propertize (user-login-name) 'face `(:foreground ,(ef-themes-get-color-value 'red)))
           (propertize "@" 'face `(:foreground ,(ef-themes-get-color-value 'fg-main)))
           (propertize (system-name) 'face `(:foreground ,(ef-themes-get-color-value 'yellow)))
           (propertize "] (" 'face `(:foreground ,(ef-themes-get-color-value 'fg-main)))
           (propertize (concat (eshell/pwd)) 'face `(:foreground ,(ef-themes-get-color-value 'green)))
           (propertize ") " 'face `(:foreground ,(ef-themes-get-color-value 'fg-main)))
           (propertize (if (= (user-uid) 0) "# " "$ ") 'face `(:foreground ,(ef-themes-get-color-value 'fg-main))))))
  (defun eshell/clear ()
    "Clear Eshell Buffer"
    (let ((inhibit-read-only t))
      (erase-buffer)
      (eshell-send-input))))

(use-package eat
  :requires eshell
  :elpaca (eat :type git
               :host codeberg
               :repo "akib/emacs-eat"
               :files ("*.el" ("term" "term/*.el") "*.texi"
                       "*.ti" ("terminfo/e" "terminfo/e/*")
                       ("terminfo/65" "terminfo/65/*")
                       ("integration" "integration/*")
                       (:exclude ".dir-locals.el" "*-tests.el")))
  :hook (eshell-load . eat-eshell-mode))
(use-package multi-vterm
  :after vterm
  :ensure t
  :bind (
         ("C-; o T" . multi-vterm)
         ))
