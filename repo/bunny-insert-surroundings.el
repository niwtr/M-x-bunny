(require 'expand-region)

(defun bunny-insert-surroundings (&optional arg)
  (interactive)
  (let* ((paired-chars-hash
	  #s(hash-table data
			(?\( ?\) ?\" ?\" ?\' ?\' ?\[ ?\] ?\{ ?\}
			     ?\} ?\{ ?\) ?\( ?\] ?\[)))
	 (expected-char
	  (if (null arg) (read-char "?") arg)))
    (when (not (use-region-p))
      (er/mark-symbol))
    (insert-pair nil expected-char
		 (or 
		  (gethash expected-char paired-chars-hash)
		  expected-char))))

(defun bunny-insert-surroundings-biquote ()
  (interactive)
  (bunny-insert-surroundings ?\"))
(defun bunny-insert-surroundings-quote ()
  (interactive)
  (bunny-insert-surroundings ?\'))
(defun bunny-insert-surroundings-paren ()
  (interactive)
  (bunny-insert-surroundings ?\())
(defun bunny-insert-surroundings-bracket ()
  (interactive)
  (bunny-insert-surroundings ?\[))
(defun bunny-insert-surroundings-fancy-bracket ()
  (interactive)
  (bunny-insert-surroundings ?\{))
(provide 'bunny-insert-surroundings)
