(use-package eaf
  :elpaca (
           :host github
           :repo "emacs-eaf/emacs-application-framework"
           :branch "master"
           :protocol https
           :pre-build (("chmod" "+x ./install.py") ("./install-eaf.py"))))
