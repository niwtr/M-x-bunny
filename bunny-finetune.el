(setq initial-scratch-message ";; (save-lisp-and-die)\n")
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq tramp-verbose 1)
;; (setq tramp-verbose 6)
(setq tramp-inline-compress-start-size 10000000)

(setq redisplay-dont-pause t)
  ;;; never kill the scratch buffer.
(defadvice kill-buffer (around kill-buffer-around-advice activate)
  (let ((buffer-to-kill (ad-get-arg 0)))
    (if (equal buffer-to-kill "*scratch*")
	(bury-buffer)
      ad-do-it)))

(defun kill-this-buffer ()	; not for the menu bar.
  "Simply kill this buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(setq require-final-newline t)
(setq backup-directory-alist `(("." . ,ss-emacs-save-path)))
(setq auto-save-file-name-transforms `((".*" ,(file-name-as-directory ss-emacs-save-path) t)))
(setq undo-tree-history-directory-alist `((".*" . ,ss-emacs-save-path)))
(setq undo-tree-auto-save-history t)

(delete-selection-mode t)
(setq custom-file ss-custom-file)

(when (and window-system (not (eq window-system 'mac)))
  (setq mouse-wheel-scroll-amount '(0.01))
  (setq mouse-wheel-progressive-speed nil)
  (setq scroll-preserve-screen-position t)
  (setq ring-bell-function 'ignore))

(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda () (interactive) (scroll-down 1)))
  (global-set-key [mouse-5] (lambda () (interactive) (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t))

;;; fix mac-specific commands for emacs mac port
(when (eq window-system 'mac)

  (setq mac-command-modifier 'super)
  (setq mac-option-modifier 'meta)

  (defun isolate-kill-ring()
    "Isolate Emacs kill ring from OS X system pasteboard.
This function is only necessary in window system."
    (interactive)
    (setq interprogram-cut-function nil)
    (setq interprogram-paste-function nil))

  (defun pasteboard-copy()
    "Copy region to OS X system pasteboard."
    (interactive)
    (shell-command-on-region
     (region-beginning) (region-end) "pbcopy"))

  (defun pasteboard-paste()
    "Paste from OS X system pasteboard via `pbpaste' to point."
    (interactive)
    (shell-command-on-region
     (point) (if mark-active (mark) (point)) "pbpaste" nil t))

  (defun pasteboard-cut()
    "Cut region and put on OS X system pasteboard."
    (interactive)
    (pasteboard-copy)
    (delete-region (region-beginning) (region-end)))

  (progn
    (isolate-kill-ring)
    ;; bind CMD+C to pasteboard-copy
    (global-set-key (kbd "s-c") 'pasteboard-copy)
    ;; bind CMD+V to pasteboard-paste
    (global-set-key (kbd "s-v") 'pasteboard-paste)
    ;; bind CMD+X to pasteboard-cut
    (global-set-key (kbd "s-x") 'pasteboard-cut)
    (global-set-key (kbd "s-z") 'undo-tree-undo)))


;; prevent emacs from freezing when displaying hanzi and emoji.
(when (string-equal system-type "darwin")
  (when (fboundp 'set-fontset-font)
    (set-fontset-font t 'unicode "PingFang SC" nil 'prepend)
    (set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)))

;; ediff - don't start another frame
(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)
;; abbrev config
(add-hook 'text-mode-hook 'abbrev-mode)
(add-hook 'text-mode-hook 'auto-fill-mode)


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
(recentf-load-list)
(run-at-time nil (* 5 60) 'recentf-save-list)


(with-current-buffer (get-buffer-create "*Messages*")
  (emacs-lisp-mode))
(unless (boundp 'auto-revert-buffers-counter)
  (setq auto-revert-buffers-counter 0))


;; redefining the build-in function.
;; an emacs bug that happens when calling python-mode.
;; initially, the load-history is an alist, which the key is
;; a string and the val are symbols or lists.
;; something bad happens to the codebase that some alist cells
;; do not contain a key string. this causes the error to happen.
;; for more details, see:
;; https://emacs.stackexchange.com/questions/5552/emacs-on-android-org-mode-error-wrong-type-argument-stringp-require-t
(defun load-history-filename-element (file-regexp)
  "Get the first elt of `load-history' whose car matches FILE-REGEXP.
        Return nil if there isn't one."
  (let* ((loads load-history)
         (load-elt (and loads (car loads))))
    (save-match-data
      (while (and loads
                  (or (null (car load-elt))
                      (not (and (stringp (car load-elt)) ; new condition
                                (string-match file-regexp (car load-elt))))))
        (setq loads (cdr loads)
              load-elt (and loads (car loads)))))
    load-elt))

