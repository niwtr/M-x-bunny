;;; used for evil mode.
(require 'evil)
(require 'evil-leader)

(defun symbol-name-concat-postfix (symbol postfix)
  (intern (concat (symbol-name symbol) postfix)))

(cl-defmacro define-minor-mode-leader-keymap (mode &rest defs
						   &key (leader-key ",") (overwrite t)
						   &allow-other-keys)
  "definitions: list of a-list"
  (setq mode (cadr mode)) ;; get the actual mode.
  (setq mode-map-name (intern (concat (symbol-name mode) "-map"))) ;; all that way.
  (setq mode-hook-name (intern (concat (symbol-name mode) "-hook")))
  (setq minor-mode-map-name (intern (concat (symbol-name mode) "-minor-map")))
  (let (key rest) ;; parse keys
    (dolist (elt defs)
      (cond ((eql elt :leader-key) (setq key elt))
	    ((eql elt :overwrite) (setq key elt))
	    (key
	     (progn
	       (set (intern-soft
		     (string-remove-prefix ":" (symbol-name key)))
		    elt)
	       (setq key nil)))
	    (t (push elt rest))))
    (setq definitions (nreverse rest)))
  (setq definition-lists
	(mapcar (lambda (bind)
		  (setq k (car bind))
		  (setq v (cdr bind))
		  `(define-key ,minor-mode-map-name (kbd ,k)
		     ,v))
		definitions))
  `(progn
     (when ,overwrite
       (define-prefix-command (quote ,minor-mode-map-name))
       (evil-define-key 'normal ,mode-map-name (kbd ,leader-key)
	 (quote ,minor-mode-map-name)))
     ,@definition-lists))

(cl-defmacro use-minor-mode-leader-keymap (mode-new mode-old
						    &key (leader-key ","))
  (setq major-mode-map-new (symbol-name-concat-postfix (cadr mode-new) "-map"))
  (setq mode-map-new (symbol-name-concat-postfix (cadr mode-new) "-minor-map"))
  (setq mode-map-old (symbol-name-concat-postfix (cadr mode-old) "-minor-map"))
  `(progn
     (define-prefix-command (quote ,mode-map-new))
     (set-keymap-parent ,mode-map-new ,mode-map-old)
     (evil-define-key 'normal ,major-mode-map-new (kbd ,leader-key)
       (quote ,mode-map-new))))

(provide 'bunny-minor-mode-leader-keymap)
