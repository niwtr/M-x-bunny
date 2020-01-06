(require 'package)
(package-initialize)
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			 ("melpa" . "http://elpa.emacs-china.org/melpa/")
			 ("org"   . "http://elpa.emacs-china.org/org/")))
(cond ((eq ss-package-archives-source 'emacs-china) nil)
      ((eq ss-package-archives-source 'melpa)
       (setq package-archives '(("melpa" . "https://melpa.org/packages/"))))
      ((eq ss-package-archives-source 'all)
       (add-to-list package-archives '("melpa" . "https://melpa.org/packages/")))
      (t
       (error "Unsupported package archive source.")))

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(unless (package-installed-p 'org)
  (package-refresh-contents)
  (package-install 'org))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(add-to-list 'load-path ss-repo-directory)

(use-package aggressive-indent :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook 'aggressive-indent-mode)
  (add-hook 'lisp-interaction-mode-hook 'aggressive-indent-mode))

(use-package anaphora :ensure t)
(use-package try :ensure t)
(use-package exec-path-from-shell
  :ensure t
  :config (exec-path-from-shell-initialize))
(use-package macrostep :ensure t)
(use-package move-text :ensure t
  :config (move-text-default-bindings))

(use-package symbol-overlay :ensure t :after evil-leader)

(use-package highlight-parentheses
  :ensure t
  :config (global-highlight-parentheses-mode))

(use-package rainbow-delimiters :ensure t)
(use-package zone-rainbow :ensure t :after evil-leader)

(use-package posframe :ensure t)
(use-package hl-todo
  :ensure t
  :config
  (global-hl-todo-mode))

(use-package evil
  :ensure t
  :init
  (progn
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
    (setq evil-want-fine-undo t)
    (setq evil-auto-indent t
	  evil-search-wrap t))
  :config
  (defun ex-kill-buffer-and-close()
    (interactive)
    (kill-this-buffer)
    (evil-quit))
  (defun ex-save-buffer-and-kill()
    (interactive)
    (save-buffer)
    (kill-this-buffer))
  ;; for use personally
  (defun ex-save-kill-buffer-and-close()
    (interactive)
    (save-buffer)
    (kill-this-buffer)
    (evil-quit))
  (defun scroll-down-10 ()
    (interactive)
    (scroll-up 10))
  (defun scroll-up-10 ()
    (interactive)
    (scroll-down 10))
  (evil-mode 1))


(use-package evil-leader
  :ensure t
  :init
  (setq evil-leader/leader "<SPC>")
  :config (global-evil-leader-mode))

;; NOTE this package must be loaded here.
(use-package bunny-minor-mode-leader-keymap)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init 'neotree)
  (evil-collection-init 'xref)
  (evil-collection-define-key 'normal 'xref--xref-buffer-mode-map
    "n" 'xref-next-line
    "p" 'xref-prev-line)
  (evil-collection-init 'dired))

(use-package evil-matchit
  :ensure t
  :config
  (global-evil-matchit-mode 1))

(use-package evil-nerd-commenter :ensure t)

(when use-evil-multiedit
  (use-package evil-multiedit :ensure t
    :config
    (defun evil-multi-edit-put-marker-and-move ()
      (interactive)
      (evil-multiedit-toggle-marker-here)
      (next-line)
      (backward-char))))


(use-package which-key :ensure t :config (which-key-mode))

(use-package shrink-path :ensure t)

(use-package projectile :ensure t
  :config
  (projectile-load-known-projects)
  (advice-add 'projectile-add-known-project :after
	      (lambda (arg)
		(projectile-save-known-projects))))


(use-package neotree
  :ensure t
  :config
  (setq neo-window-fixed-size nil)
  (setq neo-theme 'icons))

(use-package ranger :ensure t)

(use-package ace-jump-mode :ensure t
  :config
  (setq ace-jump-mode-scope 'window)
  (autoload
    'ace-jump-mode-pop-mark
    "ace-jump-mode"
    "Ace jump back:-)"
    t)
  (eval-after-load "ace-jump-mode"
    '(ace-jump-mode-enable-mark-sync)))


(use-package ace-jump-zap :ensure t)

(use-package ace-window
  :ensure t
  :config
  (setq aw-scope 'frame) ;; allow window jumping only within a single frame.
  :init
  (progn
    (setq aw-keys '(?j ?k ?l ?\; ?u ?i ?o ?p ?\[))
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0 :color "blue")))))))

(use-package ivy :ensure t)

(use-package counsel :ensure t
  :config
  (when (locate-file "rg" exec-path)
    ;;; then use ripgrep.
    (setq counsel-grep-base-command
	  "rg -i -M 120 --no-heading --line-number --color never '%s' %s")))

(use-package swiper
  :ensure t
  :config
  (defun bunny-swiper-at-point (st ed)
    (interactive "r")
    (if (use-region-p)
	(counsel-grep-or-swiper (buffer-substring st ed))
      (counsel-grep-or-swiper (thing-at-point 'symbol)))))

;;; helm
(use-package helm
  :ensure t
  :demand t
    ;;; below: i disneed may be.
  :bind (("M-x" . 'helm-M-x))
  :bind (:map helm-map
	      ("M-i" . helm-previous-line)
	      ("M-k" . helm-next-line)
	      ("M-I" . helm-previous-page)
	      ("M-K" . helm-next-page)
	      ("M-h" . helm-beginning-of-buffer)
	      ("M-H" . helm-end-of-buffer))
  :config
  (setq helm-buffers-fuzzy-matching t)
  (helm-mode 1)
  (customize-set-variable 'helm-ff-lynx-style-map t))

(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))

(use-package helm-descbinds :ensure t)

(use-package helm-ag :ensure t)

(defun bunny--helm-filter-buffers (buffer-list)
  (delq nil (mapcar
	     (lambda (buffer)
	       (cond
		((eq (with-current-buffer buffer major-mode)  'eshell-mode) nil)
		((eq (with-current-buffer buffer major-mode)  'magit-process-mode) nil)
		((eq (with-current-buffer buffer major-mode)  'magit-mode) nil)
		((eq (with-current-buffer buffer major-mode)  'magit-status-mode) nil)
		((eq (with-current-buffer buffer major-mode)  'magit-diff-mode) nil)
		(t buffer)))
	     buffer-list)))
(advice-add 'helm-skip-boring-buffers :filter-return 'bunny--helm-filter-buffers)

;;; dired
(add-hook 'dired-mode-hook 'auto-revert-mode)
(use-package transpose-frame :ensure t)

(use-package buffer-move :ensure t)

(use-package eyebrowse
  :ensure t 
  :diminish eyebrowse-mode
  :config
  (eyebrowse-mode t)
  (setq eyebrowse-new-workspace t))

(use-package golden-ratio
  :ensure t
  :config 
  (define-advice select-window (:after (window &optional no-record)
				       golden-ratio-resize-window)
    (unless (string-match-p (regexp-quote "helm") (buffer-name))
      (golden-ratio))
    nil))


(use-package expand-region :ensure t
  :config
  (defconst left-pairs-char-list  '("(" "[" "{"))
  (defconst right-pairs-char-list '(")" "]" "}"))
  (defun er/bunny-smart-pair-auto-moving ()
    (let ((char-at-point (string (char-after))))
      (cond ((member char-at-point left-pairs-char-list)
	     (forward-char))
	    ((member char-at-point right-pairs-char-list)
	     (backward-char))
	    (t nil))))
  (defun er/bunny-mark-inside-quote ()
    (interactive)
    (funcall 'er/bunny-smart-pair-auto-moving)
    (funcall 'er/mark-inside-pairs))
  (defun er/bunny-mark-outside-quote ()
    (interactive)
    (funcall 'er/bunny-smart-pair-auto-moving)
    (funcall 'er/mark-outside-pairs)))


(defun narrow-or-widen-dwim (p)
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
	((region-active-p)
	 (narrow-to-region (region-beginning)
			   (region-end)))
	((derived-mode-p 'org-mode)
	 (cond ((ignore-errors (org-edit-src-code) t)
		(delete-other-windows))
	       ((ignore-errors (org-narrow-to-block) t))
	       (t (org-narrow-to-subtree))))
	((derived-mode-p 'latex-mode)
	 (LaTeX-narrow-to-environment))
	(t (narrow-to-defun))))

(when use-iedit
  (use-package iedit :ensure t :config
    (setq iedit-use-symbol-boundaries nil)
    (setq iedit-occurrence-type-global 'word)))

(use-package hungry-delete
  :ensure t
  :config (global-hungry-delete-mode))

(use-package htmlize :ensure t)

(use-package shell-pop
  :ensure t
  :init
  (setq
   shell-pop-shell-type (quote ("multi-term" "*multi-term*" 'multi-term))
   shell-pop-term-shell ss-shell-path
   shell-pop-window-size 30
   ;; shell-pop-full-span t
   shell-pop-window-position "bottom"))
(use-package multi-term :ensure t)

(use-package company
  :ensure t
  :config
  ;; (define-key company-active-map (kbd "TAB") 'company-complete-selection)
  ;; (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  (setq company-idle-delay 0.01)
  (setq company-minimum-prefix-length 1)
  (global-company-mode t)
  (setq company-dabbrev-code-other-buffers 'all)
  (setq company-dabbrev-downcase 0))


(use-package company-statistics
  :ensure t
  :config
  (company-statistics-mode))

(use-package org-preview-html :ensure t)

(setq org-src-tab-acts-natively t)
(setq org-confirm-babel-evaluate nil)

(use-package git-timemachine :ensure t
  :config
  (eval-after-load 'git-timemachine
    '(progn
       (evil-make-overriding-map git-timemachine-mode-map 'normal)
       ;; force update evil keymaps after git-timemachine-mode loaded
       (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps))))

(use-package magit :ensure t)

(use-package evil-magit :ensure t)
(use-package yaml-mode :ensure t :defer t)
(use-package elfeed :ensure t :defer t
  :config
  (setq elfeed-feeds
	'(("https://nullprogram.com/feed/" blog emacs)
          ("http://www.reddit.com/r/emacs/.rss" emacs))))

(use-package keyfreq :ensure t
	     :config
	     (keyfreq-mode 1)
	     (keyfreq-autosave-mode 1))

(use-package web-server :ensure t)

(use-package bunny-prettify-json-file
  :config
  (advice-add 'find-file :around #'prettify-json-file))

(use-package bunny-h5ls
  :config
  (advice-add 'find-file :around #'bunny-h5ls-h5file))

(use-package bunny-register-jumper)
(use-package bunny-sshfs :if use-bunny-sshfs)

(use-package bunny-workgroups
  :config
  (setq wg-prefix-key nil)
  (workgroups-mode 1))

(use-package bunny-terminal-here :after multi-term)

(use-package bunny-eshell-extensions
  :config
  (add-hook 'eshell-mode-hook
	    (lambda nil
	      (when (fboundp 'company-mode)
		(company-mode -1))
	      (when (fboundp 'auto-complete-mode)
		(auto-complete-mode -1))))
  (add-hook 'eshell-mode-hook
	    (lambda ()
	      (add-to-list 'eshell-visual-commands "ssh")
	      (add-to-list 'eshell-visual-commands "tail")
	      (add-to-list 'eshell-visual-commands "htop")
	      (add-to-list 'eshell-visual-commands "vim")
	      (add-to-list 'eshell-visual-commands "top")
	      (add-to-list 'eshell-visual-commands "gpustat")
	      (setq eshell-visual-subcommands '("git" "log" "l" "diff" "show"))))
  (add-hook 'eshell-mode-hook
	    (lambda ()
	      (eshell/alias "e" "find-file $1")
	      (eshell/alias "emacs" "find-file $1")
	      (eshell/alias "ee" "find-file-other-window $1")
	      (eshell/alias "gd" "magit-diff-unstaged")
	      (eshell/alias "gpu" "gpustat -i 1")
	      (eshell/alias "gds" "magit-diff-staged")
	      (eshell/alias "cl" "clear")
	      (eshell/alias "l" "ls -alh")
	      (eshell/alias "d" "dired $1"))))
(use-package bunny-company-simple-complete)
;; package for viewing clipboard from the remote server.
(use-package bunny-krws)
(use-package bunny-insert-surroundings)
