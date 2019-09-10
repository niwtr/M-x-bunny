(require 'package)
(package-initialize)
;; (require 'rx)
(setq package-enable-at-startup nil)
(if (version< emacs-version "27.0")
    (package-initialize))
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

(use-package symbol-overlay :ensure t
  :after evil-leader
  :config
  (evil-leader/set-key "so" 'symbol-overlay-put)
  (evil-leader/set-key "sm" 'symbol-overlay-mode))

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
  (progn
    (setq evil-toggle-key "C-z")
    (define-key evil-normal-state-map "/" 'swiper)
    (define-key evil-normal-state-map (kbd "<tab>") 'evil-indent-line)
    (define-key evil-normal-state-map (kbd "TAB") 'evil-indent-line)
    (define-key evil-normal-state-map (kbd "C-f") 'scroll-down-10)
    (define-key evil-normal-state-map (kbd "C-b") 'scroll-up-10)
    (evil-global-set-key 'normal (kbd "Q") 'evil-quit)
    (evil-global-set-key 'motion (kbd "Q") 'evil-quit)
    (evil-ex-define-cmd "qa" 'evil-quit-all)
    (evil-ex-define-cmd "z" 'kill-this-buffer)
    (evil-ex-define-cmd "zq" 'ex-kill-buffer-and-close)
    (evil-ex-define-cmd "wz" 'ex-save-buffer-and-kill)
    (evil-ex-define-cmd "wzq" 'ex-save-kill-buffer-and-close)
    (evil-ex-define-cmd "x" 'ex-save-kill-buffer-and-close)
    (evil-mode 1)))


(use-package evil-leader
  :ensure t
  :init
  (progn
    (setq evil-leader/leader "<SPC>")
    (evil-leader/set-key
      "q" 'query-replace
      "K" 'kill-some-buffers
      "uv" 'undo-tree-visualize
      "<tab>" 'evil-switch-to-windows-last-buffer
      "TAB" 'evil-switch-to-windows-last-buffer
      "up" 'emacs-uptime
      "r" 'recenter
      "cp" 'check-parens
      "cg" 'customize-group
      "+" 'toggle-frame-maximized))
  :config (global-evil-leader-mode))

;; NOTE this package must be loaded here.
(use-package bunny-minor-mode-leader-keymap)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init 'neotree)
  (evil-collection-init 'dired))

(use-package evil-matchit
  :ensure t
  :config
  (global-evil-matchit-mode 1))

(use-package evil-nerd-commenter
  :ensure t
  :config (evil-leader/set-key
	    "cc" 'evilnc-comment-or-uncomment-lines))

(when use-evil-multiedit
  (use-package evil-multiedit :ensure t
    :config
    (defun evil-multi-edit-put-marker-and-move ()
      (interactive)
      (evil-multiedit-toggle-marker-here)
      (next-line)
      (backward-char))
    (evil-multiedit-default-keybinds)
    (define-key iedit-mode-occurrence-keymap (kbd "M-n") nil)
    (define-key iedit-mode-occurrence-keymap (kbd "M-p") nil)
    (define-key evil-normal-state-map (kbd "M-n") 'evil-multiedit-match-and-next)
    (define-key evil-multiedit-state-map (kbd "M-n") 'evil-multiedit-match-and-next)
    (define-key evil-visual-state-map (kbd "M-n") 'evil-multiedit-match-and-next)
    (define-key evil-normal-state-map (kbd "M-p") 'evil-multiedit-match-and-prev)
    (define-key evil-multiedit-state-map (kbd "M-p") 'evil-multiedit-match-and-prev)
    (define-key evil-visual-state-map (kbd "M-p") 'evil-multiedit-match-and-prev)
    (define-key evil-normal-state-map (kbd "M-RET") 'evil-multi-edit-put-marker-and-move)))

(use-package which-key :ensure t :config (which-key-mode))

(use-package shrink-path :ensure t)

(use-package projectile
  :ensure t
  :config
  (evil-leader/set-key
    "ps" 'projectile-switch-project))


(use-package neotree
  :ensure t
  :config
  (setq neo-window-fixed-size nil)
  (setq neo-theme 'icons)
  (evil-leader/set-key
    "tt" 'neotree-toggle))

(use-package ranger
  :ensure t
  :config
  (evil-leader/set-key
    "td" 'dired
    "tr" ' ranger))

(use-package ace-jump-mode :ensure t
  :config
  (setq ace-jump-mode-scope 'window)
  (autoload
    'ace-jump-mode-pop-mark
    "ace-jump-mode"
    "Ace jump back:-)"
    t)
  (eval-after-load "ace-jump-mode"
    '(ace-jump-mode-enable-mark-sync))
  (evil-global-set-key 'normal (kbd "'") 'ace-jump-mode)
  (evil-global-set-key 'normal (kbd "o") 'ace-jump-word-mode)
  (evil-global-set-key 'normal (kbd "z") 'ace-jump-line-mode)
  (evil-global-set-key 'operator (kbd "z") 'ace-jump-line-mode)
  (evil-global-set-key 'operator (kbd "o") 'ace-jump-word-mode)
  (evil-global-set-key 'visual (kbd "t") 'ace-jump-line-mode)
  (evil-global-set-key 'operator (kbd "t") 'ace-jump-line-mode)
  (evil-global-set-key 'normal (kbd "z") 'zap-to-char)
  (evil-global-set-key 'normal (kbd "Z") 'zap-up-to-char)
  (evil-global-set-key 'visual (kbd "o") 'ace-jump-word-mode)
  (evil-global-set-key 'visual (kbd "v") 'evil-visual-line)
  (evil-leader/set-key "j" 'ace-jump-mode)
  (evil-leader/set-key "," 'ace-jump-line-mode)
  (evil-leader/set-key "." 'ace-jump-mode-pop-mark))


(use-package ace-jump-zap :ensure t
  :config
  (evil-leader/set-key
    "z" 'ace-jump-zap-to-char))

(use-package ace-window
  :ensure t
  :config
  (evil-global-set-key 'normal "t" 'ace-window) ;; set the global key to t.
  (evil-global-set-key 'motion "t" 'ace-window) ;; set the global key to t.
  (evil-collection-define-key 'normal 'dired-mode-map "t" 'ace-window)
  (setq aw-scope 'frame) ;; allow window jumping only within a single frame.
  :init
  (progn
    (setq aw-keys '(?j ?k ?l ?\; ?u ?i ?o ?p ?\[))
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0 :color "blue")))))))

(use-package ivy :ensure t)
(use-package counsel :ensure t)
(use-package swiper
  :ensure t
  :bind (("C-s" . swiper)
	 ("C-x C-f" . counsel-find-file))
  :config
  (defun bunny-swiper-at-point (sym)
    "Use `swiper' to search for the `sym' at point."
    (interactive (list (thing-at-point 'symbol)))
    (swiper sym))
  (evil-global-set-key 'normal (kbd "?") 'bunny-swiper-at-point)
  (progn
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    (define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)
    (define-key swiper-map (kbd "?") 'swiper-avy)
    (define-key swiper-map (kbd "<escape>") 'minibuffer-keyboard-quit)))

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
  :config (progn
	    (setq helm-buffers-fuzzy-matching t)
	    (define-key helm-map (kbd "<tab>") #'helm-execute-persistent-action)
	    (define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
	    (define-key helm-map (kbd "<escape>") 'keyboard-escape-quit)
	    (helm-mode 1)
	    (evil-leader/set-key
	      "<SPC>" 'helm-M-x
	      "dv" 'describe-variable
	      "dk" 'describe-key
	      "df" 'describe-function
	      "eb" 'eval-buffer
	      "ee" 'eval-defun
	      "f" 'helm-find-files
	      "F" 'helm-recentf
	      "k" 'helm-show-kill-ring
	      "b" 'helm-buffers-list)
	    (evil-global-set-key 'normal (kbd "M-o") 'helm-projectile-switch-to-buffer)
	    (customize-set-variable 'helm-ff-lynx-style-map t)))
(use-package helm-projectile
  :ensure t
  :config
  (evil-leader/set-key
    "pf" 'helm-projectile-find-file
    "pa" 'helm-projectile-ag)
  (helm-projectile-on))

(use-package helm-descbinds
  :ensure t :config (evil-leader/set-key "db" 'helm-descbinds))

(use-package helm-ag :ensure t
  :config
  (evil-leader/set-key
    "ha" 'helm-ag))

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
(evil-collection-define-key 'normal 'dired-mode-map "y" '(lambda (&optional noeffect)
							   (interactive)
							   (dired-copy-filename-as-kill 0)))
(evil-collection-define-key 'normal 'dired-mode-map "Q" '(lambda (&optional arg)
							   (interactive)
							   (kill-this-buffer)))
(use-package transpose-frame
  :ensure t
  :config
  (evil-leader/set-key "tf" 'transpose-frame))

(use-package buffer-move :ensure t
  :config
  (evil-leader/set-key "<up>" 'buf-move-up)
  (evil-leader/set-key "<down>" 'buf-move-down)
  (evil-leader/set-key "<left>" 'buf-move-left)
  (evil-leader/set-key "<right>" 'buf-move-right))

(use-package eyebrowse
  :ensure t 
  :diminish eyebrowse-mode
  :config
  (progn
    (evil-global-set-key 'normal (kbd "gt") 'eyebrowse-next-window-config)
    (evil-global-set-key 'normal (kbd "gT") 'eyebrowse-prev-window-config)
    (evil-global-set-key 'normal (kbd "gc") 'eyebrowse-close-window-config)
    (evil-global-set-key 'normal (kbd "g?") 'eyebrowse-switch-to-window-config)
    (evil-leader/set-key
      "1" 'eyebrowse-switch-to-window-config-1
      "2" 'eyebrowse-switch-to-window-config-2
      "3" 'eyebrowse-switch-to-window-config-3
      "4" 'eyebrowse-switch-to-window-config-4)
    (eyebrowse-mode t)
    (setq eyebrowse-new-workspace t)))

(evil-leader/set-key
  "sf" 'suspend-frame)

(use-package golden-ratio
  :ensure t
  :config (evil-leader/set-key "tg" 'golden-ratio-mode)
  (define-advice select-window (:after (window &optional no-record)
				       golden-ratio-resize-window)
    (unless (string-match-p (regexp-quote "helm") (buffer-name))
      (golden-ratio))
    nil))


(use-package expand-region :ensure t :config
  (evil-leader/set-key "er" 'er/expand-region)
  (evil-global-set-key 'normal (kbd "C-r") 'er/expand-region)
  (evil-global-set-key 'normal (kbd "r") 'er/expand-region))

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
(evil-leader/set-key "n" 'narrow-or-widen-dwim)

(when use-iedit
  (use-package iedit :ensure t :config
    (setq iedit-use-symbol-boundaries nil)
    (setq iedit-occurrence-type-global 'word)
    (evil-leader/set-key "i" 'iedit-mode)))

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


;;; fix tab in org mode
(evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle) 
(evil-define-key 'normal org-mode-map (kbd "TAB") #'org-cycle)

(use-package org-preview-html :ensure t)
(define-minor-mode-leader-keymap 'org-mode
  ("e" . 'org-ctrl-c-ctrl-c)
  ("," . 'org-edit-special)
  ("h" . 'org-shiftleft)
  ("ol" . 'org-store-link)
  ("i" . 'org-insert-last-stored-link)
  ("l" . 'org-shiftright))

(evil-leader/set-key
  "ol" 'org-store-link
  "oi" 'org-insert-last-stored-link
  "oo" 'org-open-at-point)

(setq org-src-tab-acts-natively t)
(setq org-confirm-babel-evaluate nil)

(use-package git-timemachine :ensure t
  :config
  (eval-after-load 'git-timemachine
    '(progn
       (evil-make-overriding-map git-timemachine-mode-map 'normal)
       ;; force update evil keymaps after git-timemachine-mode loaded
       (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps)))
  (evil-leader/set-key "gt" 'git-timemachine))
(use-package magit :ensure t
  :config
  (evil-leader/set-key
    "gs" 'magit-status))

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

(define-minor-mode-leader-keymap 'emacs-lisp-mode
  ("e" . 'eval-defun)
  ("m" . 'emacs-lisp-macroexpand))
(use-minor-mode-leader-keymap 'lisp-interaction-mode 'emacs-lisp-mode)

(with-current-buffer (get-buffer-create "*Messages*")
  (emacs-lisp-mode))
(unless (boundp 'auto-revert-buffers-counter)
  (setq auto-revert-buffers-counter 0))

(use-package bunny-prettify-json-file
  :config
  (advice-add 'find-file :around #'prettify-json-file))

(use-package bunny-register-jumper
  :config
  (evil-leader/set-key
    "ma" 'push-register
    "mj" 'pop-register))
(use-package bunny-sshfs
  :config
  (evil-leader/set-key
    "mm" 'mount-sshfs
    "mu" 'umount-sshfs))

(use-package bunny-workgroups
  :config
  (setq wg-prefix-key nil)
  (evil-leader/set-key
    "sc" 'wg-create-workgroup
    "ss" 'wg-switch-to-workgroup
    "sk" 'wg-kill-workgroup
    "sd" 'wg-delete-workgroup)
  (workgroups-mode 1))

(use-package bunny-terminal-here
  :after multi-term
  :config
  (evil-leader/set-key "'" 'bunny-multi-term-here)
  (if window-system
      (evil-leader/set-key
	"\"" 'bunny-iterm2-here)
    (evil-leader/set-key
      "\"" '(lambda () (interactive)
	      (message "bunny-iterm2-here is not supported in terminal.")))))

(use-package bunny-eshell-extensions
  :config
  (evil-define-key 'normal 'eshell-mode-map (kbd "C-n") 'bunny-eshell-next)
  (evil-define-key 'insert 'eshell-mode-map (kbd "C-n") 'bunny-eshell-next)
  (evil-define-key 'visual 'eshell-mode-map (kbd "C-n") 'bunny-eshell-next)
  (evil-define-key 'normal 'eshell-mode-map (kbd "C-p") 'bunny-eshell-prev)
  (evil-define-key 'insert 'eshell-mode-map (kbd "C-p") 'bunny-eshell-prev)
  (evil-define-key 'visual 'eshell-mode-map (kbd "C-p") 'bunny-eshell-prev)
  (evil-leader/set-key
    "\\" 'bunny-neo-eshell)
  (evil-define-key 'normal 'eshell-mode-map (kbd "<RET>")
    #'bunny-eshell-commit-last-command)
  (evil-define-key 'normal 'eshell-mode-map (kbd "F")
    #'bunny-eshell-goto-input-line-and-insert)
  (evil-global-set-key 'normal (kbd "\\") 'bunny-helm-eshell-finder)
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
