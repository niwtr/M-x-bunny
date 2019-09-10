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

(require 'package)
(package-initialize)
(require 'rx)
(setq package-enable-at-startup nil)
(if (version< emacs-version "27.0")
    (package-initialize))

;;; Make sure org is installed first.
(unless (package-installed-p 'org)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
  (package-refresh-contents)
  (package-install 'org))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			 ("melpa" . "http://elpa.emacs-china.org/melpa/")
			 ("org"   . "http://elpa.emacs-china.org/org/")))
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

;;; the core of this config.
(defun bunny ()
  (interactive)
  (insert-image
   (create-image
    (concat dotemacs-dotd-path "bunny.png") 'png nil)))
(setq dotemacs-dotd-path (expand-file-name "~/.emacs.d/"))
(load-file (expand-file-name "bunny-meta.el" dotemacs-dotd-path))
(setq backup-directory-alist `(("." . ,ss-emacs-save-path)))
(add-to-list 'load-path ss-repo-directory)
(setq custom-file ss-custom-file)
(load (expand-file-name "bunny-core-packages.el" dotemacs-dotd-path))
(load (expand-file-name "bunny-appearance.el" dotemacs-dotd-path))
(load (expand-file-name "bunny-lang-python.el" dotemacs-dotd-path))
(load (expand-file-name "bunny-lang-lisp.el" dotemacs-dotd-path))
(load (expand-file-name "bunny-lang-latex.el" dotemacs-dotd-path))
(load custom-file)
