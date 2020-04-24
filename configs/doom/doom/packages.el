;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)
(package! org-brain)
(package! rainbow-mode)
(package! matlab-mode)
(package! org-caldav)
(package! Oauth2)
(package! typewriter
  :recipe (:host github :repo "kylefeng28/typewriter-mode"))
(package! org-noter
  :recipe (:host github :repo "weirdNox/org-noter"))

(package! idle-highlight-mode)
;; (package! org-roam
;;   :recipe (:host github :repo "jethrokuan/org-roam"))

(package! org-journal)
(package! gif-screencast
  :recipe (:host gitlab :repo "ambrevar/emacs-gif-screencast"))

(package! org-pdftools
  :recipe (:host github :repo "fuxialexander/org-pdftools"))
(package! org-noter-pdftools
  :recipe (:host github :repo "fuxialexander/org-pdftools"))
