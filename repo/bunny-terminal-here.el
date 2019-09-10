(require 'multi-term)
(require 'shell-pop)
	 
(defconst repo-directory ss-repo-directory)
(defvar bunny--iterm2-script-path (concat repo-directory "bunny-iterm2-here/bunny-iterm2-helper.py"))
(defvar bunny--iterm2-shell-script-path (concat repo-directory "bunny-iterm2-here/bunny-iterm2-helper.sh"))

(defun flatten (list) (mapcan (lambda (x) (if (listp x) x nil)) list))
(defun bunny-multi-term-here ()
  (interactive)
  (setq path default-directory)
  (if (tramp-tramp-file-p path)
      (let* ((cmdlist
	      (remove "" (split-string path "/")))
	     (ssh (substring (car cmdlist) 4 -1))
	     (dir (apply 'concat (flatten (mapcar (lambda (x) (list "/" x)) (cdr cmdlist))))))
	(shell-pop 1)
	(setq qcmd (concat "ssh -t " ssh  " \"cd '" dir "' && exec zsh -l\"\n"))
	(message qcmd)
	(comint-send-string
	 "*multi-term-1*" qcmd))
    (progn
      (shell-pop 1)
      (comint-send-string
       "*multi-term-1*" (concat "cd " path "\n")))))

(defun get-mirrorred-path (mirror-dir)
  (setq this-relative-path (cadr (split-string mirror-dir ss-local-path))) 
  (setq remote-path (os-path-join root-remote ss-remote-relative-path this-relative-path)))
(defun bunny-iterm2-here ()
  (interactive)
  (setq path default-directory)
  (setq python "python")
  (setq script bunny--iterm2-script-path)
  (setq shell-script bunny--iterm2-shell-script-path)
  (when (remote-mirrorred-path-p path) ;; mirror the relative path to remote.
    (setq path (get-mirrorred-path path)))
  (if (tramp-tramp-file-p path)
      (let* ((cmdlist
	      (remove "" (split-string path "/")))
	     (ssh (substring (car cmdlist) 4 -1))
	     (dir (apply 'concat (flatten (mapcar (lambda (x) (list "/" x)) (cdr cmdlist)))))
	     (z-cmd (concat python " " script " " shell-script " " ssh " " dir)))
	(message z-cmd)
	(start-process "iterm"  "*Messages*" "python" script shell-script ssh dir))
    (let ((z-cmd (concat python " " script " " shell-script " " path)))
      (message z-cmd)
      (start-process "iterm" "*Messages*" "python" script shell-script path))))
(provide 'bunny-terminal-here)
