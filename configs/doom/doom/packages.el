;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)
(package! org-brain)
(package! rainbow-mode)
(package! matlab-mode)

(package! org-roam
  :recipe (:host github :repo "jethrokuan/org-roam"))
