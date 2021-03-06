(defun bunny-h5ls-h5file (old-fn &rest arg)
  (let ((fname (car arg)))
    (if (and (string-match-p ".*\\.h5$" fname)
	     (y-or-n-p "List this h5 file? "))
	(let ((new-buffer (get-buffer-create (concat "h5ls-" fname)))
	      (lsd (shell-command-to-string (concat "h5ls -v " fname))))
	  (with-current-buffer new-buffer
	    (setq default-directory (concat (f-parent fname) "/"))
	    (insert lsd)
	    (switch-to-buffer (buffer-name new-buffer) t t)))
      (apply old-fn (list fname)))))
(provide 'bunny-h5ls)
