(use-package gnus
  :elpaca nil
  :init
  (setq user-mail-address "t3mpt0n@gmail.com"
        user-full-name "t3mpt0n"

        gnus-select-method
        '(nnimap "gmail"
                 (nnimap-address "imap.gmail.com")
                 (nnimap-server-port "imaps")
                 (nnimap-stream ssl))

        message-send-mail-function 'smtpmail-send-it
        smtpmail-smtp-server "smtp.gmail.com"
        smtpmail-smtp-service 587
        gnus-agent nil))
