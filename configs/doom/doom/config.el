;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Rafael Accácio Nogueira"
      user-mail-address "raccacio@poli.ufrj.br")

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
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;;Visual
;;
(after! ivy-posframe
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
  )

(remove-hook 'prog-mode-hook 'hl-line-mode)
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

;; Org
(setq org-directory "~/org/")
(after! org
(setq org-agenda-files
      (list
       "~/org/Eve.org"
       "~/org/todo.org"
       "~/org/todo_these.org"
       "~/org/fromPoli.org"
       "~/org/fromGmail.org"
       "~/org/fromSupelec.org"
       )
      )

(setq +pretty-code-symbols
  '(;; org
    :html  ""
    :author ""
    :title "T"
    :mail ""
    :noweb ""
    :language ""
    :options ""
    :tex      ""
    :matlab ""
    :octave ""
    :python ""
    :emacs ""
    ) )

(set-pretty-symbols! 'org-mode
  :def "function"
  :html "#+HTML:"
  :title "#+title:"
  :title "#+TITLE:"
  :author "#+author:"
  :noweb ":noweb yes"
  :mail "#+email:"
  :mail "#+EMAIL:"
  :author "#+AUTHOR:"
  :options "#+OPTIONS:"
  :author"#+author:"
  :language "#+LANGUAGE:"
  :language "#+language:"
  :tex "#+LaTeX:"
  :tex "latex:"
  :tex "#+LaTeX_HEADER:"
  :matlab "matlab"
  :matlab "octave"
  :python "python"
  :emacs "emacs-lisp"
  )
(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))
(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("cache=false" "minted"))
(add-to-list 'org-latex-packages-alist '("" "amsmath"))
(add-to-list 'org-latex-packages-alist '("" "tikz"))
(add-to-list 'org-latex-packages-alist '("" "xcolor"))
(setq org-ellipsis " ▼") ;;▼ ⤵
(setq org-superstar-headline-bullets-list '("α" "β" "γ" "δ" "ε" "ζ" "η" "θ" "ι" "κ" "λ" "μ" "ν" "ξ" "ο" "π" "ρ" "σ" "τ" "υ" "φ" "χ" "ψ" "ω"))
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
               '("ifac" "\\documentclass{../aux/ifacconf}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
                 )
               '("cdc" "\\documentclass{../aux/ieeeconf}"
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
  (setq org-babel-matlab-shell-command "matlab -nosplash -nodisplay -nodesktop -nojvm")

(defun org-babel-octave-evaluate-external-process (body result-type matlabp)
  "Evaluate BODY in an external octave process."
  (let ((cmd (if matlabp
		 org-babel-matlab-shell-command
	       org-babel-octave-shell-command)))
    (pcase result-type
      (`output
(if matlabp
		 (org-babel-eval "sed -E '1,11d;s,(>> )+$,,'" (org-babel-eval cmd body))
	       (org-babel-eval cmd body))
       )
      (`value (let ((tmp-file (org-babel-temp-file "octave-")))
	       (org-babel-eval
		cmd
		(format org-babel-octave-wrapper-method body
			(org-babel-process-file-name tmp-file 'noquote)
			(org-babel-process-file-name tmp-file 'noquote)))
	       (org-babel-octave-import-elisp-from-file tmp-file))))))

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
  ;; (setq org-roam-graph-viewer "qutebrowser")
  (setq org-roam-graph-executable "/usr/bin/neato")
  (setq org-roam-graph-extra-config '(("overlap" . "false")))
  (setq org-roam-graph-exclude-matcher '("private" "ledger" "elfeed"))

    (setq bibtex-completion-bibliography
          '("~/docsThese/docs/memoire/bibliography.bib"))
    (setq bibtex-completion-library-path '("~/these/leitura/bibliography/"))



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
        (append
                '(
                  ("a" "Agenda")
                  ("aa" "All Day")
                  ("aas" "Supelec" entry (file "~/org/fromSupelec.org")
                   "* %?\n %^t\n"
                   :kill-buffer t)
                  ("aap" "Poli" entry (file "~/org/fromPoli.org")
                   "* %?\n %^t\n"
                   :kill-buffer t)
                  ("aag" "Gmail" entry (file "~/org/fromGmail.org")
                   "* %?\n %^t\n"
                   :kill-buffer t)

                  ("as" "Scheduled")
                  ("ass" "Supelec" entry (file "~/org/fromSupelec.org")
                   "* %?\n %^T--%^T\n"
                   :kill-buffer t)
                  ("asp" "Poli" entry (file "~/org/fromPoli.org")
                   "* %?\n %^T--%^T\n"
                   :kill-buffer t)
                  ("asg" "Gmail" entry (file "~/org/fromGmail.org")
                   "* %?\n %^T--%^T\n"
                   :kill-buffer t)

                  ("e" "Evelise" entry (file+headline "~/org/Eve.org" "Inbox")
                   "** TODO %?\n%i%a "
                   :kill-buffer t)
                  )
                org-capture-templates)
        )

)



;; org-ref
(after! org-ref
    (setq org-ref-default-bibliography '("~/docsThese/docs/memoire/bibliography.bib")
          org-ref-pdf-directory "~/these/leitura/bibliography/")
    )

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
;; (use-package! org-noter
;;   :config
  (setq org-noter-pdftools-markup-pointer-color "yellow" )
  (setq org-noter-notes-search-path '("~/org"))
  (setq org-noter-always-create-frame nil)
  (setq org-noter-pdftools-free-pointer-icon "Note")
  (setq org-noter-pdftools-free-pointer-color "red")
  (setq org-noter-kill-frame-at-session-end nil)
  (map! :map (pdf-view-mode)
        :leader
        (:prefix-map ("n" . "notes")
          :desc "Write notes"                    "w" #'org-noter)
        )
  ;; )
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
