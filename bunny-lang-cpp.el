(setq use-lsp (eq ss-c++-system 'lsp))
(setq use-ggtags (eq ss-c++-system 'ggtags))

(when use-lsp
  (use-package ccls :ensure t
    :config
    (setq lsp-file-watch-threshold 10000)
    (add-hook 'c++-mode-hook 'lsp)
    (setq ccls-executable
	  (if (eq 'default ss-ccls-executable)
	      (locate-file "ccls" exec-path)
	    ss-ccls-executable))))

(when use-ggtags
  (use-package ggtags :ensure t
    :config
    (add-hook 'c-mode-common-hook
              (lambda ()
		(when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
		  (ggtags-mode 1))))))

(defun bunny-compile-and-run-c++-file ()
  (interactive)
  (save-buffer)
  (compile
   (concat "g++ " (buffer-name) " --std=c++14 && ./a.out" )))


;;; bunny-lang-python.el ends here.
