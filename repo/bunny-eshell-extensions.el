(setf bunny-eshell-manager-current 0)

(setq eshell-up-num 0)
(defun bunny-neo-eshell () 
  (interactive)
  (incf eshell-up-num)
  (eshell eshell-up-num))

(defun bunny--fuzzy-stoi (string)
  (if (string-match "[0-9][0-9]*" string)
      (cl-destructuring-bind (st ed) (match-data)
	(string-to-number (substring string st ed)))
    0))

(defun bunny--list-eshells (&optional aux-preds)
  (cond ((null aux-preds) (setq aux-preds (list #'identity)))
	((eq (car aux-preds) 'lambda) (setq aux-preds (list aux-preds)))
	(t
	 (setq aux-preds (list aux-preds))))
  (sort
   (let ((filtered (remove-if-not (lambda (buf) (eq 'eshell-mode (with-current-buffer buf major-mode))) (buffer-list))))
     (dolist (pred aux-preds filtered)
       (setq filtered (remove-if-not pred filtered))))
   (lambda (b1 b2)
     (< (bunny--fuzzy-stoi (buffer-name b1))
	(bunny--fuzzy-stoi (buffer-name b2))))))

(defun make-eshell-buffer-switcher (nth eshell-list)
  (lexical-let ((n nth) (eshell-list eshell-list))
    (lambda nil
      (interactive)
      (setq buffer-to (nth n eshell-list))
      (if (null buffer-to)
	  (message "No such eshell buffer.")
	(switch-to-buffer buffer-to)))))

(defun bunny-eshell-manager-clear-current nil
  (setf bunny-eshell-manager-current 0))

(defun bunny--eshell-manager-current-funcall (fn eshell-list)
  (setf bunny-eshell-manager-current (funcall fn bunny-eshell-manager-current))
  ;; (message "funcall, current %d" bunny-eshell-manager-current)
  (let ((neshells (length eshell-list)))
    (cond ((>= bunny-eshell-manager-current neshells)
	   (bunny-eshell-manager-clear-current))
	  ;; (message "cleared, current %d" bunny-eshell-manager-current))
	  ((< bunny-eshell-manager-current 0)
	   (setf bunny-eshell-manager-current (1- neshells)))
	  ;; (message "set. current %d" bunny-eshell-manager-current))
	  (t nil))))
;; (message "nothing to done. current %d" bunny-eshell-manager-current)))))

(defun bunny--eshell-manager-eshell-forward nil
  (bunny--eshell-manager-current-funcall #'1+)
  (funcall (make-eshell-buffer-switcher bunny-eshell-manager-current)))

(defun bunny--eshell-manager-eshell-previous nil
  (bunny--eshell-manager-current-funcall #'1-)
  (funcall (make-eshell-buffer-switcher bunny-eshell-manager-current)))

(defun bunny-eshell-do (fn &optional aux-preds)
  (let* ((sname (buffer-name (current-buffer)))
	 (sbuffers (bunny--list-eshells aux-preds))
	 (sbuffer-names (mapcar (lambda (x) (buffer-name x)) sbuffers))
	 (aim-pos (position sname sbuffer-names :test #'equal)))
    (if (null aim-pos)
	(if (null sbuffers)
	    (message "You don't have ANY eshell buffer.")
	  (message "You are not in a eshell buffer. Switching to the first one.")
	  (funcall (make-eshell-buffer-switcher 0)))
      (setf bunny-eshell-manager-current aim-pos)
      (bunny--eshell-manager-current-funcall fn sbuffers)
      (funcall (make-eshell-buffer-switcher bunny-eshell-manager-current sbuffers)))))

(defcustom bunny-eshell-prevnext-within-project t
  "When set to t, only switch to eshells within the same project of current eshell.")

(defun bunny-eshell-next nil
  (interactive)
  (bunny-eshell-do #'1+))

(defun bunny-eshell-next-within-project nil
  (interactive)
  (bunny-eshell-do
   #'1+
   (when bunny-eshell-prevnext-within-project
     (lambda (buf)
       (string-equal (projectile-project-root)
		     (with-current-buffer buf (projectile-project-root)))))))

(defun bunny-eshell-prev nil
  (interactive)
  (bunny-eshell-do #'1-))

(defun bunny-eshell-prev-within-project nil
  (interactive)
  (bunny-eshell-do
   #'1-
   (when bunny-eshell-prevnext-within-project
     (lambda (buf)
       (string-equal (projectile-project-root)
		     (with-current-buffer buf (projectile-project-root)))))))


;; (defun bunny-eshell-pre-nil
;;     (interactive)
;;   (bunny-eshell-do #'1-))


;; (defun eshell-manager-switch-to-1st-eshell nil
;;   (funcall (make-eshell-buffer-switcher 0)))
;; (with-eval-after-load 'evil-maps
;; (defvar eshell-manager-mode-keymap
;;   (let ((map (make-sparse-keymap)))
;;     (evil-define-key 'normal map (kbd "n") 'eshell-manager-eshell-forward)
;;     (evil-define-key 'normal map (kbd "p") 'eshell-manager-eshell-previous)
;;     (evil-define-key 'normal map (kbd "k") 'kill-this-buffer)
;;     (evil-define-key 'insert map (kbd "n") 'eshell-manager-eshell-forward)
;;     (evil-define-key 'insert map (kbd "p") 'eshell-manager-eshell-previous)
;;     (evil-define-key 'insert map (kbd "k") 'kill-this-buffer)
;;     (evil-define-key 'visual map (kbd "n") 'eshell-manager-eshell-forward)
;;     (evil-define-key 'visual map (kbd "p") 'eshell-manager-eshell-previous)
;;     (evil-define-key 'visual map (kbd "k") 'kill-this-buffer)
;;     (evil-define-key 'normal map (kbd "q") 'eshell-manager-quit)
;;     (evil-define-key 'insert map (kbd "q") 'eshell-manager-quit)
;;     (evil-define-key 'visual map (kbd "q") 'eshell-manager-quit)
;;     map)
;;   "map for eshell manager"))

;; (evil-make-intercept-map eshell-manager-mode-keymap 'normal)

;; (define-minor-mode eshell-manager-mode
;;   "A minor mode that masters your eshells."
;;   :global t
;;   :keymap eshell-manager-mode-keymap)


;; (add-hook 'eshell-manager-mode-hook 'bunny-eshell-manager-clear-current)
;; (add-hook 'eshell-manager-mode-hook 'eshell-manager-switch-to-1st-eshell)

;; (defun eshell-manager-quit nil
;;   (interactive)
;;   (message "quit eshell-manager.")
;;   (eshell-manager-mode -1))

;; (evil-leader/set-key "em" 'eshell-manager-mode)

;; (message "ok!")
(defvar bunny-ivy-eshell-finder-show-directory t)
(defvar bunny-ivy-eshell-finder-show-eshell-status t)
(defun bunny-ivy-eshell-finder-directory (eshell-buffer-name)
  (concat 
   (propertize 
    (with-current-buffer (car c) default-directory)
    'font-lock-face '(:foreground "yellow"))
   " "))
(defun bunny-ivy-eshell-finder-eshell-status (eshell-buffer-name)
  (concat 
   (if (get-buffer-process (car c))
       (propertize "[RUNNING]" 'font-lock-face '(:foreground "red"))
     (propertize "[IDLE]" 'font-lock-face '(:foreground "green")))
   " "))


(defun bunny-ivy-eshell-finder ()
  "find eshell by their running, or previous rinning command."
  (interactive)
  (let ((eshells (bunny--list-eshells))
	(callbacks))
    (dolist (eshell eshells callbacks)
      (with-current-buffer eshell
	(push `(,(buffer-name eshell) ,(eshell-get-history 0)) callbacks)))
    (setq callbacks (nreverse callbacks))
    (setq display-fn 
	  (mapcar (lambda (c)
		    (concat
		     (propertize (car c) 'font-lock-face '(:foreground "blue")) " "
		     (if bunny-ivy-eshell-finder-show-eshell-status
			 (bunny-ivy-eshell-finder-eshell-status (car c))
		       "")
		     (if bunny-ivy-eshell-finder-show-directory
			 (bunny-ivy-eshell-finder-directory (car c))
		       "")
		     (cadr c)))
		  callbacks))
    (ivy-read "Eshells:" display-fn
	      :action (lambda (cand)
			(switch-to-buffer
			 (substring cand 0 (position ?\  cand)))))))

(defun bunny-eshell-kill-all-idle-eshell ()
  (interactive)
  (let ((eshells (bunny--list-eshells)))
    (dolist (eshell eshells)
      (unless (get-buffer-process eshell)
	(kill-buffer eshell)))))

(defun bunny-eshell-kill-all-running-eshell ()
  (interactive)
  (when (y-or-n-p "KILL ALL RUNNING ESHELLS?")
    (let ((eshells (bunny--list-eshells)))
      (dolist (eshell eshells)
	(when (get-buffer-process eshell)
	  (kill-buffer eshell))))))

(defun bunny-eshell-commit-last-command ()
  (interactive)
  (let ((hlist (eshell-get-history 0)))
    (goto-char eshell-last-output-end)
    (insert hlist)
    (eshell-send-input)))

(defun bunny-eshell-maybe-commit-last ()
  (interactive)
  (save-excursion 
    (goto-char eshell-last-output-end)
    (if (string-empty-p (buffer-substring (point) (line-end-position)))
	(bunny-eshell-commit-last-command)
      (eshell-send-input))))

(defun bunny-eshell-goto-input-line-and-insert ()
  (interactive)
  (goto-char eshell-last-output-end)
  (evil-insert-state))

(defun eshell/clear ()
  "Function to clear eshell buffer."
  (let ((eshell-buffer-maximum-lines 0))
    (eshell-truncate-buffer)))

(defun eshell-clear ()
  "Clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))
(defun bunny-eshell-clear ()
  "Clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))

(defun bunny-eshell-command (cmd &optional kill-buffer)
  "Run specific command inside a new eshell."
  (interactive
   (list (read-string (format "[%s]$ " default-directory))))
  (with-current-buffer (bunny-neo-eshell)
    (goto-char eshell-last-output-end)
    (insert cmd)
    (eshell-send-input)
    (when kill-buffer (kill-this-buffer))))

(defun bunny-gpu nil (interactive) (bunny-eshell-command "gpustat -i" t))
(defun bunny-htop nil (interactive) (bunny-eshell-command "htop" t))

(provide 'bunny-eshell-extensions)

;; bunny-eshell-extensions.el ends here.
