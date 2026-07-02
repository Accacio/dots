;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(find-sibling-rules
   '(("/\\([^/]+\\)\\.h\\(h\\|pp\\)?\\'" "\\1.c\\(c\\|pp\\)?\\'")
     ("/\\([^/]+\\)\\.c\\(c\\|pp\\)?\\'" "\\1.h\\(h\\|pp\\)?\\'")))
 '(org-modern-todo-faces
   '(("QUESTIONS" :inverse-video t :inherit magit-signature-error)
     ("QUESTION" :inverse-video t :inherit magit-signature-error)
     ("PROJECT" :inverse-video t :inherit +org-todo-project)
     ("WAITING" :inverse-video t :inherit +org-todo-onhold)
     ("[?]" :inverse-video t :inherit +org-todo-onhold)
     ("STARTED" :inverse-video t :inherit +org-todo-active)
     ("STRT" :inverse-video t :inherit +org-todo-active)
     ("[-]" :inverse-video t :inherit +org-todo-active)
     ("IDEA" :inverse-video t :inherit org-date-selected)))
 '(org-todo-keyword-faces
   '(("[-]" . +org-todo-active) ("STRT" . +org-todo-active)
     ("STARTED" . +org-todo-active) ("[?]" . +org-todo-onhold)
     ("WAITING" . +org-todo-onhold) ("PROJECT" . +org-todo-project)
     ("QUESTION" . magit-signature-error) ("QUESTIONS" . magit-signature-error)
     ("IDEA" . org-date-selected)))
 '(org-todo-keywords
   '((sequence "TODO(t)" "NEXT(n)" "IDEA" "STARTED(s!)" "|" "DONE(d)" "Kill(k)")
     (type "PROJECT(p!)" "|" "DONE_PROJECT(D!)")
     (sequence "WAITING(w@!)" "SOMEDAY(S!)" "|" "CANCELLED(c@/!)")
     (type "QUESTIONS" "QUESTION(q)" "|" "ANSWERED(A)")))
 '(safe-local-variable-values
   '((ispell-dictionary . fr_FR)
     (pdf-annot-default-annotation-properties (t (label . "reviewer"))
      (text (icon . "Comment") (color . "#D08770"))
      (highlight (color . "#EBCB8B")) (squiggly (color . "#B48EAD"))
      (strike-out (color . "#BF616A")) (underline (color . "blue"))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
