(use-package emms
  :ensure t
  :hook ((elpaca-after-init . emms-all)
         (elpaca-after-init . emms-default-players))
  :bind (
         ("C-; e e" . emms)
         ("C-; e b" . emms-browser)
         )
  :config
  (require 'emms-setup)
  (require 'emms-player-mpd)
  (emms-cache-enable)
  (add-to-list 'emms-info-functions 'emms-info-mpd)
  (setq emms-player-list '(emms-player-mpd)
        emms-player-mpd-server-name (getenv "MPD_SERVER_NAME")
        emms-player-mpd-server-port (getenv "MPD_SERVER_PORT")
        emms-player-mpd-music-directory (getenv "MPD_MUSIC_DIR")
        emms-volume-change-function #'emms-volume-mpd-change)
  (emms-player-mpd-connect)
  :custom
  (emms-browser-covers #'emms-browser-cache-thumbnail-async))
