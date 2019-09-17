;; (save-lisp-and-die)
(require 'web-server)

(defcustom bunny-kill-ring-webserver-port 9000
  "Port for bunny kill ring web server")
(defun bunny--kill-ring-webserver-start (krws-port)
  (let ((local-vec (vector 0 0 0 0 krws-port)))
    (ws-start
     (lambda (request)
       (with-slots (process headers) request
	 (ws-response-header process 200 '("Content-type" . "text/html"))
	 (process-send-string process
			      (format
			       "<html><head><title>Kill Ring</title></head><body>%s</body></html>"
			       (with-temp-buffer
				 (dolist (x kill-ring)
				   (insert "<hr><xmp>" x "</xmp>"))
				 (buffer-string))))))
     9090 nil :local local-vec)))

(defun bunny-kill-ring-webserver-start ()
  (interactive)
  (condition-case e
      (bunny--kill-ring-webserver-start bunny-kill-ring-webserver-port) 
    (file-error
     (progn
       (message "Server port already used. Trying server shutdwon.")
       (ws-stop-all)
       (condition-case e
	   (progn
	     (bunny--kill-ring-webserver-start bunny-kill-ring-webserver-port)
	     (message "Server started."))
	 (file-error
	  (message "The port does not belong to us, failing.")
	  e))))))

(provide 'bunny-krws)

