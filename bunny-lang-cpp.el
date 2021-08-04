(setq use-lsp (eq ss-c++-system 'lsp))
(setq use-lsp-clangd (eq ss-c++-system 'lsp-clangd))
(setq use-dumb-jump (eq ss-c++-system 'dumb-jump))

(when use-lsp
  (use-package ccls :ensure t
    :config
    (setq lsp-file-watch-threshold 10000)
    (add-hook 'c++-mode-hook 'lsp)
    (setq ccls-executable
	        (if (eq 'default ss-ccls-executable)
	            (locate-file "ccls" exec-path)
	          ss-ccls-executable))))

(when use-lsp-clangd
  (use-package lsp-mode :ensure t
    :config
    (add-hook 'c++-mode-hook 'lsp)
    (setq lsp-clangd-binary-path (locate-file "clangd" exec-path))))

(when use-dumb-jump
  (use-package dumb-jump :ensure t
    :init
    (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)))

(defun bunny-compile-and-run-c++-file ()
  (interactive)
  (save-buffer)
  (compile
   (concat "g++ " (buffer-name) " --std=c++14 && ./a.out" )))

;; fix tab spaces to 2 in cpp files.
(add-hook 'c++-mode-hook
	        (lambda ()
            (setq-default indent-tabs-mode nil)
            (setq-default c-default-style "linux")
            (setq-default tab-width 2)
            (setq c-basic-offset 2)))

;;; bunny-lang-python.el ends here.
