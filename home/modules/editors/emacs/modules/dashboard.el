(use-package dashboard
	:ensure t
	:hook ((elpaca-after-init . dashboard-insert-startupify-lists)
		   (elpaca-after-init . dashboard-initialize))
	:config
	(dashboard-setup-startup-hook)
	(setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name))
		  dashboard-banner-logo-title "¡Bienvenidos a la iglesia de Emacs!"
		  dashboard-center-content t
		  dashboard-vertically-center-content t
		  dashboard-display-icons-p t
		  dashboard-icon-type 'nerd-icons))
