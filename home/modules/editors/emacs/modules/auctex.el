(use-package reftex
  :defer t
  :custom
  (reftex-cite-prompt-optional-args t))

(use-package tex
  :ensure auctex
  :after cape
  :mode ("\\.tex\\$" . latex-mode)
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-master nil)
  (TeX-electric-math (cons "$" "$"))
  (TeX-view-program-selection '((output-pdf "PDF Tools")))
  (LaTeX-electric-left-right-brace t)
  (TeX-source-correlate-mode t)
  (TeX-source-correlate-start-server t)
  (reftex-plug-into-AUCTeX t)
  :config
  (progn
    (pdf-loader-install)
    (add-hook 'TeX-after-compilation-finished-functions
              #'TeX-revert-document-buffer)
    (yas-reload-all)
    (add-hook 'LaTeX-mode-hook
              (lambda ()
                (reftex-mode t)
                (flyspell-mode t)
                (yas-minor-mode t)
                (LaTeX-math-mode t)
                (tex-fold-mode t)
                (setq TeX-command-default "LatexMk")
                (add-hook 'completion-at-point-functions #'cape-tex)))))

(use-package auctex-latexmk
  :after tex
  :ensure t
  :custom
  (auctex-latexmk-inherit-TeX-PDF-mode t)
  :config
  (auctex-latexmk-setup))
