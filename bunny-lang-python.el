;; (setq use-lsp-ui nil)
(setq use-ob-ipython nil)
(setq use-anaconda (eq ss-python-system 'anaconda))
(setq use-jedi (eq ss-python-system 'jedi))
(setq use-company-jedi (eq ss-python-system 'company-jedi))
(setq use-lsp (or (eq ss-python-system 'lsp-ms-pyls) (eq ss-python-system 'lsp-pyright)))
(setq use-microsoft-pyls (eq ss-python-system 'lsp-ms-pyls))
(setq use-lsp-pyright (eq ss-python-system 'lsp-pyright))

;;; the very first python minor mode binding.
(require 'bunny-pyenv)
(cond ((eq ss-python-env 'default) (bunny-pyenv-default))
      ((symbolp ss-python-env)
       (bunny-pyenv-set
	(f-join
	 (f-parent bunny-pyenv--default-pyenv)
	 (symbol-name ss-python-env))))
      (t
       (bunny-pyenv-set ss-python-env)))


(use-package ob-ipython :ensure t
  :if use-ob-ipython
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ipython . t)
     ;; other languages..
     )))

(when use-anaconda
  (use-package anaconda-mode
    :ensure t
    :commands python-mode
    :config
    (setq python-shell-remote-exec-path `(,ss-python-remote-exec-path))
    (add-hook 'python-mode-hook 'anaconda-mode)
    (add-hook 'python-mode-hook 'anaconda-eldoc-mode))
  (use-package company-anaconda
    :ensure t
    :commands python-mode
    :config
    (add-to-list 'company-backends '(company-anaconda :with company-capf))))

(when use-lsp
  (use-package lsp-mode :ensure t
    :config
    (setq lsp-enable-snippet nil)
    ;; when you type a semicolon, this will trigger
    ;; the on-type-formatting, which is annoying.
    (setq lsp-enable-on-type-formatting nil)
    (setq lsp-diagnostic-package :flycheck))
  (use-package flycheck :ensure t)
  (when use-lsp-pyright
    (use-package lsp-pyright
      :ensure t
      :hook (python-mode . (lambda ()
			                       (require 'lsp-pyright)
			                       (lsp)))))
  (when use-microsoft-pyls
    (use-package lsp-python-ms :ensure t
      :after lsp-mode
      :config
      ;; for dev build of language server
      (add-hook 'python-mode-hook '(lambda () (flymake-mode -1)))
      (add-hook 'python-mode-hook 'lsp)
      (setq lsp-python-ms-executable 
	          (if (eq ss-ms-pyls-executable 'default)
		            (locate-file "Microsoft.Python.LanguageServer" exec-path)
	            ss-ms-pyls-executable))))
  (use-package lsp-ui :ensure t
    :after lsp-mode))

(when use-company-jedi
  (use-package company-jedi :ensure t)
  (defun my/python-mode-hook ()
    (add-to-list 'company-backends 'company-jedi))
  (add-hook 'python-mode-hook 'my/python-mode-hook))

(defun python-clear-shell()
  (interactive)
  (setq buffer (get-buffer "*Python*"))
  (with-current-buffer buffer
    (set-buffer-writeable) 
    (setf (buffer-string) "")))

(setq python-shell-completion-native-disabled-interpreters '("python"))

(defun python-shell-run()
  (interactive)
  (setq fresh-run t)
  (when (get-buffer "*Python*")
    (setq fresh-run nil)
    (window-configuration-to-register ?\w))
  (when (get-buffer-process "*Python*")
    (set-process-query-on-exit-flag (get-buffer-process "*Python*") nil)
    (kill-process (get-buffer-process "*Python*"))
    (sleep-for 0.5))
  (run-python (python-shell-parse-command) nil nil)
  (when (not fresh-run)
    (jump-to-register ?\w))
  (unless (get-buffer-window "*Python*" t)
    (python-shell-switch-to-shell))
  (python-clear-shell)
  (python-shell-send-buffer nil nil))


(defun set-buffer-writeable ()
  (setq begin (point-min)
	end (point-max))
  (let ((modified (buffer-modified-p))
	(inhibit-read-only t))
    (remove-text-properties begin end '(read-only t))
    (set-buffer-modified-p modified)))

(when use-jedi
  (use-package jedi :ensure t)
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook '(lambda () (interactive) (company-mode -1)))
       ;;; for the evil-mc. which does not work when dot is completed.
  (setq jedi:complete-on-dot nil))

(use-package flymake-diagnostic-at-point
  :ensure t
  :after flymake
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode))
