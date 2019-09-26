;; (save-lisp-and-die)
(require 'web-server)

(defcustom bunny-kill-ring-webserver-port 9001
  "Port for bunny kill ring web server"
  :group 'bunny-krws)

(defcustom bunny-kill-ring-webserver-type 'plain
  "Type of displayed page. Displays html page with seperators when set to 'html
or display plain text when set to 'text."
  :options '(html plain)
  :group 'bunny-krws)

(defvar bunny--kill-ring-webserver-object nil
  "The actual webserver object.")


(defun ws-start (handlers port &optional log-buffer &rest network-args)
  "The original ws-start function is incompatible with Emacs 27.0.5. "
  (let ((server (make-instance 'ws-server :handlers handlers :port port))
        (log (when log-buffer (get-buffer-create log-buffer))))
    (setf (process server)
          (apply
           #'make-network-process
           :name "ws-server"
           :service (port server)
           :filter 'ws-filter
           :server t
           :nowait nil
           :family 'ipv4
           :coding 'no-conversion
           :plist (append (list :server server)
                          (when log (list :log-buffer log)))
           :log (when log
                  (lambda (proc request message)
                    (let ((c (process-contact request))
                          (buf (plist-get (process-plist proc) :log-buffer)))
		      (with-current-buffer buf
                        (goto-char (point-max))
                        (insert (format "%s\t%s\t%s\t%s"
                                        (format-time-string ws-log-time-format)
                                        (first c) (second c) message))))))
           network-args))
    (push server ws-servers)
    server))


(defun bunny--kill-ring-webserver-start (krws-port)
  (let ((local-vec (vector 0 0 0 0 krws-port)))
    (setq bunny--kill-ring-webserver-object 
	  (ws-start
	   (lambda (request)
	     (with-slots (process headers) request
	       (ws-response-header process 200
				   (list "Content-type"
					 (if (eq bunny-kill-ring-webserver-type 'html)
					     "text/html" "text/plain")))
	       (process-send-string process
				    (format
				     (if (eq bunny-kill-ring-webserver-type 'html)
					 "<html><head><title>Kill Ring</title></head><body>%s</body></html>" "%s")
				     (with-temp-buffer
				       (dolist (x kill-ring)
					 (if (eq bunny-kill-ring-webserver-type 'html)
					     (insert "<hr><xmp>" x "</xmp>")
					   (insert x "\n##\n")))
				       (buffer-string))))))
	   9090 nil :local local-vec))
    (message "Server started.")))

(defun bunny-kill-ring-webserver-start ()
  (interactive)
  (bunny-kill-ring-webserver-stop)
  (condition-case e
      (bunny--kill-ring-webserver-start bunny-kill-ring-webserver-port)
    (file-error
     ;; TODO ask the user to input another port number.
     (message "Sever port already used by other process. Please try another port."))))

(defun bunny-kill-ring-webserver-stop ()
  (interactive)
  (when bunny--kill-ring-webserver-object
    (ws-stop bunny--kill-ring-webserver-object)
    (setq bunny--kill-ring-webserver-object nil)
    (message "Shutdwon old kill-ring server.")))

(provide 'bunny-krws)
