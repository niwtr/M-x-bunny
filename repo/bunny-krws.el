;;; -*- lexical-binding: t; -*-

(require 'web-server)
(require 'cl)

(defcustom bunny-kill-ring-webserver-port 9001
  "Port for bunny kill ring web server"
  :group 'bunny-krws)

(defcustom bunny-kill-ring-webserver-type 'GET
  "Type of displayed page. Displays html page with seperators when set to 'html
or display plain text when set to 'text."
  :options '(html plain GET)
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

(defvar bunny--kill-ring-webserver-html-header-template
  "<html><head><title>Kill Ring</title></head><body>%s</body></html>"
  "Format string of HTML header template.")

(defvar bunny--kill-ring-webserver-plain-header-template
  "%s"
  "Format string of plain header template.")

(defvar bunny--kill-ring-webserver-html-template
  (cons "<hr><xmp>" "</xmp>")
  "HTML template string.")

(defvar bunny--kill-ring-webserver-plain-template
  (cons "" "\n##\n")
  "Plain template string.")

(defun bunny--kill-ring-webserver-start (krws-port)
  (let ((local-vec (vector 0 0 0 0 krws-port)))
    (setq bunny--kill-ring-webserver-object
	  (if (eq bunny-kill-ring-webserver-type 'GET)
	      (ws-start
	       '(((:GET . ".*") .
		  (lambda (request)
		    (with-slots (process) request
		      (ws-response-header process 200 '("Content-type" . "text/plain"))
		      (process-send-string process
					   (car kill-ring))))))
	       9090 nil :local local-vec)
	    (ws-start
	     (lambda (request)
	       (with-slots (process headers) request
		 (ws-response-header process 200
				     (cons "Content-type"
					   (if (eq bunny-kill-ring-webserver-type 'html)
					       "text/html" "text/plain")))
		 (process-send-string
		  process
		  (format
		   (if (eq bunny-kill-ring-webserver-type 'html)
		       bunny--kill-ring-webserver-html-header-template
		     bunny--kill-ring-webserver-plain-header-template)
		   (with-temp-buffer
		     (dolist (x kill-ring)
		       (if (eq bunny-kill-ring-webserver-type 'html)
			   (insert
			    (car bunny--kill-ring-webserver-plain-template)
			    x
			    (cdr bunny--kill-ring-webserver-plain-template))))
		     (buffer-string))))))
	     9090 nil :local local-vec)))
    (message (format "Server started, port %d, type %s."
		     krws-port
		     bunny-kill-ring-webserver-type))))

(defun bunny-kill-ring-webserver-start ()
  (interactive)
  (bunny-kill-ring-webserver-stop)
  (condition-case e
      (bunny--kill-ring-webserver-start bunny-kill-ring-webserver-port)
    (file-error
     (let ((the-port bunny-kill-ring-webserver-port))
       (cl-tagbody
	prompt
	(let ((new-port
	       (string-to-number
		(read-string
		 (format "Sever port %d already used by other process. Please try another port => "
			 the-port)))))
	  (if (< new-port 22)
	      (progn
		(message "Illegal port.")
		(sleep-for 1)
		(go prompt))
	    (progn
	      (condition-case e
		  (bunny--kill-ring-webserver-start new-port)
		(file-error
		 (setf the-port new-port)
		 (go prompt))
		(error e))
	      (let ((confirm-save
		     (y-or-n-p
		      (format 
		       "Server started successfully at port %d. Do would you like to save it as default? =>" new-port))))
		(when confirm-save
		  (custom-set-variables
		   (list 'bunny-kill-ring-webserver-port new-port))
		  (custom-save-all)))))))))
    (error e)))

(defun bunny-kill-ring-webserver-stop ()
  (interactive)
  (when bunny--kill-ring-webserver-object
    (ws-stop bunny--kill-ring-webserver-object)
    (setq bunny--kill-ring-webserver-object nil)
    (message "Shutdwon old kill-ring server.")))

(defun bunny-krws ()
  (interactive)
  (bunny-kill-ring-webserver-start))

(provide 'bunny-krws)
