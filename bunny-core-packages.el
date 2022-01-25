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

(use-package multiple-cursors :ensure t)

(use-package paredit :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode))

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

(use-package highlight-parentheses
  :ensure t
  :config (global-highlight-parentheses-mode))

(use-package rainbow-delimiters :ensure t :config
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'lisp-interaction-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'lisp-mode-hook #'rainbow-delimiters-mode))

(use-package zone-rainbow :ensure t)

(use-package posframe :ensure t)

(use-package hl-todo
  :ensure t
  :config
  (global-hl-todo-mode))


(use-package hydra :ensure t)

(use-package which-key :ensure t :config (which-key-mode))

(use-package shrink-path :ensure t)

(use-package projectile :ensure t
  :config
  (setq projectile-globally-ignored-directories
	'(".git"
	  ".ccls-cache"
	  ".svn"
	  ".idea"
	  ".stack-work"
	  ".cquery_cached_index"))
  (projectile-global-mode)
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

(use-package ivy :ensure t :config
  (ivy-mode +1)
  (setq ivy-do-completion-in-region nil)
  (setq ivy-re-builders-alist
	'((counsel-M-x . ivy--regex-ignore-order)
	  (swiper . ivy--regex-plus)
	  (t  . ivy--regex-ignore-order))))

(use-package ivy-rich :ensure t
  :config
  (ivy-rich-mode +1))

(use-package counsel :ensure t
  :config
  (setcdr (assoc 'counsel-M-x ivy-initial-inputs-alist) "")
  (setq counsel-find-file-ignore-regexp "\\.ccls-cache")
  (when (locate-file "rg" exec-path)
    ;;; then use ripgrep.
    (setq counsel-grep-base-command
	  "rg -i -M 120 --no-heading --line-number --color never '%s' %s")))

(use-package smex :ensure t)
(use-package counsel-projectile	:ensure t)

(use-package ivy-posframe :ensure t
  :init
  (setq ivy-posframe-display-functions-alist
	'((swiper          . nil)
	  (counsel-M-x     . ivy-posframe-display-at-frame-center)
	  (counsel-recentf . nil)
	  (t               . ivy-posframe-display-at-frame-center)))
  :config
  (ivy-posframe-mode +1))

(use-package swiper
  :ensure t
  :config
  (defun bunny-swiper-at-point (&optional st ed)
    (interactive
     (when (use-region-p)
       (list (region-beginning) (region-end))))
    (if (null st)
	(counsel-grep-or-swiper)
      (counsel-grep-or-swiper (buffer-substring st ed)))))


(add-to-list 'ivy-ignore-buffers
	     (lambda (buffer)
	       (memq (with-current-buffer buffer major-mode)
		     '(eshell-mode
		       magit-process-mode
		       magit-status-mode
		       magit-diff-mode))))


;; undo tree
(use-package undo-tree :ensure t :after aggressive-indent
  :init
  (add-to-list 'aggressive-indent-protected-commands #'undo-tree-visualize-undo)
  (add-to-list 'aggressive-indent-protected-commands #'undo-tree-visualize-redo)
  (with-eval-after-load 'undo-tree
    (defun undo-tree-overridden-undo-bindings-p () nil))
  (global-undo-tree-mode))

;;; dired
(use-package dired-subtree :ensure t)

(use-package dired-rainbow
  :ensure t
  :config
  (progn
    (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
    (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
    (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
    (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
    (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
    (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
    (dired-rainbow-define media "#de751f" ("mp3" "mp4" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
    (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
    (dired-rainbow-define log "#c17d11" ("log"))
    (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
    (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
    (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
    (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
    (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
    (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
    (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
    (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
    (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
    (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
    (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*")
    ))

(add-hook 'dired-mode-hook 'auto-revert-mode)
(use-package transpose-frame :ensure t)

(use-package buffer-move :ensure t)

(use-package eyebrowse
  :ensure t 
  :diminish eyebrowse-mode
  :config
  (eyebrowse-mode t)
  (setq eyebrowse-new-workspace t))

(use-package golden-ratio :ensure t)

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

(use-package git-timemachine :ensure t)

(use-package magit :ensure t)

;; (use-package evil-magit :ensure t)
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

(use-package bunny-window-manager)

(use-package bunny-tweaks)


;;; bunny-core-packages.el ends here.
