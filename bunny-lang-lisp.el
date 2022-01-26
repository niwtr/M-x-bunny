(setq use-slime (eq ss-lisp-system 'slime))
(setq use-sly (eq ss-lisp-system 'sly))

(setq inferior-lisp-program ss-inferior-lisp-program)
(when use-slime
  (add-hook 'lisp-mode-hook (lambda ()
			      (company-mode -1)))
  (add-hook 'lisp-mode-hook (lambda ()
			      (auto-complete-mode +1)))
  (use-package slime
    :ensure t
    :config
    (setq browse-url-browser-function
	  '(("hyperspec" . eww-browse-url)
	    ("." . browse-url-default-browser)))
    (slime-setup '(slime-fancy slime-asdf slime-quicklisp
			       slime-indentation)))
  (use-package ac-slime
    :ensure t
    :config
    (add-hook 'slime-mode-hook 'set-up-slime-ac)
    (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
    (eval-after-load "auto-complete"
      '(add-to-list 'ac-modes 'slime-repl-mode))))

(when use-sly
  (use-package sly
    :ensure t
    :defer t
    :commands (sly sly-connect lisp-mode-hook)
    :config
    (sly-setup '(sly-fancy))))
