;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq org-latex-listings t)
(eval-after-load "tex"
  '(progn
     (add-to-list
      'TeX-command-list
      '("LaTeX escaped"
        "%`%l%(mode)%' -shell-escape -interaction nonstopmode %T"
        TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX shell escaped")
      )
     ))

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name) (file-exists-p (buffer-file-name))
       (progn
 ;enable auto-revert-mode to update reftex when bibtex file changes on disk
 (global-auto-revert-mode t)
 (reftex-parse-all)
 ;add a custom reftex cite format to insert links
 (reftex-set-cite-format
  '((?b . "[[bib:%l][%l-bib]]")
    (?n . "[[notes:%l][%l-notes]]")
    (?p . "[[papers:%l][%l-paper]]")
    (?t . "%t")
    (?h . "** %t\n:PROPERTIES:\n:Custom_ID: %l\n:END:\n[[papers:%l][%l-paper]]")
    (?c . "\\cite{%l}")
      ))))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  (define-key org-mode-map (kbd "C-c (") 'org-mode-reftex-search))

(add-hook 'org-mode-hook 'org-mode-reftex-setup)
(defun org-mode-reftex-search ()
  ;;jump to the notes for the paper pointed to at from reftex search
  (interactive)
  (org-open-link-from-string (format "[[notes:%s]]" (first (reftex-citation t)))))

(setq org-link-abbrev-alist
      '(("bib" . "~/docsThese/latex/src/bibliography.bib::%s")
("notes" . "~/research/org/notes.org::#%s")
("papers" . "~/these/leitura/artigos/%s.pdf")))

(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))
(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("cache=false" "minted"))
(add-to-list 'org-latex-packages-alist '("" "amsmath"))
(add-to-list 'org-latex-packages-alist '("" "tikz"))
(add-to-list 'org-latex-packages-alist '("" "xcolor"))
(add-to-list 'org-latex-packages-alist '("" "geometry"))

(setq org-latex-listings 'minted)

(setq org-latex-pdf-process (list "latexmk -outdir=`dirname %f` -auxdir=`dirname %f` -pdflatex='pdflatex -output-directory=`dirname %f` -shell-escape -interaction nonstopmode' -pdf -f %f"))
(add-to-list 'org-latex-minted-langs '(ipython "python"))
(setq org-babel-python-command "python3")
(setq org-export-allow-bind-keywords t)
;; (autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
 (add-to-list
  'auto-mode-alist
  '("\\.m$" . octave-mode))
(add-hook 'octave-mode-hook
          (lambda ()
            (progn (setq octave-comment-char ?%) (setq comment-start "% ") (setq comment-add 0))
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1)
              )
            )
          )


 ;; (setq matlab-indent-function t)
(after! org
 ;; (setq matlab-shell-command "matlab -noFigureWindows")
(setq org-babel-octave-shell-command "octave -q -W"))
(if (display-graphic-p)
    ()
  (load-theme 'doom-spacegrey t))
(set 'global-linum-mode 1)
(setq display-line-numbers-type 'relative)

;; Try use org-roam (zettelkasten)
(after! deft
(defadvice deft (before changeDir )
  ""
    (setq deft-directory "~/org/notes")
        )
(ad-activate 'deft)
(setq deft-recursive t)
)

;; (after! deft
;; (defadvice deft (before changeDir )
;;   ""
;;   (if (null (projectile-project-root))
;;       (setq deft-directory "~/org/notes")
;;     (progn
;;      ;; TODO create folder
;;      (if (not(file-directory-p (concat (projectile-project-root) ".notes")))
;;        (make-directory (concat (projectile-project-root) ".notes"))
;;        )
;;      (setq deft-directory (concat (projectile-project-root) ".notes"))
;;      )
;;       )
;;         )
;; (ad-activate 'deft)
;; (setq deft-recursive t)
;; )

;; Actually start using templates
(after! org-capture
  ;; Firefox
  (add-to-list 'org-capture-templates
               '("a" "Agenda" entry
                 (file "~/org/agendas/poli.org")
                 "* %?\n :PROPERTIES:\n :calendar-id: raccacio@poli.ufrj.br\n :END:\n:org-gcal:\n%^T%^T\n:END:\n"
                 :kill-buffer t))
)

(after! org-gcal
(setq org-gcal-client-id "729511610034-5jtaq9tnd4cu8b6jec6klr9rskljqmq2.apps.googleusercontent.com"
      org-gcal-client-secret "bvQ-_ofRzkY_obFi02k1IeXs"
      org-gcal-file-alist '(
                            ("raccacio@poli.ufrj.br" .  "~/org/agendas/poli.org")
                            ))
)
;; (add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-post-at-point)))
(setq org-publish-project-alist
      '(

       ;; ... add all the components here (see below)...
        ("docsThese-site"
         :base-directory "~/docsThese/docs/org/"
         :base-extension "org"
         :publishing-directory "~/docsThese/docs/site/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :body-only t
         )
        ("docsThese-latex"
         :base-directory "~/docsThese/docs/org/"
         :base-extension "org"
         :publishing-directory "~/docsThese/docs/etudes/"
         :recursive t
         :publishing-function org-latex-publish-to-pdf
         :headline-levels 4             ; Just the default for this project.
         )
      ))

;; '(reftex-use-external-file-finders t)
;; (setq reftex-external-file-finders
;; '(("tex" . "/path/to/kpsewhich -format=.tex %f")
;;   ("bib" . "/path/to/kpsewhich -format=.bib %f")))
(setq +latex-viewers '(pdf-tools))
;; (setq +latex-viewers '(zathura))
(after! projectile
(setq projectile-indexing-method 'native)
)
(after! ivy-posframe

(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
;; (setq ivy-posframe-parameters
;;       '((left-fringe . 18)
;;         (right-fringe . 18)))


)

(use-package! org-roam
  :commands (org-roam-insert org-roam-find-file org-roam)
  :init
  (setq org-roam-directory "~/org/notes")
  (map! :leader
        :prefix "n"
        :desc "Org-Roam-Insert" "i" #'org-roam-insert
        :desc "Org-Roam-Find"   "/" #'org-roam-find-file
        :desc "Org-Roam-Buffer" "r" #'org-roam)
  :config
  (org-roam-mode +1))

(def-package! org-ref
    :after org
    :init
    ; code to run before loading org-ref
    :config
    ; code to run after loading org-ref
    (setq org-ref-default-bibliography '("~/docsThese/docs/memoire/bibliography.bib")
      org-ref-pdf-directory "~/these/leitura/bibliography/")
    )
