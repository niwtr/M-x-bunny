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

(setq require-final-newline t)
(setq backup-directory-alist `(("." . ,ss-emacs-save-path)))
(setq auto-save-file-name-transforms `((".*" ,ss-emacs-save-path t)))
(setq undo-tree-history-directory-alist `((".*" . ,ss-emacs-save-path)))
(setq undo-tree-auto-save-history t)

(delete-selection-mode t)
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


;; prevent emacs from freezing when displaying hanzi and emoji.
(when (string-equal system-type "darwin")
  (when (fboundp 'set-fontset-font)
    (set-fontset-font t 'unicode "PingFang SC" nil 'prepend)
    (set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)))

;; ediff - don't start another frame
(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; abbrev config
(add-hook 'text-mode-hook 'abbrev-mode)


;; bookmarks
(require 'bookmark)
(setq bookmark-default-file
      (expand-file-name "bookmarks" ss-emacs-save-path)
      bookmark-save-flag 1)

;; projectile is a project management mode
(require 'projectile)
(setq projectile-cache-file
      (expand-file-name  "projectile.cache" ss-emacs-save-path))

(require 'recentf)
(setq recentf-save-file (expand-file-name "recentf" ss-emacs-save-path)
      recentf-max-saved-items 500
      recentf-max-menu-items 30
      ;; disable recentf-cleanup on Emacs start, because it can cause
      ;; problems with remote files
      recentf-auto-cleanup 'never)


(with-current-buffer (get-buffer-create "*Messages*")
  (emacs-lisp-mode))
(unless (boundp 'auto-revert-buffers-counter)
  (setq auto-revert-buffers-counter 0))
