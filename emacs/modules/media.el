(use-package emms
  :after general
  :init
  (emms-all)
  (emms-default-players)

  :hook
  (emms-playlist-cleared . emms-player-mpd-clear)
  (emms-browser-mode . visual-line-mode)

  :config
  (general-def
    :keymaps 'override
    :states '(normal visual)
    :prefix "SPC"
    :global-prefix "M-SPC"
    "m" '(:which-key "EMMS")
    "m m" '(emms :which-key "Playlist Buffer")
    "m b" '(emms-smart-browse :which "Smart Browse")
    "m SPC" '(emms-pause :which-key "Pause Playback")
    "m h" '(emms-seek-backward :which-key "Seek 5 Seconds Back")
    "m l" '(emms-seek-forward :which-key "Seek 5 Seconds Forward")
    "m /" '(emms-seek-to :which-key "Seek Specific Point"))
  (setq emms-seek-seconds 5
        emms-info-asynchronously t
        emms-player-list '(emms-player-mpd emms-player-mpv)
        emms-info-functions '(emms-info-mpd emms-info-metaflac emms-info-mediainfo)

        emms-player-mpd-server-name "127.0.0.1"
        emms-player-mpd-server-port "6600"
        mpc-host "127.0.0.1:6600")

  (emms-player-mpd-connect)
  (emms-player-mpd-update-all-reset-cache)
  (emms-player-set emms-player-mpd
                   'regex
                   (emms-player-simple-regexp
                    "mp3" "opus" "ogg" "flac" "wav" "m4a"))
  (general-def
    :keymaps 'override
    :states '(normal visual)
    :prefix "SPC"
    :global-prefix "M-SPC"
    "m H" '(emms-player-mpd-previous :which-key "Prev Song")
    "m L" '(emms-player-mpd-next :which-key "Next Song")
    "m +" '(mpc-volup :which-key "Volume +5")
    "m -" '(mpc-voldown :which-key "Volume -5"))

  (defun mpc-volup ()
    (interactive)
    (let* ((mpd_host emms-player-mpd-server-name)
           (mpd_port emms-player-mpd-server-port)
           (mpd_hostport (concat "mpc --host=" mpd_host " --port=" mpd_port)))
      (if (string-equal (shell-command-to-string mpd_hostport)  "MPD error: Connection refused
")
          (message "%s" "MPD not connected")
        (message "%s" (replace-regexp-in-string "\n" "" (format "%s" (shell-command-to-string (concat mpd_hostport " volume +5 | awk 'NR==3 { print $1\" \"$2 }' | sed 's/v/V/g'"))))))))

  (defun mpc-voldown ()
    (interactive)
    (let* ((mpd_host emms-player-mpd-server-name)
           (mpd_port emms-player-mpd-server-port)
           (mpd_hostport (concat "mpc --host=" mpd_host " --port=" mpd_port)))
      (if (string-equal (shell-command-to-string mpd_hostport)  "MPD error: Connection refused
")
          (message "%s" "MPD not connected")
        (message "%s" (replace-regexp-in-string "\n" "" (format "%s" (shell-command-to-string (concat mpd_hostport " volume -5 | awk 'NR==3 { print $1\" \"$2 }' | sed 's/v/V/g'"))))))))
(use-package emms-info-mediainfo :after emms)

  (emms-player-set emms-player-mpv
                   'regex
                   (rx (or (: "https://" (* nonl) "youtube.com" (* nonl))
                           (+ (? (or "https://" "http://"))
                              (* nonl)
                              (regexp (eval (emms-player-simple-regexp
                                             "mp4" "mov" "wmv" "avi" "webm" "flv" "mkv")))))))
  (defvar yt-video-quality "1440p")
  (defun t3mpt0n/emms-player-mpv-parameters ()
    (let* ((res yt-video-quality)
           (epmdp emms-player-mpv-parameters)
           (res2 (replace-regexp-in-string "\\b[0-9]+\\b" "\\0" res)))
      (setq emms-player-mpv-parameters `(,@epmdp ,(format "--ytdl-format=bestvideo[height<=%s]+bestaudio/best" res2)))))

  (defun t3mpt0n/yt-res-select ()
    (interactive)
    (let ((availres '("480p" "720p" "1080p" "1440p" "2160p")))
      (ivy-read "  Select Video Quality: " availres
                :action (lambda (quality)
                          (setq yt-video-quality quality)))))

  (defun t3mpt0n/get-yt-url (link)
    (let ((watch-id (cadr
                     (assoc "watch?v"
                            (url-parse-query-string
                             (substring
                              (url-filename
                               (url-generic-parse-url link))
                              1))))))
      (concat "https://www.youtube.com/watch?v=" watch-id)))

  (defun t3mpt0n/emms-cleanup-urls ()
    (interactive)
    (let ((keys-to-delete '()))
      (maphash (lambda (key value)
                 (when (eq (cdr (assoc 'type value)) 'url)
                   (add-to-list 'keys-to-delete key)))
               emms-cache-db)
      (dolist (key keys-to-delete)
        (remhash key emms-cache-db)))
    (setq emms-cache-dirty t))

  (t3mpt0n/emms-player-mpv-parameters))

(use-package elfeed
  :after emms
  :hook (elfeed-show-mode . visual-line-mode)
  :config
  (advice-add #'elfeed-insert-html
              :around
              (lambda (fun &rest r)
                (let ((shr-use-fonts nil))
                  (apply fun r))))
  (setq elfeed-enclosure-default-dir (expand-file-name "~/Downloads"))
  (setq-default elfeed-search-filter "@2-weeks-ago -read +unread -junk")
  (evil-define-key 'normal elfeed-show-mode-map
    (kbd "J") 'elfeed-goodies/split-show-next
    (kbd "K") 'elfeed-goodies/split-show-prev
    (kbd "RET") 'elfeed-search-show-entry
    (kbd "q") 'elfeed-search-quit-window
    (kbd "Q") 'elfeed-kill-buffer
    (kbd "u") 'elfeed-update
    (kbd "P") 't3mpt0n/elfeed-play-emms-youtube
    (kbd "+") 't3mpt0n/elfeed-add-emms-youtube)
  (evil-define-key 'normal elfeed-search-mode-map
    (kbd "J") 'elfeed-goodies/split-show-next
    (kbd "K") 'elfeed-goodies/split-show-prev
    (kbd "RET") 'elfeed-search-show-entry
    (kbd "q") 'elfeed-search-quit-window
    (kbd "Q") 'elfeed-kill-buffer
    (kbd "u") 'elfeed-update)

  (defun t3mpt0n/elfeed-add-emms-youtube ()
    (interactive)
    (emms-add-elfeed elfeed-show-entry)
    (elfeed-tag elfeed-show-entry 'watched)
    (elfeed-show-refresh))

  (defun t3mpt0n/elfeed-play-emms-youtube ()
    (interactive)
    (emms-play-elfeed elfeed-show-entry)
    (elfeed-tag elfeed-show-entry 'watched)
    (elfeed-show-refresh))

  (with-eval-after-load 'emms
    (define-emms-source elfeed (entry)
                        (let ((track (emms-track
                                      'url (t3mpt0n/get-yt-url (elfeed-entry-link entry)))))
                          (emms-track-set track 'info-title (elfeed-entry-title entry))
                          (emms-playlist-insert-track track)))))

(use-package elfeed-goodies
  :after elfeed
  :init
  (elfeed-goodies/setup)

  :config
  (setq elfeed-goodies/entry-pane-size 0.5))

(use-package elfeed-org
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/.emacs.d/elfeed.org")))
