
(setq use-lsp-ui nil)
(setq use-ob-ipython nil)

(setq use-anaconda (eq ss-python-system 'anaconda))
(setq use-jedi (eq ss-python-system 'jedi))
(setq use-company-jedi (eq ss-python-system 'company-jedi))
(setq use-elpy (eq ss-python-system 'elpy))
(setq use-eglot (eq ss-python-system 'eglot))
(setq use-lsp (eq ss-python-system 'lsp))
(setq use-ycmd (eq ss-python-system 'ycmd))
(setq use-microsoft-pyls use-lsp)
(setq use-yasnippet use-elpy)

;;; the very first python minor mode binding.
(require 'bunny-pyenv)
(if (eq ss-python-env 'default)
    (bunny-pyenv-default)
  (bunny-pyenv-set ss-python-env))

(define-minor-mode-leader-keymap 'python-mode :overwrite t
  ("d" . 'xref-find-definitions)
  ("o" . 'xref-find-definitions-other-window)
  ("r" . 'xref-find-references)
  ("e" . 'python-shell-run)
  ("c" . 'python-shell-send-buffer))

(use-package ob-ipython :ensure t
  :if use-ob-ipython
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ipython . t)
     ;; other languages..
     )))

(when use-elpy
  (use-package elpy
    :ensure t
    :init
    (custom-set-variables
     '(elpy-modules
       '(elpy-module-company elpy-module-eldoc elpy-module-sane-defaults)))
    (elpy-enable)))


(when use-anaconda
  (use-package anaconda-mode
    :ensure t
    :commands python-mode
    :config
    (setq python-shell-remote-exec-path `(,ss-python-remote-exec-path))
    (add-hook 'python-mode-hook 'anaconda-mode)
    (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
    (define-minor-mode-leader-keymap 'python-mode :overwrite t
      ("adc" . 'anaconda-mode-find-definitions)
      ("adw" . 'anaconda-mode-find-definitions-other-window)
      ("arc" . 'anaconda-mode-find-references)
      ("arw" . 'anaconda-mode-find-references-other-window)
      ("asc" . 'anaconda-mode-find-assignments)
      ("asw" . 'anaconda-mode-find-assignments-other-window)
      ("ao" . 'anaconda-mode-show-doc)))
  (use-package company-anaconda
    :ensure t
    :commands python-mode
    :config
    (add-to-list 'company-backends '(company-anaconda :with company-capf))))

(when use-ycmd
  (setq ss-ycmd-server-command '("/home/niutr/anaconda3/envs/python2/bin/python2"
				 "/home/niutr/.vim/bundle/YouCompleteMe/third_party/ycmd/ycmd/"))
  (setq ss-ycmd-global-config "/home/niutr/ycmd/.ycm_extra_conf.py")
  (use-package ycmd
    :ensure t
    :config
    (setq ycmd-force-semantic-completion nil)
    (setq company-ycmd-request-sync-timeout 0)
    (set-variable 'ycmd-server-command ss-ycmd-server-command)
    (set-variable 'ycmd-global-config ss-ycmd-global-config)
    (add-hook 'after-init-hook #'global-ycmd-mode)
    (add-hook 'python-mode-hook 'ycmd-mode)
    (defun ycmd-setup-completion-at-point-function ()
      "Setup `completion-at-point-functions' for `ycmd-mode'."
      (add-hook 'completion-at-point-functions
		#'ycmd-complete-at-point nil :local))
    (add-hook 'ycmd-mode-hook #'ycmd-setup-completion-at-point-function)))

(when use-lsp
  (use-package lsp-mode :ensure t
    :config
    (setq lsp-enable-snippet nil)
    (setq lsp-prefer-flymake t))
  (use-package company-lsp
    :ensure t
    :config
    ;; (setq company-lsp-enable-snippet nil
    ;; company-lsp-cache-candidates nil)
    (setq company-lsp-enable-snippet nil)
    (push 'company-lsp company-backends))

  (when use-microsoft-pyls
    (use-package lsp-python-ms :ensure t
      :after lsp-mode
      :config
      ;; for dev build of language server
      (add-hook 'python-mode-hook '(lambda () (flymake-mode -1)))
      (add-hook 'python-mode-hook 'lsp)
      (setq lsp-python-ms-dir
	    (expand-file-name ss-ms-pyls-directory))))

  (when use-lsp-ui
    (use-package lsp-ui :ensure t
      :after lsp-python-ms)))

(when use-company-jedi
  (use-package company-jedi :ensure t
    :config
    (define-minor-mode-leader-keymap 'python-mode :overwrite nil
      ("d" . 'jedi:goto-definition)
      ("b" . 'jedi:goto-definition-pop-marker)))
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
  (use-package jedi :ensure t
    :config
    (define-minor-mode-leader-keymap 'python-mode :overwrite nil
      ("sd" . 'jedi:show-doc)
      ("d" . 'jedi:goto-definition)
      ("b" . 'jedi:goto-definition-pop-marker)))
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook '(lambda () (interactive) (company-mode -1)))
       ;;; for the evil-mc. which does not work when dot is completed.
  (setq jedi:complete-on-dot nil))

(define-minor-mode-leader-keymap 'python-mode :overwrite nil
  ("C" . 'python-clear-shell))

(when use-eglot
  (use-package eglot :ensure t :config
    (add-hook 'python-mode-hook 'eglot-ensure)
    (defun bunny-filter-eglot-buffers (buffer-list)
      (delq nil (mapcar
		 (lambda (buffer)
		   (cond
		    ((string-match-p  "\*EGLOT*" buffer) nil)
		    (t buffer)))
		 buffer-list)))
    (advice-add 'helm-skip-boring-buffers
		:filter-return 'bunny-filter-eglot-buffers)))

(when use-yasnippet
  (use-package yasnippet
    :disabled
    :config
    (evil-leader/set-key
      "sy" 'yas-insert-snippet)
    (add-hook 'org-mode-hook 'yas-minor-mode)
    (setq yas-snippet-dirs `(,ss-snippets-dir))))

(use-package flymake-diagnostic-at-point
  :ensure t
  :after flymake
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode))
