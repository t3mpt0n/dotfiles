;;; Code:
(leaf t3mpt0n/mu4e
  :doc "Personal MU4E Configuration"
  :require smtpmail mu4e
  :setq
  (mu4e-get-mail-command . "mbsync -c ~/.config/isyncrc -a")
  (mu4e-maildir . "~/Mail")
  (sendmail-program . "msmtp")
  (send-mail-function . 'smtpmail-send-it)
  (message-send-mail-function . 'message-send-mail-with-sendmail)

  :config
  (setq mu4e-contexts (list
                       (make-mu4e-context
                        :name "Personal"
                        :match-func
                        (lambda (msg)
                          (when msg
                            (string-prefix-p "/personal" (mu4e-message-field msg :maildir))))

                        :vars '((user-mail-address . "mail@t3mpt0n.com")
                                (user-full-name . "Sydney London")
                                (smtpmail-smtp-server . "smtp.purelymail.com")
                                (smtpmail-smtp-service . 465)
                                (smtpmail-stream-type . ssl)
                                (smtpmail-debug-info . t)))

                       (make-mu4e-context
                        :name "Routing"
                        :match-func
                        (lambda (msg)
                          (when msg
                            (string-prefix-p "/personal" (mu4e-message-field msg :maildir))))

                        :vars '((user-mail-address . "route@t3mpt0n.com")
                                (user-full-name . "London Sydney")
                                (smtpmail-smtp-server . "smtp.purelymail.com")
                                (smtpmail-smtp-service . 465)
                                (smtpmail-stream-type . ssl))))))
