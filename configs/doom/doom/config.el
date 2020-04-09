;;; .doom.d/config.el -*- lexical-binding: t; -*-


(setq user-full-name "Rafael Accácio Nogueira"
      user-mail-address "raccacio@poli.ufrj.br")
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
(setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16TIMESTAMP_IA")
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
      '(("bib" . "~/docsThese/docs/memoire/bibliography.bib::%s")
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

(display-battery-mode)
(setq org-latex-listings 'minted)
(remove-hook 'prog-mode-hook 'hl-line-mode)
(add-hook 'prog-mode-hook 'rainbow-mode t)
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
  ;; (setq org-babel-octave-shell-command "octave -q -W")
  (setq org-ellipsis " ▼") ;;▼ ⤵
  ;; (setq org-bullets-bullet-list '("Α" "Β"  "Γ" "Δ" "Ε" "Ζ" "Η" "Θ" "Ι" "Κ" "Λ" "Μ" "Ν" "Ξ" "Ο" "Π" "Ρ" "Σ" "Τ" "Υ" "Φ" "Χ" "Ψ" "Ω" ))
  (setq org-bullets-bullet-list '("α" "β" "γ" "δ" "ε" "ζ" "η" "θ" "ι" "κ" "λ" "μ" "ν" "ξ" "ο" "π" "ρ" "σ" "τ" "υ" "φ" "χ" "ψ" "ω"))
  (setq org-babel-octave-shell-command "octave -q")
  (setq org-src-window-setup 'current-window
        org-return-follows-link t
        ;; org-babel-load-languages '((emacs-lisp . t)
        ;;                            (python . t)
        ;;                            (dot . t)
        ;;                            (R . t))
        org-confirm-babel-evaluate nil
        ;; org-use-speed-commands t
        ;; org-catch-invisible-edits 'show
        org-preview-latex-image-directory "/tmp/ltximg/"
        org-structure-template-alist '(("a" . "export ascii")
                                       ("c" . "center")
                                       ("C" . "comment")
                                       ("e" . "example")
                                       ("E" . "export")
                                       ("h" . "export html")
                                       ("l" . "export latex")
                                       ("q" . "quote")
                                       ("s" . "src")
                                       ("v" . "verse")
                                       ("el" . "src emacs-lisp")
                                       ("d" . "definition")
                                       ("t" . "theorem")))
  ;; From Jethro
;; (setq org-capture-templates
;;         `(("i" "inbox" entry (file ,(concat jethro/org-agenda-directory "inbox.org"))
;;            "* TODO %?")
;;           ("e" "email" entry (file+headline ,(concat jethro/org-agenda-directory "emails.org") "Emails")
;;                "* TODO [#A] Reply: %a :@home:@school:"
;;                :immediate-finish t)
;;           ("c" "org-protocol-capture" entry (file ,(concat jethro/org-agenda-directory "inbox.org"))
;;                "* TODO [[%:link][%:description]]\n\n %i"
;;                :immediate-finish t)
;;           ("w" "Weekly Review" entry (file+olp+datetree ,(concat jethro/org-agenda-directory "reviews.org"))
;;            (file ,(concat jethro/org-agenda-directory "templates/weekly_review.org")))
;;           ("r" "Reading" todo ""
;;                ((org-agenda-files '(,(concat jethro/org-agenda-directory "reading.org")))))))

;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
;;         (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))

  )
(if (display-graphic-p)
    ()
  (load-theme 'doom-spacegrey t))
(set 'global-linum-mode 1)
(setq display-line-numbers-type 'relative)

;; Try use org-roam (zettelkasten)
(after! deft
    (setq deft-directory "~/org/")
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
               '("e" "Evelise" entry
                 (file+headline "~/org/Eve.org" "Inbox")
                 "** TODO %?\n%i%a "
                 :kill-buffer t)
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

(add-hook 'org-capture-after-finalize-hook (lambda () (org-caldav-sync)))
(add-hook 'org-capture-after-finalize-hook (lambda () (org-caldav-sync)))

;; (add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-post-at-point)))
;;https://orgmode.org/org.html#Publishing
;;https://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.html
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

;; From Jethro
(use-package! notmuch
  :commands (notmuch)
  :init
  (map! :desc "notmuch" "<f12>" #'notmuch)
  ;; (map! :map notmuch-search-mode-map
  ;;       :desc "toggle read" "t" #'+notmuch/toggle-read
  ;;       :desc "Reply to thread" "r" #'notmuch-search-reply-to-thread
  ;;       :desc "Reply to thread sender" "R" #'notmuch-search-reply-to-thread-sender)
  ;; (map! :map notmuch-show-mode-map
  ;;       :desc "Next link" "<tab>" #'org-next-link
  ;;       :desc "Previous link" "<backtab>" #'org-previous-link
  ;;       :desc "URL at point" "C-<return>" #'browse-url-at-point)
  ;; (defun +notmuch/toggle-read ()
  ;;   "toggle read status of message"
  ;;   (interactive)
  ;;   (if (member "unread" (notmuch-search-get-tags))
  ;;       (notmuch-search-tag (list "-unread"))
  ;;     (notmuch-search-tag (list "+unread"))))
  ;; :config
  (defvar +notmuch-mail-folder "~/.local/mail/messages/"
  "Where your email folder is located (for use with gmailieer).")
  (setq message-auto-save-directory "~/.local/mail/messages/drafts/"
        message-send-mail-function 'message-send-mail-with-sendmail
        sendmail-program (executable-find "msmtp")
        message-sendmail-envelope-from 'header
        mail-envelope-from 'header
        mail-specify-envelope-from t
        message-sendmail-f-is-evil nil
        message-kill-buffer-on-exit t
        notmuch-always-prompt-for-sender t
        notmuch-archive-tags '("-inbox" "-unread")
        notmuch-crypto-process-mime t
        notmuch-hello-sections '(notmuch-hello-insert-saved-searches)
        notmuch-labeler-hide-known-labels t
        notmuch-search-oldest-first nil
        notmuch-archive-tags '("-inbox" "-unread")
        notmuch-message-headers '("To" "Cc" "Subject" "Bcc")
        ;; notmuch-saved-searches '((:name "unread" :query "tag:inbox and tag:unread")
        ;;                          (:name "org-roam" :query "tag:inbox and tag:roam")
        ;;                          (:name "personal" :query "tag:inbox and tag:personal")
        ;;                          (:name "nushackers" :query "tag:inbox and tag:nushackers")
        ;;                          (:name "nus" :query "tag:inbox and tag:nus")
        ;;                          (:name "drafts" :query "tag:draft"))
        ))


(use-package! org-roam
  :commands (org-roam-insert org-roam-find-file org-roam)
  :init
  (setq org-roam-directory "~/org")
  (map! :leader
        :prefix "n"
        :desc "Org-Roam-Insert" "i" #'org-roam-insert
        :desc "Org-Roam-Find"   "/" #'org-roam-find-file
        :desc "org-roam-show-graph" "g" #'org-roam-show-graph
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

(global-set-key (kbd "<f5>") 'revert-buffer)
(setq frame-title-format "%b")
(global-prettify-symbols-mode t)
(setq truncate-lines t)
(setq auto-hscroll-mode 'current-line)

(add-to-list 'auto-mode-alist '("mutt" . mail-mode))

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
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(add-hook
     'after-save-hook
     'executable-make-buffer-file-executable-if-script-p)

;; highlight word
(use-package! idle-highlight-mode
  :config
  (progn  (add-hook 'prog-mode-hook (lambda () (idle-highlight-mode t)))
          (set-face-background 'idle-highlight "#252")
          (set-face-foreground 'idle-highlight "#fafafa")
          ))

(let ((langs '("american" "fr_FR" "pt_BR")))
      (setq lang-ring (make-ring (length langs)))
      (dolist (elem langs) (ring-insert lang-ring elem)))

  (defun cycle-ispell-languages ()
      (interactive)
      (let ((lang (ring-ref lang-ring -1)))
        (ring-insert lang-ring lang)
        (ispell-change-dictionary lang)))

(global-set-key [f6] 'cycle-ispell-languages)

(use-package! org
:config

(setq +pretty-code-symbols
  '(;; org
    :html  ""
    :author ""
    :title ""
    :mail ""
    :noweb ""
    :language ""
    :options ""
    :tex      ""
    :matlab ""
    :octave ""
    :python ""
    ;; :emacs ""
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
  ;; :emacs "emacs-lisp"
  )

)

(setq org-caldav-calendars
      (list
       (list :calendar-id "raccacio2@gmail.com"
             :url 'google
             :caldav-oauth2-client-id "998718790900-83pekdvg3h198chhn46n7dsdqdb44cgv.apps.googleusercontent.com"
             :caldav-oauth2-client-secret (substring (shell-command-to-string "pass show agenda/gmail") 0 -1)
             :inbox "~/org/fromGmail.org"
             )
       (list :calendar-id "raccacio@poli.ufrj.br"
             :url 'google
             :caldav-oauth2-client-id "998718790900-83pekdvg3h198chhn46n7dsdqdb44cgv.apps.googleusercontent.com"
             :caldav-oauth2-client-secret (substring (shell-command-to-string "pass show agenda/gmail") 0 -1)
             :inbox "~/org/fromPoli.org"
             )
       (list :calendar-id "nogueirar/Calendar/personal/"
             :url "https://sogo.supelec.fr/SOGo/dav/"
             :inbox "~/org/fromSupelec.org"
             )
       )
      )
