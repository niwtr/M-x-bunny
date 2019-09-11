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
    (slime-setup '(slime-fancy slime-company))))

(when use-sly
  (use-package sly
    :ensure t
    :defer t
    :commands (sly sly-connect lisp-mode-hook)
    :config
    (sly-setup '(sly-fancy))))
