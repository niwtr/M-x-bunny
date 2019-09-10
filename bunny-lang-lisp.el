(setq use-slime (eq ss-lisp-system 'slime))
(setq use-sly (eq ss-lisp-system 'sly))

(setq inferior-lisp-program ss-inferior-lisp-program)
(when use-slime
  (use-package slime
    :ensure t
    :commands (slime slime-connect lisp-mode-hook)
    :init
    :config
    (use-package slime-company :ensure t)
    ;;(add-hook 'lisp-mode (lambda () (company-mode 1))))
    ;; (add-hook 'slime-repl-mode-hook (lambda() (company-mode 0)))
    (slime-setup '(slime-fancy slime-company)))
  (define-minor-mode-leader-keymap 'lisp-mode
    ("C" . 'slime-connect)
    (","  . 'slime-compile-defun)
    ("ee" . 'slime-eval-defun)
    ("mo" . 'slime-macroexpand-1)
    ("mm" . 'slime-macroexpand-all)
    ("eb" . 'slime-eval-buffer)))

(when use-sly
  (use-package sly
    :ensure t
    :defer t
    :commands (sly sly-connect lisp-mode-hook)
    :config
    (sly-setup '(sly-fancy)))
  (evil-define-key 'normal 'sly-mrepl-mode-map (kbd "0") 'sly-db-invoke-restart-0)
  (evil-define-key 'normal 'sly-mrepl-mode-map (kbd "1") 'sly-db-invoke-restart-1)
  (evil-define-key 'normal 'sly-mrepl-mode-map (kbd "2") 'sly-db-invoke-restart-2)
  (evil-define-key 'normal 'sly-mrepl-mode-map (kbd "3") 'sly-db-invoke-restart-3)
  (evil-define-key 'normal 'sly-mrepl-mode-map (kbd "4") 'sly-db-invoke-restart-4)
  (evil-define-key 'normal 'sly-mrepl-mode-map (kbd "5") 'sly-db-invoke-restart-5)
  (evil-define-key 'normal 'sly-mrepl-mode-map (kbd "6") 'sly-db-invoke-restart-6)
  (evil-define-key 'normal 'sly-mrepl-mode-map (kbd "7") 'sly-db-invoke-restart-7)
  (evil-define-key 'normal 'sly-mrepl-mode-map (kbd "8") 'sly-db-invoke-restart-8)
  (define-minor-mode-leader-keymap 'lisp-mode
    ("1" . 'sly-db-invoke-restart)
    ("C" . 'sly-connect)
    (","  . 'sly-compile-defun)
    ("mo" . 'sly-macroexpand-1)
    ("mm" . 'sly-macroexpand-all)
    ("ee" . 'sly-eval-defun)
    ("eb" . 'sly-eval-buffer)))
