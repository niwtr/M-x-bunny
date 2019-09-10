(defun os-path-join (a &rest ps)
  (let ((path a))
    (while ps
      (let ((p (pop ps)))
	(cond ((string-prefix-p "/" p)
	       (setq path (concat path (substring p 1))))
	       ;;;(setq path p))
	      ((or (not path) (string-suffix-p "/" p))
	       (setq path (concat path p)))
	      (t (setq path (concat path "/" p))))))
    path))

(setq root-remote-machine (concat ss-remote-machine-url ":/"))
(setq root-remote (concat "/ssh:" root-remote-machine))

(defun remote-mirrorred-path-p (dir)
  (not (null (cadr (split-string dir ss-local-path)))))

(defun bunny-mount-sshfs ()
  (interactive)
  (setq mount-point-remote (os-path-join root-remote-machine ss-remote-relative-path))
  (setq mount-point-local ss-local-path)
  (setq shell-cmd (concat "sshfs -o reconnect " mount-point-remote " " mount-point-local " && echo mount ok"))
  (message (shell-command-to-string shell-cmd)))

(defun bunny-umount-sshfs ()
  (interactive)
  (setq mount-point-local ss-local-path)
  (setq shell-cmd (concat "umount " mount-point-local " && echo umount ok"))
  (message (shell-command-to-string shell-cmd)))

(provide 'bunny-sshfs)
