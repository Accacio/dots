;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Rafael Accácio Nogueira"
      user-mail-address "raccacio@poli.ufrj.br")

(blink-cursor-mode -1)
(show-smartparens-global-mode 1)
(setq blink-cursor-interval .1)
(setq blink-cursor-blinks 2)
(tooltip-mode 1)
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;;Visual
;;
(after! ivy-posframe
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
  )

(remove-hook 'prog-mode-hook 'hl-line-mode)
(remove-hook 'text-mode-hook 'hl-line-mode)
(remove-hook 'special-mode-hook 'hl-line-mode)
(remove-hook 'conf-mode-hook 'hl-line-mode)
(use-package! idle-highlight-mode
  :config
  (progn
    (set-face-background 'idle-highlight "#252")
    (set-face-foreground 'idle-highlight "#fafafa")
    ))

(defun toggle-transparency ()
   (interactive)
   (let ((alpha (frame-parameter nil 'alpha)))
     (set-frame-parameter
      nil 'alpha
      (if (eql (cond ((numberp alpha) alpha)
                     ((numberp (cdr alpha)) (cdr alpha))
                     ;; Also handle undocumented (<active> <inactive>) form.
                     ((numberp (cadr alpha)) (cadr alpha)))
               100)
          '(85 . 50) '(100 . 100)))))
(toggle-transparency)
(map! :leader
      (:prefix-map ("t" . "toggle")
        :desc "Transparency"                 "T" 'toggle-transparency))

(if (display-graphic-p)
  (setq doom-theme 'doom-one)
  (setq doom-theme 'doom-spacegrey)
  )

(defun org-babel-execute:matlab (body params)
  "Execute a block of matlab code with Babel."
  (with-temp-buffer
    (insert (org-babel-execute:octave body params 'matlab))
    (beginning-of-buffer)
    (re-search-forward org-babel-octave-eoe-indicator nil t)
    (beginning-of-line)
    (let ((beg (point)))
      (end-of-buffer)
      (delete-region beg (point)))
    (buffer-string)))



;; Org
(setq org-directory "~/org/")
(after! org

  (add-to-list 'org-file-apps '("\\.pdf\\'" . emacs))
(setq org-hide-emphasis-markers t)
(setq org-modules '(ol-bibtex org-habit org-habit-plus))
(setq +org-habit-graph-padding 2)
(setq +org-habit-min-width 30)
(setq +org-habit-graph-window-ratio 0.2)

(org-load-modules-maybe t)
(setq org-agenda-files
      (list
       "~/org/private/Eve.org"
       "~/org/private/todo.org"
       "~/org/private/todo_these.org"
       "~/org/private/fromPoli.org"
       "~/org/private/fromGmail.org"
       "~/org/private/fromSupelec.org"
       )
      )

(setq org-agenda-custom-commands
      '(
        ("n" "Agenda and all TODOs" ((agenda "") (alltodo "")) nil ("~/org/private/agenda.html"))
        )
      )
;;         ;; ("Y" alltodo "" nil ("~/org/private/todo.html" "~/org/private/todo.txt"))
;;         ("Y" alltodo "" nil ("~/org/private/todo.html"))
;;         ;; ("h" "Agenda and Home-related tasks"
;;         ;;  ((agenda "")
;;         ;;   (tags-todo "home")
;;         ;;   (tags "garden"))
;;         ;;  nil
;;         ;;  ("~/views/home.html"))
;;         ;; ("o" "Agenda and Office-related tasks"
;;         ;;  ((agenda)
;;         ;;   (tags-todo "work")
;;         ;;   (tags "office"))
;;         ;;  nil
;;         ;;  ("~/views/office.ps" "~/calendars/office.ics"))

;; (setq +ligatures-extra-symbols
;;   '(;; org
;;     :html  "🌐"
;;     :author "📛"
;;     :title "T"
;;     :date "📅"
;;     :mail "✉"
;;     :noweb "🕸"
;;     :language "🌎"
;;     :options "🔧"
;;     :tex      ""
;;     :matlab ""
;;     :octave ""
;;     :python "🐍"
;;     :emacs ""
;;     ) )

;; (set-ligatures! 'org-mode
;;   :def "function"
;;   :html "#+HTML:"
;;   :title "#+title:"
;;   :title "#+TITLE:"
;;   :author "#+author:"
;;   :noweb ":noweb yes"
;;   :mail "#+email:"
;;   :mail "#+EMAIL:"
;;   :date "#+DATE:"
;;   :date "#+Date:"
;;   :date "#+date:"
;;   :author "#+AUTHOR:"
;;   :author "#+Author:"
;;   :author "#+author:"
;;   :options "#+OPTIONS:"
;;   :options "#+Options:"
;;   :options "#+options:"
;;   :author"#+author:"
;;   :language "#+LANGUAGE:"
;;   :language "#+language:"
;;   :tex "#+LaTeX:"
;;   :tex "latex:"
;;   :tex "#+BEAMER_header:"
;;   :tex "#+LATEX_HEADER:"
;;   :matlab "matlab"
;;   :matlab "octave"
;;   :python "python"
;;   :emacs "emacs-lisp"
;;   )
(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))
(require 'ox-latex)
(setq org-latex-listings t)
(setq org-latex-listings 'minted)

(setq org-latex-pdf-process (list "latexmk -outdir=`dirname %f` -auxdir=`dirname %f` -pdflatex='pdflatex -output-directory=`dirname %f` -shell-escape -interaction nonstopmode' -pdf -f %f"))
(add-to-list 'org-latex-packages-alist '("cache=false" "minted"))
(add-to-list 'org-latex-packages-alist '("" "amsmath"))
(add-to-list 'org-latex-packages-alist '("" "tikz"))
(add-to-list 'org-latex-packages-alist '("" "xcolor"))
(setq org-ellipsis " ▼") ;;▼ ⤵
(setq org-superstar-headline-bullets-list '("α" "β" "γ" "δ" "ε" "ζ" "η" "θ" "ι" "κ" "λ" "μ" "ν" "ξ" "ο" "π" "ρ" "σ" "τ" "υ" "φ" "χ" "ψ" "ω"))
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(setq org-babel-octave-shell-command "octave -q")
(setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")
  (setq org-todo-keywords
        '((sequence
           "TODO(t)"  ; A task that needs doing & is ready to do
           "PROJ(p)"  ; A project, which usually contains other tasks
           "TOREAD(r)"  ; A project, which usually contains other tasks
           "STRT(s)"  ; A task that is in progress
           "WAIT(w)"  ; Something external is holding up this task
           "HOLD(h)"  ; This task is paused/on hold because of me
           "|"
           "DONE(d)"  ; Task successfully completed
           "READ(R)"  ; A project, which usually contains other tasks
           "KILL(k)") ; Task was cancelled, aborted or is no longer applicable
          (sequence
           "[ ](T)"   ; A task that needs doing
           "[-](S)"   ; Task is in progress
           "[?](W)"   ; Task is being held up or paused
           "|"
           "[X](D)")) ; Task was completed
        org-todo-keyword-faces
        '(("[-]"  . +org-todo-active)
          ("STRT" . +org-todo-active)
          ("[?]"  . +org-todo-onhold)
          ("WAIT" . +org-todo-onhold)
          ("HOLD" . +org-todo-onhold)
          ("PROJ" . +org-todo-project)))
(setq +lookup-dictionary-prefer-offline nil)
  (add-to-list 'org-latex-classes
               '("ifac" "\\documentclass{../../aux/ifacconf}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
                 ))
  (add-to-list 'org-latex-classes
               '("cdc" "\\documentclass{../../aux/ieeeconf}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
                 )
               )
(customize-set-value 'org-latex-with-hyperref nil)
  (setq org-indirect-buffer-display 'other-window)
  ;; (setq matlab-shell-command "matlab -noFigureWindows")
  (setq org-babel-octave-shell-command "octave -q ")
  ;; (setq org-babel-octave-shell-command "octave -q -W")
  (setq org-babel-matlab-shell-command "matlab -nosplash -nodesktop ")



  ;; (defun org-babel-octave-evaluate-external-process (body result-type matlabp)
  ;;   "Evaluate BODY in an external octave process."
  ;;   (let ((cmd (if matlabp
  ;;                  org-babel-matlab-shell-command
  ;;                org-babel-octave-shell-command)))
  ;;     (pcase result-type
  ;;       (`output
  ;;        (if matlabp
  ;;            (org-babel-eval "sed -E '1,11d;s,(>> )+$,,'" (org-babel-eval cmd body))
  ;;          (org-babel-eval cmd body))
  ;;        )
  ;;       (`value (let ((tmp-file (org-babel-temp-file "octave-")))
  ;;                 (org-babel-eval
  ;;                  cmd
  ;;                  (format org-babel-octave-wrapper-method body
  ;;                          (org-babel-process-file-name tmp-file 'noquote)
  ;;                          (org-babel-process-file-name tmp-file 'noquote)))
  ;;                 (org-babel-octave-import-elisp-from-file tmp-file))))))

(setq org-publish-project-alist
      '(

       ;; ... add all the components here (see below)...
        ("docsThese-site"
         :base-directory "~/docsThese/docs/org/"
         :base-extension "org"
         :publishing-directory "~/docsThese/docs/site/"
         :recursive t
         :with-tags nil
         :with-toc nil
         :section-numbers nil
         :exlclude "*slide*.org"
         ;; :publishing-function org-html-publish-to-html
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :body-only t
         )
        ("docsThese-latex"
         :base-directory "~/docsThese/docs/org/"
         :base-extension "org"
         :publishing-directory "~/docsThese/docs/etudes/"
         :exlclude "*slide*.org"
         :recursive t
         :exclude-tags ("html")
         :with-tags nil
         :with-toc nil
         :publishing-function org-latex-publish-to-latex
         ;; :publishing-function org-latex-publish-to-pdf
         ;; :publishing-function (org-latex-publish-to-pdf org-latex-publish-to-latex)
         :headline-levels 4             ; Just the default for this project.
         )
      ))
(defun org-html--toc-text (toc-entries)
  "Return innards of a table of contents, as a string.
TOC-ENTRIES is an alist where key is an entry title, as a string,
and value is its relative level, as an integer."
  (let* ((prev-level (1- (cdar toc-entries)))
	 (start-level prev-level))
    (concat
     (mapconcat
      (lambda (entry)
	(let ((headline (car entry))
	      (level (cdr entry)))
	  (concat
	   (let* ((cnt (- level prev-level))
		  (times (if (> cnt 0) (1- cnt) (- cnt))))
	     (setq prev-level level)
	     (concat
	      (org-html--make-string
	       times (cond ((> cnt 0) "\n<ol>\n<li>")
			   ((< cnt 0) "</li>\n</ol>\n")))
	      (if (> cnt 0) "\n<ol>\n<li>" "</li>\n<li>")))
	   headline)))
      toc-entries "")
     (org-html--make-string (- prev-level start-level) "</li>\n</ol>\n"))))




)

(after! deft
    (setq deft-directory "~/org/")
    (setq deft-recursive t)
)
;; kanban
(after! org-kanban
  :config
(defun org-kanban//link-for-heading (heading file description)
  "Create a link for a HEADING optionally USE-FILE a FILE and DESCRIPTION."
  (if heading
      (format "[[*%s][%s]]" heading description)
    (error "Illegal state")))
  )

;; Roam
(after! org-roam

  (setq org-roam-graph-viewer (executable-find "vimb"))
  (setq org-roam-graph-executable "/usr/bin/neato")
  (setq org-roam-directory "~/org/")
  (setq org-roam-graph-extra-config '(("overlap" . "false")))
  (setq org-roam-graph-exclude-matcher '("private" "ledger" "elfeed" "readinglist"))

    (setq bibtex-completion-bibliography '("~/docsThese/bibliography.bib")
          bibtex-completion-library-path '("~/docsThese/bibliography/")
          bibtex-completion-find-note-functions '(orb-find-note-file)
          )




(setq org-roam-dailies-capture-templates
  '(("d" "daily" plain (function org-roam-capture--get-point)
     ""
     :immediate-finish t
     :file-name "private-%<%Y-%m-%d>"
     :head "#+TITLE: %<%Y-%m-%d>")))

(defun my/org-roam--backlinks-list-with-content (file)
  (with-temp-buffer
    (if-let* ((backlinks (org-roam--get-backlinks file))
              (grouped-backlinks (--group-by (nth 0 it) backlinks)))
        (progn
          (insert (format "\n\n* %d Backlinks\n"
                          (length backlinks)))
          (dolist (group grouped-backlinks)
            (let ((file-from (car group))
                  (bls (cdr group)))
              (insert (format "** [[file:%s][%s]]\n"
                              file-from
                              (org-roam--get-title-or-slug file-from)))
              (dolist (backlink bls)
                (pcase-let ((`(,file-from _ ,props) backlink))
                  (insert (s-trim (s-replace "\n" " " (plist-get props :content))))
                  (insert "\n\n")))))))
    (buffer-string)))


(defun my/org-roam--backlinks-list (file)
  (if (org-roam--org-roam-file-p file)
      (--reduce-from
       (concat acc (format "- [[file:%s][%s]]\n"
                           (file-relative-name (car it) org-roam-directory)
                                 (org-roam--get-title-or-slug (car it))))
       "" (org-roam-db-query [:select [from] :from links :where (= to $s1)] file))
    ""))

(defun my/org-export-preprocessor (backend)
    (let ((links (my/org-roam--backlinks-list (buffer-file-name))))
      (unless (string= links "")
        (save-excursion
          (goto-char (point-max))
          (insert (concat "\n* Backlinks\n") links)))))
)
(after! org-capture
  (setq org-capture-templates
        ;; (append
                '(
                  ("a" "Agenda")
                  ("aa" "All Day")
                  ("aas" "Supelec" entry (file "~/org/private/fromSupelec.org")
                   "* %?\n %^t\n"
                   :kill-buffer t)
                  ("aap" "Poli" entry (file "~/org/private/fromPoli.org")
                   "* %?\n %^t\n"
                   :kill-buffer t)
                  ("aag" "Gmail" entry (file "~/org/private/fromGmail.org")
                   "* %?\n %^t\n"
                   :kill-buffer t)

                  ("as" "Scheduled")
                  ("ass" "Supelec" entry (file "~/org/private/fromSupelec.org")
                   "* %?\n %^T--%^T\n"
                   :kill-buffer t)
                  ("asp" "Poli" entry (file "~/org/private/fromPoli.org")
                   "* %?\n %^T--%^T\n"
                   :kill-buffer t)
                  ("asg" "Gmail" entry (file "~/org/private/fromGmail.org")
                   "* %?\n %^T--%^T\n"
                   :kill-buffer t)

                  ("t" "TODOS" )
                  ("tp" "Todo Pessoal" entry (file+headline "~/org/private/todo.org" "Inbox")
                   "** TODO %?\n%i%a "
                   :kill-buffer t)

                  ("tt" "Todo These" entry (file+headline "~/org/private/todo_these.org" "Inbox")
                   "** TODO %?\n%i%a "
                   :kill-buffer t)

                  ("e" "Evelise" entry (file+headline "~/org/private/Eve.org" "Inbox")
                   "** TODO %?\n%i%a "
                   :kill-buffer t)
                  )
                ;; org-capture-templates)
        )

)


(use-package! emojify
  :hook (after-init . global-emojify-mode)
  :config
  (setq emojify-display-style 'image)
  (setq emojify-emoji-styles '(unicode github))
  (setq emojify-point-entered-behaviour 'uncover)
  (setq emojify-company-tooltips-p t)
  (setq emojify-composed-text-p t)
  )

(use-package! org-krita
  :config
  (add-hook 'org-mode-hook 'org-krita-mode))

;; org-ref
(use-package! org-ref)
(after! org-ref
    (setq org-ref-default-bibliography '("~/docsThese/bibliography.bib")
          org-ref-pdf-directory "~/docsThese/bibliography/"
          org-ref-note-title-format "* TODO %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n"
          org-ref-notes-directory "~/org/"
          org-ref-notes-function 'orb-edit-notes)
    )
(use-package! org-roam-bibtex
  :after (org-roam)
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  ;; (setq org-roam-server-host "172.16.3.168")
  (setq orb-preformat-keywords
   '("=key=" "title" "url" "file" "author-or-editor" "keywords"))
  (setq orb-templates
        '(("r" "ref" plain (function org-roam-capture--get-point)
           ""
           :file-name "${=key=}"
           :head "#+TITLE: ${=key=}: ${title}
#+ROAM_KEY: ${ref}
#+ROAM_TAGS: article

- tags ::
- keywords :: ${keywords}


* ${title}
  :PROPERTIES:
  :Custom_ID: ${=key=}
  :URL: ${url}
  :AUTHOR: ${author-or-editor}
  :NOTER_DOCUMENT: %(file-relative-name (orb-process-file-field \"${=key=}\") (print org-directory))
  :NOTER_PAGE:
  :END:

** CATALOG

*** Motivation :springGreen:
*** Model :lightSkyblue:
*** Remarks
*** Applications
*** Expressions
*** References :violet:

** NOTES
"
           :unnarrowed t))))

  (org-roam-bibtex-mode)
(use-package! org-roam-server)
;; org-journal
(use-package! org-journal
  :bind
  ("C-c n j" . org-journal-new-entry)
  ("C-c n t" . org-journal-today)
  :config
  (setq org-journal-date-prefix "#+TITLE: "
        org-journal-time-prefix "* "
        org-journal-file-format "private-%Y-%m-%d.org"
        org-journal-dir "~/org/"
        org-journal-carryover-items nil
        org-journal-date-format "%Y-%m-%d")
  ;; do not create title for dailies
  (set-file-template! "/private-.*\\.org$"    :trigger ""    :mode 'org-mode)
  (print +file-templates-alist)
  (defun org-journal-today ()
    (interactive)
    (org-journal-new-entry t)))

;; org-noter
(use-package! org-noter
  :config
  (setq
   org-noter-pdftools-markup-pointer-color "yellow"
   org-noter-notes-search-path '("~/org")
   ;; org-noter-insert-note-no-questions t
   org-noter-doc-split-fraction '(0.7 . 03)
   org-noter-always-create-frame nil
   org-noter-hide-other nil
   org-noter-pdftools-free-pointer-icon "Note"
   org-noter-pdftools-free-pointer-color "red"
   org-noter-kill-frame-at-session-end nil
   )
  (map! :map (pdf-view-mode)
        :leader
        (:prefix-map ("n" . "notes")
          :desc "Write notes"                    "w" #'org-noter)
        )
  )
(use-package! org-pdftools
  :hook (org-load . org-pdftools-setup-link))


(use-package! org-noter-pdftools
  :after org-noter
  :config
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Spell-check and grammar
(let ((langs '("american" "fr_FR" "pt_BR")))
      (setq lang-ring (make-ring (length langs)))
      (dolist (elem langs) (ring-insert lang-ring elem)))
(let ((dics '("american-english" "french" "portuguese")))
      (setq dic-ring (make-ring (length dics)))
      (dolist (elem dics) (ring-insert dic-ring elem)))

  (defun cycle-ispell-languages ()
      (interactive)
      (let (
            (lang (ring-ref lang-ring -1))
            (dic (ring-ref dic-ring -1))
            )
        (ring-insert lang-ring lang)
        (ring-insert dic-ring dic)
        (ispell-change-dictionary lang)
        (setq ispell-complete-word-dict (concat "/usr/share/dict/" dic))
        ))
(global-set-key [f6] 'cycle-ispell-languages)

(load! "diction")
;; (add-to-list 'load-path "~/.emacs.d/lisp")

(setq langtool-language-tool-jar
      "/snap/languagetool/current/usr/bin/languagetool-commandline.jar")
(setq langtool-user-arguments '("--languagemodel" "/usr/local/LanguageTool-n-gram/"))
;; (setq langtool-user-arguments '(("-l" "en-US") ("--languagemodel" "~/Downloads/ngrams"))
(setq diction-command "diction -s -L")
(setq diction-diction "diction -s -L")

;; LaTeX
(eval-after-load "tex"
  '(progn
     (add-to-list
      'TeX-command-list
      '("escaped LaTeX"
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
 ;; (reftex-parse-all)
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


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; hooks
(add-hook
     'after-save-hook
     'executable-make-buffer-file-executable-if-script-p)
(add-hook
 'org-export-before-processing-hook
 'my/org-export-preprocessor)
(add-hook 'prog-mode-hook (lambda () (idle-highlight-mode t)))
(add-hook 'org-mode-hook (lambda () (idle-highlight-mode t)))
(add-to-list 'auto-mode-alist '("mutt" . mail-mode))


;; shortcuts
(global-set-key (kbd "<f5>") 'revert-buffer)

(setq frame-title-format "%b")
(global-prettify-symbols-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   (quote
    ((ispell-complete-word-dict . "/usr/share/dict/american-english")
     (ispell-dictionary . "en")
     (ispell-complete-word-dict . "/usr/share/dict/french")
     (ispell-dictionary . "fr")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; elegance
(defun set-face (face style)
  "Reset a face and make it inherit style."
  (set-face-attribute face nil
   :foreground 'unspecified :background 'unspecified
   :family     'unspecified :slant      'unspecified
   :weight     'unspecified :height     'unspecified
   :underline  'unspecified :overline   'unspecified
   :box        'unspecified :inherit    style))
;;
;; Light theme
(defface face-critical nil
"Critical face is for information that requires immediate action.
It should be of high constrast when compared to other faces. This
can be realized (for example) by setting an intense background
color, typically a shade of red. It must be used scarcely."
:group 'elegance)

(defface face-popout nil
"Popout face is used for information that needs attention.
To achieve such effect, the hue of the face has to be
sufficiently different from other faces such that it attracts
attention through the popout effect."
:group 'elegance)

(defface face-strong nil
"Strong face is used for information of a structural nature.
It has to be the same color as the default color and only the
weight differs by one level (e.g., light/regular or
regular/bold). IT is generally used for titles, keywords,
directory, etc."
:group 'elegance)

(defface face-salient nil
"Salient face is used for information that are important.
To suggest the information is of the same nature but important,
the face uses a different hue with approximately the same
intensity as the default face. This is typically used for links."

:group 'elegance)

(defface face-faded nil
"Faded face is for information that are less important.
It is made by using the same hue as the default but with a lesser
intensity than the default. It can be used for comments,
secondary information and also replace italic (which is generally
abused anyway)."
:group 'elegance)

(defface face-subtle nil
"Subtle face is used to suggest a physical area on the screen.
It is important to not disturb too strongly the reading of
information and this can be made by setting a very light
background color that is barely perceptible."
:group 'elegance)
;; (defun elegance-light ()
;;     (setq frame-background-mode 'light)
;;     (set-background-color "#ffffff")
;;     (set-foreground-color "#333333")
;;     (set-face-attribute 'default nil
;;                         :foreground (face-foreground 'default)
;;                         :background (face-background 'default))
;;     (set-face-attribute 'face-critical nil :foreground "#ffffff"
;;                                            :background "#ff6347")
;;     (set-face-attribute 'face-popout nil :foreground "#ffa07a")
;;     (set-face-attribute 'face-strong nil :foreground "#339333"
;;                                          :weight 'regular)
;;     (set-face-attribute 'face-salient nil :foreground "#00008b"
;;                                           :weight 'light)
;;     (set-face-attribute 'face-faded nil :foreground "#999999"
;;                                         :weight 'light)
;;     (set-face-attribute 'face-subtle nil :background "#f0f0f0")

;;     ;; (set-modeline-faces)

;;     ;; (with-eval-after-load 'cus-edit (set-button-faces))
;;     )

;; ;; Dark theme
(defun elegance-dark ()
    ;; (setq frame-background-mode 'dark)
    ;; (set-background-color "#3f3f3f")
    ;; (set-foreground-color "#dcdccc")
    ;; (set-face-attribute 'default nil
    ;;                     :foreground (face-foreground 'default)
    ;;                     :background (face-background 'default))
    (set-face-attribute 'face-critical nil :foreground "#385f38"
                                           :background "#f8f893")
    (set-face-attribute 'face-popout nil :foreground "#f0dfaf")
    (set-face-attribute 'face-strong nil :foreground "#dcdccc"
                                         :weight 'regular)
    (set-face-attribute 'face-salient nil :foreground "seagreen4"
                                          :weight 'bold)
    (set-face-attribute 'face-faded nil :foreground "#777767"
                                        :weight 'light)
    (set-face-attribute 'face-subtle nil :background "#4f4f4f")
    ;; (set-modeline-faces)
    ;; (with-eval-after-load 'cus-edit (set-button-faces))
    )

;; Set theme
(elegance-dark)
(set-face 'bold                                          'face-strong)
(set-face 'italic                                         'face-faded)
(set-face 'bold-italic                                   'face-strong)
(set-face 'region                                        'face-subtle)
(set-face 'highlight                                     'face-subtle)
(set-face 'fixed-pitch                                       'default)
(set-face 'fixed-pitch-serif                                 'default)
;; (set-face 'variable-pitch                                    'default)
;; (set-face 'cursor                                            'default)

;; ;; Semantic
;; ;; (set-face 'shadow                                         'face-faded)
;; ;; (set-face 'success                                      'face-salient)
;; ;; (set-face 'warning                                       'face-popout)
;; ;; (set-face 'error                                       'face-critical)

;; ;; General
;; (set-face 'buffer-menu-buffer                            'face-strong)
;; (set-face 'minibuffer-prompt                             'face-strong)
;; (set-face 'link                                         'face-salient)
;; (set-face 'fringe                                         'face-faded)
;; (set-face 'isearch                                       'face-strong)
;; (set-face 'isearch-fail                                   'face-faded)
;; (set-face 'lazy-highlight                                'face-subtle)
;; (set-face 'trailing-whitespace                           'face-subtle)
;; (set-face 'show-paren-match                              'face-popout)
;; (set-face 'show-paren-mismatch                           'face-normal)
;; (set-face-attribute 'tooltip nil                         :height 0.85)

;; ;; Programmation mode
;; (set-face 'font-lock-comment-face                         'face-faded)
;; (set-face 'font-lock-doc-face                             'face-faded)
;; (set-face 'font-lock-string-face                         'face-popout)
;; (set-face 'font-lock-constant-face                      'face-salient)
;; (set-face 'font-lock-warning-face                        'face-popout)
;; (set-face 'font-lock-function-name-face                  'face-strong)
;; (set-face 'font-lock-variable-name-face                  'face-strong)
;; (set-face 'font-lock-builtin-face                       'face-salient)
;; (set-face 'font-lock-type-face                          'face-salient)
;; (set-face 'font-lock-keyword-face                       'face-salient)

;; ;; Documentation
;; (with-eval-after-load 'info
;;   (set-face 'info-menu-header                            'face-strong)
;;   (set-face 'info-header-node                            'face-normal)
;;   (set-face 'Info-quoted                                  'face-faded)
;;   (set-face 'info-title-1                                'face-strong)
;;   (set-face 'info-title-2                                'face-strong)
;;   (set-face 'info-title-3                                'face-strong)
;;   (set-face 'info-title-4                               'face-strong))

;; ;; Bookmarks
;; (with-eval-after-load 'bookmark
;;   (set-face 'bookmark-menu-heading                       'face-strong)
;;   (set-face 'bookmark-menu-bookmark                    'face-salient))

;; ;; Message
;; (with-eval-after-load 'message
;;   (set-face 'message-cited-text                           'face-faded)
;;   (set-face 'message-header-cc                               'default)
;;   (set-face 'message-header-name                         'face-strong)
;;   (set-face 'message-header-newsgroups                       'default)
;;   (set-face 'message-header-other                            'default)
;;   (set-face 'message-header-subject                     'face-salient)
;;   (set-face 'message-header-to                          'face-salient)
;;   (set-face 'message-header-xheader                          'default)
;;   (set-face 'message-mml                                 'face-popout)
;;   (set-face 'message-separator                           'face-faded))

;; ;; Outline
(eval-after-load 'org-mode ( progn
  (set-face-attribute 'org-level-1 nil :weight 'regular)
  (set-face-attribute 'org-level-2 nil :weight 'regular)
  (set-face-attribute 'org-level-3 nil :weight 'regular)
  (set-face-attribute 'org-level-4 nil :weight 'regular)
  (set-face-attribute 'org-level-5 nil :weight 'regular)
  (set-face-attribute 'org-level-6 nil :weight 'regular)
  (set-face-attribute 'org-level-7 nil :weight 'regular)
  (set-face-attribute 'org-level-8 nil :weight 'regular)
;;   (set-face 'outline-2                                   'face-strong)
;;   (set-face 'outline-3                                   'face-strong)
;;   (set-face 'outline-4                                   'face-strong)
;;   (set-face 'outline-5                                   'face-strong)
;;   (set-face 'outline-6                                   'face-strong)
;;   (set-face 'outline-7                                   'face-strong)
;;   (set-face 'outline-8                                  'face-strong)
  )
)
;; ;; Interface
;; (with-eval-after-load 'cus-edit
;;   (set-face 'widget-field                                'face-subtle)
;;   (set-face 'widget-button                               'face-strong)
;;   (set-face 'widget-single-line-field                    'face-subtle)
;;   (set-face 'custom-group-subtitle                       'face-strong)
;;   (set-face 'custom-group-tag                            'face-strong)
;;   (set-face 'custom-group-tag-1                          'face-strong)
;;   (set-face 'custom-comment                               'face-faded)
;;   (set-face 'custom-comment-tag                           'face-faded)
;;   (set-face 'custom-changed                             'face-salient)
;;   (set-face 'custom-modified                            'face-salient)
;;   (set-face 'custom-face-tag                             'face-strong)
;;   (set-face 'custom-variable-tag                             'default)
;;   (set-face 'custom-invalid                              'face-popout)
;;   (set-face 'custom-visibility                          'face-salient)
;;   (set-face 'custom-state                               'face-salient)
;;   (set-face 'custom-link                               'face-salient))

;; ;; Package
;; (with-eval-after-load 'package
;;   (set-face 'package-description                             'default)
;;   (set-face 'package-help-section-name                       'default)
;;   (set-face 'package-name                               'face-salient)
;;   (set-face 'package-status-avail-obso                    'face-faded)
;;   (set-face 'package-status-available                        'default)
;;   (set-face 'package-status-built-in                    'face-salient)
;;   (set-face 'package-status-dependency                  'face-salient)
;;   (set-face 'package-status-disabled                      'face-faded)
;;   (set-face 'package-status-external                         'default)
;;   (set-face 'package-status-held                             'default)
;;   (set-face 'package-status-incompat                      'face-faded)
;;   (set-face 'package-status-installed                   'face-salient)
;;   (set-face 'package-status-new                              'default)
;;   (set-face 'package-status-unsigned                         'default)

;;   ;; Button face is hardcoded, we have to redefine the relevant
;;   ;; function
;;   (defun package-make-button (text &rest properties)
;;     "Insert button labeled TEXT with button PROPERTIES at point.
;; PROPERTIES are passed to `insert-text-button', for which this
;; function is a convenience wrapper used by `describe-package-1'."
;;     (let ((button-text (if (display-graphic-p)
;;                            text (concat "[" text "]")))
;;           (button-face (if (display-graphic-p)
;;                            '(:box `(:line-width 1
;;                              :color "#999999":style nil)
;;                             :foreground "#999999"
;;                             :background "#F0F0F0")
;;                          'link)))
;;       (apply #'insert-text-button button-text
;;              'face button-face 'follow-link t properties)))
;;   )

;; ;; Ido
;; (with-eval-after-load 'ido
;;   (set-face 'ido-first-match                            'face-salient)
;;   (set-face 'ido-only-match                               'face-faded)
;;   (set-face 'ido-subdir                                 'face-strong))

;; ;; Diff
;; (with-eval-after-load 'diff-mode
;;   (set-face 'diff-header                                  'face-faded)
;;   (set-face 'diff-file-header                            'face-strong)
;;   (set-face 'diff-context                                    'default)
;;   (set-face 'diff-removed                                 'face-faded)
;;   (set-face 'diff-changed                                'face-popout)
;;   (set-face 'diff-added                                 'face-salient)
;;   (set-face 'diff-refine-added            '(face-salient face-strong))
;;   (set-face 'diff-refine-changed                         'face-popout)
;;   (set-face 'diff-refine-removed                          'face-faded)
;;   (set-face-attribute     'diff-refine-removed nil :strike-through t))

;; ;; Term
;; (with-eval-after-load 'term
;;   ;; (setq eterm-256color-disable-bold nil)
;;   (set-face 'term-bold                                   'face-strong)
;;   (set-face-attribute 'term-color-black nil
;;                                 :foreground (face-foreground 'default)
;;                                :background (face-foreground 'default))
;;   (set-face-attribute 'term-color-white nil
;;                               :foreground "white" :background "white")
;;   (set-face-attribute 'term-color-blue nil
;;                           :foreground "#42A5F5" :background "#BBDEFB")
;;   (set-face-attribute 'term-color-cyan nil
;;                           :foreground "#26C6DA" :background "#B2EBF2")
;;   (set-face-attribute 'term-color-green nil
;;                           :foreground "#66BB6A" :background "#C8E6C9")
;;   (set-face-attribute 'term-color-magenta nil
;;                           :foreground "#AB47BC" :background "#E1BEE7")
;;   (set-face-attribute 'term-color-red nil
;;                           :foreground "#EF5350" :background "#FFCDD2")
;;   (set-face-attribute 'term-color-yellow nil
;;                          :foreground "#FFEE58" :background "#FFF9C4"))

;; ;; org-agende
;; ;; (with-eval-after-load 'org-agenda
;; ;;   (set-face 'org-agenda-calendar-event                    'default)
;; ;;   (set-face 'org-agenda-calendar-sexp                     'face-faded)
;; ;;   (set-face 'org-agenda-clocking                          'face-faded)
;; ;;   (set-face 'org-agenda-column-dateline                   'face-faded)
;; ;;   (set-face 'org-agenda-current-time                      'face-faded)
;; ;;   (set-face 'org-agenda-date                            'face-salient)
;; ;;   (set-face 'org-agenda-date-today        '(face-salient face-strong))
;; ;;   (set-face 'org-agenda-date-weekend                      'face-faded)
;; ;;   (set-face 'org-agenda-diary                             'face-faded)
;; ;;   (set-face 'org-agenda-dimmed-todo-face                  'face-faded)
;; ;;   (set-face 'org-agenda-done                              'face-faded)
;; ;;   (set-face 'org-agenda-filter-category                   'face-faded)
;; ;;   (set-face 'org-agenda-filter-effort                     'face-faded)
;; ;;   (set-face 'org-agenda-filter-regexp                     'face-faded)
;; ;;   (set-face 'org-agenda-filter-tags                       'face-faded)
;; ;;   (set-face 'org-agenda-property-face                     'face-faded)
;; ;;   (set-face 'org-agenda-restriction-lock                  'face-faded)
;; ;;   (set-face 'org-agenda-structure                        'face-faded))

;; ;; org mode
;; ;;
;; (after! org
;;   ;; (with-eval-after-load 'org


  (set-face 'org-archived                                 'face-faded)
  (set-face 'org-block                                    'face-faded)
  (set-face 'org-block-begin-line                         'face-faded)
  (set-face 'org-block-end-line                           'face-faded)
  (set-face 'org-checkbox                                 'face-faded)
  (set-face 'org-checkbox-statistics-done                 'face-faded)
  (set-face 'org-checkbox-statistics-todo                 'face-faded)
  (set-face 'org-clock-overlay                            'face-faded)
  (set-face 'org-code                                     'face-faded)
  (set-face 'org-column                                   'face-faded)
  (set-face 'org-column-title                             'face-faded)
  (set-face 'org-date                                     'face-faded)
  (set-face 'org-date-selected                            'face-faded)
  (set-face 'org-default                                  'face-faded)
  (set-face 'org-document-info                            'face-faded)
  (set-face 'org-document-info-keyword                    'face-faded)
  (set-face 'org-document-title                           'face-faded)
  (set-face 'org-done                                        'default)
  (set-face 'org-drawer                                   'face-faded)
  (set-face 'org-ellipsis                                 'face-faded)
  (set-face 'org-footnote                                 'face-faded)
  (set-face 'org-formula                                  'face-faded)
  (set-face 'org-headline-done                            'face-faded)
;;  (set-face 'org-hide                                     'face-faded)
;;  (set-face 'org-indent                                   'face-faded)
  (set-face 'org-latex-and-related                        'face-faded)
  (set-face 'org-link                                   'face-salient)
  (set-face 'org-list-dt                                  'face-faded)
  (set-face 'org-macro                                    'face-faded)
  (set-face 'org-meta-line                                'face-faded)
  (set-face 'org-mode-line-clock                          'face-faded)
  (set-face 'org-mode-line-clock-overrun                  'face-faded)
  (set-face 'org-priority                                 'face-faded)
  (set-face 'org-property-value                           'face-faded)
  (set-face 'org-quote                                    'face-faded)
  (set-face 'org-scheduled                                'face-faded)
  (set-face 'org-scheduled-previously                     'face-faded)
  (set-face 'org-scheduled-today                          'face-faded)
  (set-face 'org-sexp-date                                'face-faded)
  (set-face 'org-special-keyword                          'face-faded)
  (set-face 'org-table                                    'face-faded)
  (set-face 'org-tag                                      'face-faded)
  (set-face 'org-tag-group                                'face-faded)
  (set-face 'org-target                                   'face-faded)
  (set-face 'org-time-grid                                'face-faded)
  (set-face 'org-todo                                    'face-popout)
  (set-face 'org-upcoming-deadline                        'face-faded)
  (set-face 'org-verbatim                                 'face-faded)
  (set-face 'org-verse                                    'face-faded)
  (set-face 'org-warning                                'face-popout)
;;   )

;; ;; Mu4e
;; (with-eval-after-load 'mu4e
;;   (set-face 'mu4e-attach-number-face                     'face-strong)
;;   (set-face 'mu4e-cited-1-face                            'face-faded)
;;   (set-face 'mu4e-cited-2-face                            'face-faded)
;;   (set-face 'mu4e-cited-3-face                            'face-faded)
;;   (set-face 'mu4e-cited-4-face                            'face-faded)
;;   (set-face 'mu4e-cited-5-face                            'face-faded)
;;   (set-face 'mu4e-cited-6-face                            'face-faded)
;;   (set-face 'mu4e-cited-7-face                            'face-faded)
;;   (set-face 'mu4e-compose-header-face                     'face-faded)
;;   (set-face 'mu4e-compose-separator-face                  'face-faded)
;;   (set-face 'mu4e-contact-face                          'face-salient)
;;   (set-face 'mu4e-context-face                            'face-faded)
;;   (set-face 'mu4e-draft-face                              'face-faded)
;;   (set-face 'mu4e-flagged-face                            'face-faded)
;;   (set-face 'mu4e-footer-face                             'face-faded)
;;   (set-face 'mu4e-forwarded-face                          'face-faded)
;;   (set-face 'mu4e-header-face                                'default)
;;   (set-face 'mu4e-header-highlight-face                  'face-subtle)
;;   (set-face 'mu4e-header-key-face                        'face-strong)
;;   (set-face 'mu4e-header-marks-face                       'face-faded)
;;   (set-face 'mu4e-header-title-face                      'face-strong)
;;   (set-face 'mu4e-header-value-face                          'default)
;;   (set-face 'mu4e-highlight-face                         'face-popout)
;;   (set-face 'mu4e-link-face                             'face-salient)
;;   (set-face 'mu4e-modeline-face                           'face-faded)
;;   (set-face 'mu4e-moved-face                              'face-faded)
;;   (set-face 'mu4e-ok-face                                 'face-faded)
;;   (set-face 'mu4e-region-code                             'face-faded)
;;   (set-face 'mu4e-replied-face                          'face-salient)
;;   (set-face 'mu4e-special-header-value-face                  'default)
;;   (set-face 'mu4e-system-face                             'face-faded)
;;   (set-face 'mu4e-title-face                             'face-strong)
;;   (set-face 'mu4e-trashed-face                            'face-faded)
;;   (set-face 'mu4e-unread-face                            'face-strong)
;;   (set-face 'mu4e-url-number-face                         'face-faded)
;;   (set-face 'mu4e-view-body-face                             'default)
;;   (set-face 'mu4e-warning-face                            'face-faded))
