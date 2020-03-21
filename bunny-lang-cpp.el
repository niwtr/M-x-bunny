(setq use-lsp (eq ss-c++-system 'lsp))

(when use-lsp
  (use-package ccls :ensure t
    :config
    (add-hook 'c++-mode-hook 'lsp)
    (setq ccls-executable
	  (if (eq 'default ss-ccls-executable)
	      (locate-file "ccls" exec-path)
	    ss-ccls-executable))))

(defun bunny-compile-and-run-c++-file ()
  (interactive)
  (save-buffer)
  (compile
   (concat "g++ " (buffer-name) " --std=c++14 && ./a.out" )))


;;; bunny-lang-python.el ends here.
