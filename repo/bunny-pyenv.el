(defun bunny-pyenv--locate-default-python-env ()
  (concat
   (f-parent
    (f-parent
     (locate-file "python" exec-path)))
   "/"))

(defvar bunny-pyenv--default-pyenv
  (bunny-pyenv--locate-default-python-env)
  "Default python environment for bunny-pyenv. 
   This value is set when this package is loaded.")

(defvar bunny-pyenv--current-pyenv nil
  "Current python environment.")

(defcustom bunny-pyenv--use-python-env-in-eshell t
  "Whether to use bunny-pyenv in eshell. 
   If set t, bunny-pyenv will overwrite your exec-path
   so that you can use your new python env in eshell.")

(defcustom bunny-pyenv--default-search-path nil
  "When nil, bunny-pyenv searches from your default-directory.
   When non-nil, bunny-pyenv search from your values set.")

(defun bunny-pyenv--set-pyenv (env)
  (when bunny-pyenv--use-python-env-in-eshell
    (push (concat (if (s-suffix-p "/" env)
		      (substring env 0 -1)
		    env)
		  "/bin/") 
	  exec-path))
  (setq python-shell-interpreter (concat env "/bin/python"))
  (setq python-shell-virtualenv-root env)
  (setq python-environment-directory (concat env "/bin"))
  (setq bunny-pyenv--current-pyenv env))

(defun bunny-pyenv-set (env)
  (interactive
   (list (read-file-name
	  "Python Env: "
	  (cond ((stringp bunny-pyenv--default-search-path)
		 bunny-env--default-search-path)
		((stringp bunny-pyenv--current-pyenv)
		 (f-parent bunny-pyenv--current-pyenv))
		(t
		 default-directory)))))
  (if (or
       (file-exists-p (concat env "/bin/python"))
       (file-exists-p (concat env "/bin/python3")))
      (progn
	(bunny-pyenv--set-pyenv env)
	(message "Set PyEnv to: %s" env))
    (message "Illegal Python Env: %s" env)))

(defun bunny-pyenv-default ()
  (interactive)
  (bunny-pyenv-set bunny-pyenv--default-pyenv))

(provide 'bunny-pyenv)

