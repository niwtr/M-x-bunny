(defun bunny-run-as-time (fn)
  (shell-command (concat repo-directory "bunny-run-as-time/date_back.bat"))
  (unwind-protect 
      (funcall fn)
    (shell-command (concat repo-directory "bunny-run-as-time/date_front.bat"))))
(provide 'bunny-run-as-time)

