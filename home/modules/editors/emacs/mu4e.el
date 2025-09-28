;;; Code:
(leaf t3mpt0n/mu4e
  :require mu4e smtpmail
  :setq
  (user-mail-address . "mail@t3mpt0n.com")
  (send-mail-function . 'smtpmail-send-it)
  (smtpmail-smtp-server . "smtp.purelymail.com")
  (smtpmail-stmp-service . 465)
  (smtpmail-stream-type . 'ssl)
  (mu4e-maildir . "~/Mail")
  (mu4e-get-mail-command . "mbsync -c ~/.config/isyncrc -a")
  (mu4e-user-mail-address-list . '("mail@t3mpt0n.com"
                                   "route@t3mpt0n.com"))
  (mu4e-update-interval . 300)
  (mu4e-headers-auto-update . t)
  (mu4e-view-show-images . t)
  (mu4e-compose-signature-auto-include . nil)
  (mu4e-use-fancy-chars . t))
