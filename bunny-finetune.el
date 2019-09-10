(setq initial-scratch-message ";; (save-lisp-and-die)\n")
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq tramp-verbose 1)
(setq redisplay-dont-pause t)
  ;;; never kill the scratch buffer.
(defadvice kill-buffer (around kill-buffer-around-advice activate)
  (let ((buffer-to-kill (ad-get-arg 0)))
    (if (equal buffer-to-kill "*scratch*")
	(bury-buffer)
      ad-do-it)))
(setq backup-directory-alist `(("." . ,ss-emacs-save-path)))
(setq custom-file ss-custom-file)

(when window-system
  (setq mouse-wheel-scroll-amount '(0.01))
  (setq mouse-wheel-progressive-speed nil)
  (setq ring-bell-function 'ignore))

(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda () (interactive) (scroll-down 1)))
  (global-set-key [mouse-5] (lambda () (interactive) (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t))
