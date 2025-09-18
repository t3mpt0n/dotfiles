;;; ...  -*- lexical-binding: t -*-

(leaf catppuccin
	:straight catppuccin-theme
	:config
	(load-theme 'catppuccin :no-confirm)
	:setq (catppuccin-flavor . 'mocha)
	:defer-config (catppuccin-reload))
