(use-package dired
  :config
  (setq dired-listing-switches "-agho --group-directories-first"
        dired-recursive-copies 'top
        dired-recursive-deletes 'top
        dired-dwim-target t
        dired-auto-revert-buffer t)
  (t3mpt0n/leader-keys
    "d" '(:which-key "Dired")
    "d d" '(dired :which-key "Open Dired")
    "d j" '(dired-jump :which "Jump to Current Buffer Dir"))
  (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
  (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file)
  (evil-define-key 'normal dired-mode-map (kbd "RET") 'dired-open-file)

  :custom
  (if (< emacs-major-version 28)
      (progn
        (require 'dired-x)
        (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
        (define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file ".."))))
    (progn
      (setq dired-kill-when-opening-new-dired-buffer t))))

(use-package nerd-icons-dired
  :after (dired nerd-icons)
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package peep-dired
  :hook (peep-dired . evil-normalize-keymaps)
  :config
  (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
  (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file)
  (t3mpt0n/leader-keys
    "d p" '(peep-dired :which "Peep Dired")))

(eval-after-load "dired-aux"
  '(progn
     (add-to-list 'dired-compress-file-suffixes '("\\.zip\\'" ".zip" "unzip %i"))
     (add-to-list 'dired-compress-file-suffixes '("\\.rar\\'" ".rar" "unrar x %i"))))

(use-package dired-open
  :config
  (setq dired-open-extensions '(("gif" . "imv")
                                ("jpg" . "imv")
                                ("jpeg" . "imv")
                                ("png" . "imv")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv")
                                ("mp3" . "mpv")
                                ("m4a" . "mpv")
                                ("ogg" . "mpv")
                                ("opus" . "mpv")
                                ("nes" . "nestopia -f")
                                ("smc" . "ares --system Super Famicom --fullscreen")
                                ("sfc" . "ares --system Super Famicom --fullscreen")
                                ("n64" . "flatpak run --filesystem=host:ro io.github.simple64.simple64 --nogui")
                                ("v64" . "flatpak run --filesystem=host:ro io.github.simple64.simple64 --nogui")
                                ("z64" . "flatpak run --filesystem=host:ro io.github.simple64.simple64 --nogui")
                                ("torrent" . "qbittorrent"))))
