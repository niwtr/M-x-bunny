(defun prettify-json-file (old-fn &rest arg)
  (let ((fname (car arg)))
    (if (and (string-match-p ".*\\.json$" fname)
	     (y-or-n-p "Format this json file? "))
	(let ((new-buffer (get-buffer-create (concat "prettyfied-" fname)))
	      (prettified (shell-command-to-string (concat "python -m json.tool " fname))))
	  (with-current-buffer new-buffer 
	    (insert prettified)
	    (switch-to-buffer (buffer-name new-buffer) t t)))
      (apply old-fn (list fname)))))
(provide 'bunny-prettify-json-file)
