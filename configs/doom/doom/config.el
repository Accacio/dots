;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Rafael Accácio Nogueira"
      user-mail-address "raccacio@poli.ufrj.br")
;; (setq server-socket-dir "~/.emacs.d/server")

(setq search-whitespace-regexp ".*?")
(setq enable-local-variables t)
(blink-cursor-mode -1)
(show-smartparens-global-mode 1)
(setq blink-cursor-interval .1)
(setq blink-cursor-blinks 2)
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
;; (setq doom-font (font-spec :family "monospace" :size 14))
;; (setq doom-font (font-spec :family "Glass TTY VT220" :size 20))
;; (setq doom-font (font-spec :family "Source Code Pro" :size 16))
(setq doom-font (font-spec :family "Roboto Mono" :size 16))
;; (setq doom-font (font-spec :family "Fira Code" :size 16))


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
          '(95 . 80) '(100 . 100)))))
;; (toggle-transparency)
(toggle-transparency)
(map! :leader
      (:prefix-map ("t" . "toggle")
        :desc "Transparency"                 "T" 'toggle-transparency))



;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-nord)

(custom-theme-set-faces! 'doom-one
  `(font-lock-comment-face :foreground "#8080a7")
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
(defalias '+org--restart-mode-h #'ignore) ;;https://github.com/hlissner/doom-emacs/issues/4832#issuecomment-822845907
  (add-to-list 'org-file-apps '("\\.pdf\\'" . emacs))
(setq org-hide-emphasis-markers t)
(setq org-modules '(ol-bibtex org-habit org-habit-plus))
(setq +org-habit-graph-padding 2)
(setq +org-habit-min-width 30)
(setq +org-habit-graph-window-ratio 0.2)
(setq org-indent-indentation-per-level 1)
(setq org-adapt-indentation nil)
(org-load-modules-maybe t)
(setq org-agenda-files
      (list
       "~/org/private/Eve.org"
       "~/org/private/todo.org"
       "~/org/private/todo_these.org"
       "~/org/private/gcal-orgmode.org"
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

;; todos and others
(after! hl-todo
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(;; For things that need to be done, just not today.
          ("TODO" warning bold)
          ;; For problems that will become bigger problems later if not
          ;; fixed ASAP.
          ("FIXME" error bold)
          ;; For tidbits that are unconventional and not intended uses of the
          ;; constituent parts, and may break in a future update.
          ("HACK" font-lock-constant-face bold)
          ;; For things that were done hastily and/or hasn't been thoroughly
          ;; tested. It may not even be necessary!
          ("REVIEW" font-lock-keyword-face bold)
          ;; For especially important gotchas with a given implementation,
          ;; directed at another user other than the author.
          ("NOTE" success bold)
          ;; For things that just gotta go and will soon be gone.
          ("DEPRECATED" font-lock-doc-face bold)
          ;; For a known bug that needs a workaround
          ("BUG" error bold)
          ;; For warning about a problematic or misguiding code
          ("XXX" font-lock-constant-face bold))
        )
  )
;; TODO(accacio)
(setq org-todo-keywords
      '((sequence
         "TODO(t)"  ; A task that needs doing & is ready to do
         "PROJ(p)"  ; A project, which usually contains other tasks
         "TOREAD(r)"
         "STRT(s)"  ; A task that is in progress
         "WAIT(w)"  ; Something external is holding up this task
         "HOLD(h)"  ; This task is paused/on hold because of me
         "|"
         "DONE(d)"  ; Task successfully completed
         "READ(R)"
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
  (setq matlab-shell-command "matlab")

  (add-hook! 'matlab-mode-hook 'display-line-numbers-mode)

  (setq matlab-shell-command-switches `("-nosplash" "-nodesktop"))
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
         :exclude ".*slide.*.org"
         ;; :publishing-function org-html-publish-to-html
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :body-only t
         )
        ("docsThese-latex"
         :base-directory "~/docsThese/docs/org/"
         :base-extension "org"
         :publishing-directory "~/docsThese/docs/etudes/"
         :exclude ".*slide.*.org"
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
(after! ox-icalendar

(setq org-icalendar-with-timestamps nil)
(setq org-icalendar-use-scheduled '(event-if-not-todo event-if-todo-not-done))
(setq org-icalendar-use-deadline '(event-if-not-todo event-if-todo-not-done))
(setq org-icalendar-store-UID nil)
(defun org-icalendar--vtodo
  (entry uid summary location description categories timezone class)
  "Create a VTODO component.

ENTRY is either a headline or an inlinetask element.  UID is the
unique identifier for the task.  SUMMARY defines a short summary
or subject for the task.  LOCATION defines the intended venue for
the task.  DESCRIPTION provides the complete description of the
task.  CATEGORIES defines the categories the task belongs to.
TIMEZONE specifies a time zone for this TODO only.

Return VTODO component as a string."
  (let ((start (or (and (memq 'todo-start org-icalendar-use-scheduled)
			(org-element-property :scheduled entry))
		   ;; If we can't use a scheduled time for some
		   ;; reason, start task now.
		   (let ((now (decode-time)))
		     (list 'timestamp
			   (list :type 'active
				 :minute-start (nth 1 now)
				 :hour-start (nth 2 now)
				 :day-start (nth 3 now)
				 :month-start (nth 4 now)
				 :year-start (nth 5 now)))))))
    (org-icalendar-fold-string
     (concat "BEGIN:VTODO\n"
	     "UID:" uid "\n"
	     (org-icalendar-dtstamp) "\n"
	     (org-icalendar-convert-timestamp start "DTSTART" nil timezone) "\n"
	     (and (memq 'todo-due org-icalendar-use-deadline)
		  (org-element-property :deadline entry)
		  (concat (org-icalendar-convert-timestamp
			   (org-element-property :deadline entry) "DUE" nil timezone)
			  "\n"))
	     "SUMMARY:" summary "\n"
	     (and (org-string-nw-p location) (format "LOCATION:%s\n" location))
	     (and (org-string-nw-p class) (format "CLASS:%s\n" class))
	     (and (org-string-nw-p description)
		  (format "DESCRIPTION:%s\n" description))
	     "CATEGORIES:" categories "\n"
	     "SEQUENCE:1\n"
	     (format "PRIORITY:%d\n"
		     (let ((pri (or (org-element-property :priority entry)
				    org-priority-default)))
		       (floor (- 9 (* 8. (/ (float (- org-priority-lowest pri))
					    (- org-priority-lowest
					       org-priority-highest)))))))
	     (format "STATUS:%s\n"
		     (if (eq (org-element-property :todo-type entry) 'todo)
			 "NEEDS-ACTION"
		       "COMPLETED"))
	     "END:VTODO"))))

(defun org-icalendar-entry (entry contents info)
  "Transcode ENTRY element into iCalendar format.

ENTRY is either a headline or an inlinetask.  CONTENTS is
ignored.  INFO is a plist used as a communication channel.

This function is called on every headline, the section below
it (minus inlinetasks) being its contents.  It tries to create
VEVENT and VTODO components out of scheduled date, deadline date,
plain timestamps, diary sexps.  It also calls itself on every
inlinetask within the section."
  (unless (org-element-property :footnote-section-p entry)
    (let* ((type (org-element-type entry))
	   ;; Determine contents really associated to the entry.  For
	   ;; a headline, limit them to section, if any.  For an
	   ;; inlinetask, this is every element within the task.
	   (inside
	    (if (eq type 'inlinetask)
		(cons 'org-data (cons nil (org-element-contents entry)))
	      (let ((first (car (org-element-contents entry))))
		(and (eq (org-element-type first) 'section)
		     (cons 'org-data
			   (cons nil (org-element-contents first))))))))
      (concat
       (let ((todo-type (org-element-property :todo-type entry))
	     (uid (or (org-element-property :ID entry) (org-id-new)))
	     (summary (org-icalendar-cleanup-string
		       (or (org-element-property :SUMMARY entry)
			   (org-export-data
			    (org-element-property :title entry) info))))
	     (loc (org-icalendar-cleanup-string
		   (org-export-get-node-property
		    :LOCATION entry
		    (org-property-inherit-p "LOCATION"))))
	     (class (org-icalendar-cleanup-string
		     (org-export-get-node-property
		      :CLASS entry
		      (org-property-inherit-p "CLASS"))))
	     ;; Build description of the entry from associated section
	     ;; (headline) or contents (inlinetask).
	     (desc
	      (org-icalendar-cleanup-string
	       (or (org-element-property :DESCRIPTION entry)
		   (let ((contents (org-export-data inside info)))
		     (cond
		      ((not (org-string-nw-p contents)) nil)
		      ((wholenump org-icalendar-include-body)
		       (let ((contents (org-trim contents)))
			 (substring
			  contents 0 (min (length contents)
					  org-icalendar-include-body))))
		      (org-icalendar-include-body (org-trim contents)))))))
	     (cat (org-icalendar-get-categories entry info))
	     (tz (org-export-get-node-property
		  :TIMEZONE entry
		  (org-property-inherit-p "TIMEZONE"))))
	 (concat
	  ;; Events: Delegate to `org-icalendar--vevent' to generate
	  ;; "VEVENT" component from scheduled, deadline, or any
	  ;; timestamp in the entry.
	  (let ((deadline (org-element-property :deadline entry))
		(use-deadline (plist-get info :icalendar-use-deadline)))
	    (and deadline
		 (pcase todo-type
		   (`todo (or (memq 'event-if-todo-not-done use-deadline)
			      (memq 'event-if-todo use-deadline)))
		   (`done (memq 'event-if-todo use-deadline))
		   (_ (memq 'event-if-not-todo use-deadline)))
		 (org-icalendar--vevent
		  entry deadline (concat "" uid)
		  (concat "" summary) loc desc cat tz class)))
	  (let ((scheduled (org-element-property :scheduled entry))
		(use-scheduled (plist-get info :icalendar-use-scheduled)))
	    (and scheduled
		 (pcase todo-type
		   (`todo (or (memq 'event-if-todo-not-done use-scheduled)
			      (memq 'event-if-todo use-scheduled)))
		   (`done (memq 'event-if-todo use-scheduled))
		   (_ (memq 'event-if-not-todo use-scheduled)))
		 (org-icalendar--vevent
		  entry scheduled (concat "" uid)
		  (concat "" summary) loc desc cat tz class)))
	  ;; When collecting plain timestamps from a headline and its
	  ;; title, skip inlinetasks since collection will happen once
	  ;; ENTRY is one of them.
	  (let ((counter 0))
	    (mapconcat
	     #'identity
	     (org-element-map (cons (org-element-property :title entry)
				    (org-element-contents inside))
		 'timestamp
	       (lambda (ts)
		 (when (let ((type (org-element-property :type ts)))
			 (cl-case (plist-get info :with-timestamps)
			   (active (memq type '(active active-range)))
			   (inactive (memq type '(inactive inactive-range)))
			   ((t) t)))
		   (let ((uid uid))
		     (org-icalendar--vevent
		      entry ts uid summary loc desc cat tz class))))
	       info nil (and (eq type 'headline) 'inlinetask))
	     ""))
	  ;; Task: First check if it is appropriate to export it.  If
	  ;; so, call `org-icalendar--vtodo' to transcode it into
	  ;; a "VTODO" component.
	  (when (and todo-type
		     (cl-case (plist-get info :icalendar-include-todo)
		       (all t)
		       (unblocked
			(and (eq type 'headline)
			     (not (org-icalendar-blocked-headline-p
				   entry info))))
		       ((t) (eq todo-type 'todo))))
	    (org-icalendar--vtodo entry uid summary loc desc cat tz class))
	  ;; Diary-sexp: Collect every diary-sexp element within ENTRY
	  ;; and its title, and transcode them.  If ENTRY is
	  ;; a headline, skip inlinetasks: they will be handled
	  ;; separately.
	  (when org-icalendar-include-sexps
	    (let ((counter 0))
	      (mapconcat #'identity
			 (org-element-map
			     (cons (org-element-property :title entry)
				   (org-element-contents inside))
			     'diary-sexp
			   (lambda (sexp)
			     (org-icalendar-transcode-diary-sexp
			      (org-element-property :value sexp)
			      (format "%s" uid)
			      summary))
			   info nil (and (eq type 'headline) 'inlinetask))
			 "")))))
       ;; If ENTRY is a headline, call current function on every
       ;; inlinetask within it.  In agenda export, this is independent
       ;; from the mark (or lack thereof) on the entry.
       (when (eq type 'headline)
	 (mapconcat #'identity
		    (org-element-map inside 'inlinetask
		      (lambda (task) (org-icalendar-entry task nil info))
		      info) ""))
       ;; Don't forget components from inner entries.
       contents))))


  )
(after! deft
    (setq deft-directory "~/hippokamp/")
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

  (map! :map doom-leader-map "n R" 'elfeed)
(map! :map doom-leader-map "n R" 'elfeed)
(after! elfeed

  ;; (setq elfeed-feeds '(
  ;;                      ;;reddit HN etc
  ;;                      ("https://www.reddit.com/r/controlengineering.rss" control)
  ;;                      ("https://news.ycombinator.com/rss" hacker)
  ;;                      ;; blogs
  ;;                      ("https://www.sthu.org/blog/atom.xml" blogs)
  ;;                      ("https://ciechanow.ski/atom.xml" blogs)
  ;;                      ("https://lepisma.xyz/journal/atom.xml" blogs)
  ;;                      ("https://blog.demofox.org/feed/" blogs)
  ;;                      ;; control Jobs
  ;;                      ("https://accacio.gitlab.io/feeds/statespacejobs.xml" control jobs)
  ;;                      ;; control journals
  ;;                      ("http://rss.sciencedirect.com/publication/science/01676911" S&CL control) ;; ScienceDirect Publication: Systems & Control Letters
  ;;                      ("https://www.aimsciences.org/rss/A0000-0000_current.xml" EE&CT control) ;; Evolution Equations & Control Theory
  ;;                      ("https://ieeexplore.ieee.org/rss/TOC6509490.XML" TOCNS control) ;; IEEE Transaction on Control of Network Systems
  ;;                      ("https://ieeexplore.ieee.org/rss/TOC9.XML" TOAC control) ;; IEEE Transaction on Automatic Control
  ;;                      ("https://onlinelibrary.wiley.com/feed/19346093/most-recent" AJC control) ;; Wiley Asian Journal of Control
  ;;                      ("https://ietresearch.onlinelibrary.wiley.com/feed/17518652/most-recent" IETCT&A control) ;; The Institution of Engineering and Techonology Control Theory & Applications
  ;;                      ("https://www.tandfonline.com/feed/rss/tcon20" T&FIJOC control) ;; Taylor and Francis International Journal of Control
  ;;                      ("https://www.tandfonline.com/feed/rss/tjcd20" T&FJOCD control) ;; Taylor and Francis Journal of Control and Decision
  ;;                      ("http://rss.sciencedirect.com/publication/science/09473580" EJC control) ;; ScienceDirect Publication: European Journal of Control
  ;;                      ("http://rss.sciencedirect.com/publication/science/00051098" Automatica control) ;; ScienceDirect Publication: Automatica
  ;;                      ("http://rss.sciencedirect.com/publication/science/09670661" CEP control) ;; ScienceDirect Publication: Control Engineering Practice
  ;;                      ("http://rss.sciencedirect.com/publication/science/09591524" JPC control) ;; ScienceDirect Publication: Journal of Process Control
  ;;                      ("http://rss.sciencedirect.com/publication/science/00190578" ISATran control) ;; ScienceDirect Publication: ISA Transactions
  ;;                      ("http://rss.sciencedirect.com/publication/science/1751570X" NAHS control) ;; ScienceDirect Publication: Nonlinear Analysis: Hybrid Systems
  ;;                      ("http://rss.sciencedirect.com/publication/science/00160032" JFI control) ;; ScienceDirect Publication: Journal of the Franklin Institute
  ;;                      ("https://onlinelibrary.wiley.com/feed/10991239/most-recent" IJRNC control ) ;; Wiley Internation Journal of Robust and Nonlinear Control
  ;;                      ;; comics
  ;;                      ("https://xkcd.com/rss.xml" comics)
  ;;                      ))

    (require 'org-ref-url-utils)
  (defun accacio/get-bibtex-from-rss ()
    (interactive)
    (let*
        ((entries (elfeed-search-selected)) link links-str dois
        )
      (cl-loop for entry in entries
               when (elfeed-entry-link entry)
               do (progn
                    (setq link (elfeed-entry-link entry))
                    (setq dois (org-ref-url-scrape-dois link))
                    (message (car dois))
                    (doi-utils-add-bibtex-entry-from-doi (car dois))
                    )
               )
      )
  )

(defun accacio/elfeed-search-print-entry (entry)
  "Print ENTRY to the buffer."
  (let* ((date (elfeed-search-format-date (elfeed-entry-date entry)))
         (title (or (elfeed-meta entry :title) (elfeed-entry-title entry) ""))
         (title-faces (elfeed-search--faces (elfeed-entry-tags entry)))
         (feed (elfeed-entry-feed entry))
         (feed-title
          (when feed
            (or (elfeed-meta feed :title) (elfeed-feed-title feed))))
         (tags (mapcar #'symbol-name (elfeed-entry-tags entry)))
         (tags-str (mapconcat
                    (lambda (s) (propertize s 'face 'elfeed-search-tag-face))
                    tags ","))
         (title-width (- (window-width) 10 elfeed-search-trailing-width))
         (title-column (elfeed-format-column
                        title (elfeed-clamp
                               elfeed-search-title-min-width
                               title-width
                               elfeed-search-title-max-width)
                        :left))
         (feed-column (elfeed-format-column
                       feed-title (elfeed-clamp elfeed-goodies/feed-source-column-width
                                                elfeed-goodies/feed-source-column-width
                                                elfeed-goodies/feed-source-column-width)
                       :left)))


    (insert (propertize date 'face 'elfeed-search-date-face) " ")
    (insert (propertize title-column 'face title-faces 'kbd-help title) " ")
    (when feed-title
      (insert (propertize feed-column 'face 'elfeed-search-feed-face) " "))
    (when tags
      (insert "(" tags-str ")"))))

(defun elfeed-search-tag-all (&rest tags)
  "Apply TAG to all selected entries."
  (interactive (list (intern (read-from-minibuffer "Tag: "))))
  (let ((entries (elfeed-search-selected)))
    (cl-loop for tag in tags do (elfeed-tag entries tag))
    (mapc #'elfeed-search-update-entry entries)
    (unless (or elfeed-search-remain-on-entry (use-region-p))
      (forward-line))))

(defun elfeed-search-untag-all (&rest tags)
  "Remove TAG from all selected entries."
  (interactive (list (intern (read-from-minibuffer "Tag: "))))
  (let ((entries (elfeed-search-selected)))
    (cl-loop for value in tags do (elfeed-untag entries value))
    (mapc #'elfeed-search-update-entry entries)
    (unless (or elfeed-search-remain-on-entry (use-region-p))
      (forward-line))))

(defun elfeed-search-toggle-all ( &rest tags)
  "Toggle TAG on all selected entries."
  (interactive (list (intern (read-from-minibuffer "Tag: "))))
  (let ((entries (elfeed-search-selected)) entries-tag entries-untag)
    (cl-loop for tag in tags do
      (cl-loop for entry in entries
             when (elfeed-tagged-p tag entry)
             do (elfeed-untag-1 entry tag)
             else do (elfeed-tag-1 entry tag)))
    (mapc #'elfeed-search-update-entry entries)
    (unless (or elfeed-search-remain-on-entry (use-region-p))
      (forward-line))))

(evil-define-key 'normal elfeed-search-mode-map "i" (lambda () (interactive)(elfeed-search-toggle-all 'important 'readlater)))
(evil-define-key 'visual elfeed-search-mode-map "i" (lambda () (interactive)(elfeed-search-toggle-all 'important 'readlater)))
(evil-define-key 'normal elfeed-search-mode-map "t" (lambda () (interactive)(elfeed-search-toggle-all 'readlater)))
(evil-define-key 'visual elfeed-search-mode-map "t" (lambda () (interactive)(elfeed-search-toggle-all 'readlater)))
(evil-define-key 'visual elfeed-search-mode-map "i" (lambda () (interactive)(elfeed-search-toggle-all 'important )))

(evil-define-key 'normal elfeed-show-mode-map "U" 'elfeed-show-tag--unread)
(evil-define-key 'normal elfeed-show-mode-map "t" (elfeed-expose #'elfeed-show-tag 'readlater))
(evil-define-key 'normal elfeed-show-mode-map "i" (elfeed-expose #'elfeed-show-tag 'important))

(defun elfeed-search-show-entry (entry)
  "Display the currently selected item in a buffer."
  (interactive (list (elfeed-search-selected :ignore-region)))
  (require 'elfeed-show)
  (when (elfeed-entry-p entry)
    ;; (elfeed-untag entry 'unread)
    (elfeed-search-update-entry entry)
    ;; (unless elfeed-search-remain-on-entry (forward-line))
    (elfeed-show-entry entry)))

(defun accacio/elfeed-search-copy-article ()
  (interactive)
  (let ( (entries (elfeed-search-selected)) (links ""))
               (elfeed-search-untag-all 'readlater 'unread)
  (cl-loop for entry in entries
           when (elfeed-entry-link entry)
           do (progn (setq links (concat links (concat "- [ ] " (if (elfeed-tagged-p 'important entry) "* " "") (org-make-link-string  (concat "https://ezproxy.universite-paris-saclay.fr/login?url=" (elfeed-entry-link entry)) (elfeed-entry-title entry)) "\n" )))
               )
           )
  (kill-new links)
  )
  )


(add-hook 'elfeed-new-entry-hook
          (elfeed-make-tagger :before "2 weeks ago"
                              :remove 'unread))

(setq-default elfeed-search-filter "@1-month-ago +unread -readlater")

(elfeed-update)
(defface important-elfeed-entry
  '((t :foreground "#a00"))
  "Marks an control Elfeed entry.")
(defface control-elfeed-entry
  '((t :foreground "#2ba"))
  "Marks an control Elfeed entry.")

(defface readlater-elfeed-entry
  '((t :foreground "#Eec900"))
  "Marks a readlater Elfeed entry.")

(set-face-attribute 'elfeed-search-unread-title-face nil
                    :bold t :strike-through nil :underline nil :foreground "#bbb")

(set-face-attribute 'elfeed-search-title-face nil
                    :bold nil :strike-through t)

(push '(control control-elfeed-entry) elfeed-search-face-alist)
(push '(readlater readlater-elfeed-entry) elfeed-search-face-alist)
(push '(important important-elfeed-entry) elfeed-search-face-alist)

)
(after! bibtex

(defun my-bibtex-autokey-unique (key)
  "Make a unique version of KEY."
  (save-excursion
    (let ((org-ref-bibliography-files (org-ref-find-bibliography))
          (trykey key)
	  (next ?a))
      (while (and
              (org-ref-key-in-file-p trykey (car org-ref-bibliography-files))
		  (<= next ?z))
	(setq trykey (concat key (char-to-string next)))
	(setq next (1+ next)))
      trykey)))

  (setq bibtex-autokey-year-length 4)
  (setq bibtex-autokey-names 1)
  (setq bibtex-autokey-names-stretch 1)
  (setq bibtex-autokey-additional-names "EtAl")
  (setq bibtex-autokey-name-case-convert-function 'capitalize)
  (setq bibtex-maintain-sorted-entries 'entry-class)
  (setq bibtex-autokey-before-presentation-function 'my-bibtex-autokey-unique)
  (defun bibtex-generate-autokey ()
    (let* ((names (bibtex-autokey-get-names))
           (year (bibtex-autokey-get-year))
           (title (bibtex-autokey-get-title))
           (autokey (concat
                     names
                     ;; (unless (or (equal names "")
                     ;;             (equal title ""))
                     ;;   "_") ;; string to separate names from title
                     ;; title
                     ;; (unless (or (and (equal names "")
                     ;;                  (equal title ""))
                     ;;             (equal year ""))
                     ;;   bibtex-autokey-year-title-separator)
                     year
                     bibtex-autokey-prefix-string ;; optional prefix string
                     )))
      (if bibtex-autokey-before-presentation-function
          (funcall bibtex-autokey-before-presentation-function autokey)
        autokey)))
  )


;; Roam
(after! org-roam

  (setq org-roam-graph-viewer (executable-find "vivaldi"))
  ;; (setq org-roam-graph-viewer (executable-find "vimb"))
  (setq org-roam-graph-executable "/usr/bin/neato")
  (setq org-roam-directory "~/hippokamp/brain/")
  (setq org-roam-graph-extra-config '(("overlap" . "false")))
  (setq org-roam-graph-exclude-matcher '("private" "ledger" "elfeed" "readinglist"))
  (setq org-roam-tag-sources '(prop last-directory))
  (setq org-roam-buffer-width .3)

    (setq bibtex-completion-bibliography '("~/docsThese/bibliography.bib")
          bibtex-completion-library-path '("~/docsThese/bibliography/")
          bibtex-completion-find-note-functions '(orb-find-note-file)
          )
    (setq bibtex-completion-notes-template-multiple-files "#+TITLE: ${=key=}
#+ROAM_KEY: ${ref}
#+ROAM_TAGS: article

- tags ::
- keywords :: ${keywords}


* ${title}
  :PROPERTIES:
  :Custom_ID: ${=key=}
  :URL: ${url}
  :AUTHOR: ${author-or-editor}
  :NOTER_DOCUMENT: %(file-relative-name (orb-process-file-field \"${=key=}\") (print org-roam-directory))
  :NOTER_PAGE:
  :END:

** CATALOG

*** Motivation
 # springGreen
*** Model
 # lightSkyblue
*** Remarks
*** Applications
*** Expressions
*** References
 # violet

** NOTES
"
          )
(setq org-roam-capture-ref-templates
  '(("r" "ref" plain #'org-roam-capture--get-point
     "%?"
     :file-name "${slug}"
     :head "#+title: ${title}\n#+roam_key: ${ref}\n\n${ref}\n\n${body}"
     :unnarrowed t)))

    (setq org-roam-dailies-capture-templates
          '(("d" "default" entry #'org-roam-capture--get-point "* %?"
             :file-name "daily/%<%Y-%m-%d>" :head "#+TITLE: %<%Y-%m-%d>\n#+roam_tags: \n\n"))
          )

  ;; (setq org-roam-dailies-capture-templates
  ;;       '(("d" "daily" plain (function org-roam-capture--get-point)
  ;;          ""
  ;;          :immediate-finish t
  ;;          :file-name "private-%<%Y-%m-%d>"
  ;;          :head "#+TITLE: %<%Y-%m-%d>")
  ;;         )
  ;;       )

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

        '(
          ("t" "TODOS" )
         ("tp" "Personal todo" entry
          (file+headline "~/org/private/todo.org" "Inbox")
          "** TODO %?\n%i\n%a" :prepend t)
         ("tt" "These todo" entry
          (file+headline "~/org/private/todo_these.org" "Inbox")
          "** TODO %?\n%i\n%a" :prepend t)
         ("e" "Evelise" entry
          (file+headline "~/org/private/Eve.org" "Inbox")
          "** TODO %?\n%i\n%a" :prepend t)
         ("p" "Templates for projects")
         ("pt" "Project-local todo" entry
          (file+headline +org-capture-project-todo-file "Inbox")
          "* TODO %?\n%i\n%a" :prepend t)
         ("pn" "Project-local notes" entry
          (file+headline +org-capture-project-notes-file "Inbox")
          "* %U %?\n%i\n%a" :prepend t)
         ("pc" "Project-local changelog" entry
          (file+headline +org-capture-project-changelog-file "Unreleased")
          "* %U %?\n%i\n%a" :prepend t)
         ("o" "Centralized templates for projects")
         ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
         ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
         ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t)
         )
  ;;               '(
  ;;                 ("e" "Evelise" entry (file+headline "~/org/private/Eve.org" "Inbox")
  ;;                  "** TODO %?\n%i%a "
  ;;                  :kill-buffer t)
  ;;                 )
  ;;               ;; org-capture-templates)
        )

)

 ;; generate tables for c
(defun orgtbl-to-c (table params)
  "Convert the orgtbl-mode TABLE to c."
  (orgtbl-to-generic
   table
   (org-combine-plists
    '(:hline "t" :hsep "sd" :tstart "{" :tend "};" :lstart "{" :lend "}," :sep ",")
    params)))

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
          org-ref-notes-directory "~/hippokamp/brain/"
          org-ref-notes-function 'orb-edit-notes)

(setq org-ref-bibliography-entry-format
      '(
        ("article" . "%a, %t, <i>%j</i>, <b>%v(%n)</b>, %p (%y). <a href=\"%U\">link</a>. <a href=\"http://dx.doi.org/%D\">doi</a>.")
        ("book" . "%a, %t, %u (%y).")
        ("thesis" . "%a, %t, %s (%y).  <a href=\"%U\">link</a>. <a href=\"http://dx.doi.org/%D\">doi</a>.")
        ("misc" . "%a, %t (%y).  <a href=\"%U\">link</a>. <a href=\"http://dx.doi.org/%D\">doi</a>.")
        ("inbook" . "%a, %t, %b (pp. %p), %u (%y), <a href=\"%U\">link</a>. <a href=\"http://dx.doi.org/%D\">doi</a>.")
        ("techreport" . "%a, %t, %i, %u (%y).")
        ("proceedings" . "%e, %t in %S, %u (%y).")
        ("inproceedings" . "%a, %t, %p, in %b, edited by %e, %u (%y)"))
      )
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
           :head "#+TITLE: ${=key=}
#+ROAM_KEY: ${ref}
#+ROAM_TAGS: article

- tags ::
- keywords :: ${keywords}


* ${title}
  :PROPERTIES:
  :Custom_ID: ${=key=}
  :URL: ${url}
  :AUTHOR: ${author-or-editor}
  :NOTER_DOCUMENT: %(file-relative-name (orb-process-file-field \"${=key=}\") (print org-roam-directory))
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
           :unnarrowed t)))
  (setq orb-autokey-format "%A[3]%y")

  )

  (org-roam-bibtex-mode)
(use-package! org-roam-server
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files t
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

;; org-journal
(use-package! org-journal
  :bind
  ("C-c n j" . org-journal-new-entry)
  ("C-c n t" . org-journal-today)
  :config
  (setq org-journal-date-prefix "#+TITLE: "
        org-journal-date-format "%Y-%m-%d\n"
        org-journal-time-prefix "* "
        org-journal-file-format "%Y-%m-%d.org"
        org-journal-dir "~/hippokamp/brain/daily/"
        )
  ;; do not create title for dailies
  ;; (set-file-template! "daily/.*\\.org$"    :trigger ""    :mode 'org-mode)
  ;; (defun org-journal-today ()
  ;;   (interactive)
  ;;   (org-journal-new-entry t))
    )

;; org-noter
(use-package! org-noter
  :config
  (setq
   org-noter-pdftools-markup-pointer-color "yellow"
   org-noter-notes-search-path '("~/hippokamp/brain/")
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
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)
    )
  )


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(custom-set-faces!
  (set-face-foreground 'line-number "#308030")
  (set-face-foreground 'line-number-current-line "#e0e000")
  ;; (set-face-foreground 'line-number "#308030")
  ;; (set-face-foreground 'line-number-current-line "#735A7E")
)

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
      '("Detex"
        "cat \"%t\"  |  perl -pe \"s:[ \\~]*\\\\\\(eqref|ref|cite)(\\[.*?\\])*\\{.*?\\}: [1]:g\" | detex -lnr -e table,algorithm,figure,equation | sed -e \"/^\\s\*\$/N;/^\\s\*\\n\\s\*\$/D\""
        TeX-run-command nil t :help "Run LaTeX shell escaped")
     t )
     (add-to-list
      'TeX-command-list
      '("LaTeX escaped "
        "%`%l%(mode)%' -shell-escape -interaction nonstopmode %T"
        TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX shell escaped")
      t )
     )
  )
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


