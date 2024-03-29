(global-hl-line-mode +1)
(display-time-mode 1) ;; display time at mode line, no effect if use doom-modeline.
(fringe-mode 0)

(add-to-list 'custom-theme-load-path ss-theme-directory)

;;; GUI specific features

(defun bunny-set-emacs-font ()
  (interactive)
  (set-face-attribute 'default nil
		      :family ss-font-family
		      :height ss-font-height
		      :weight 'normal
		      :width 'normal))

(when window-system
  (bunny-set-emacs-font)
  ;; (if (string-equal system-type "darwin")
  ;;     (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)))
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (blink-cursor-mode -1))

;;; Terminal-specific features.
(unless window-system
  (menu-bar-mode -1))

(defadvice load-theme (before theme-dont-propagate activate)
  (mapc #'disable-theme custom-enabled-themes))


(defvar available-ui-themes
  `(
    default-emacs-theme
    default-emacs-black-theme
    monochrome
    moe-dark
    moe-light
    doom
    tao-yin
    tao-yang
    zerodark
    zenburn
    green-phosphor
    dracula
    leuven
    modus-operandi
    wombat
    vscode-dark-plus
    ))

(dolist (theme available-ui-themes)
  (set (intern (concat "use-" (symbol-name theme))) nil))
(set (intern (concat "use-" (symbol-name ss-ui-theme))) t)

(when use-default-emacs-theme
  (while custom-enabled-themes
    (disable-theme (car custom-enabled-themes)))
  (global-hl-line-mode -1))

(when use-default-emacs-black-theme
  (load-theme 'default-black t)
  (set-face-background 'vertical-border nil)
  (set-face-foreground 'vertical-border "black")
  (set-face-background 'iedit-occurrence "#696969"))

(when use-wombat
  (load-theme 'wombat t)
  (set-face-attribute 'region nil :foreground "black")
  (set-face-attribute 'region nil :background "white"))

(when use-zenburn
  (use-package zenburn-theme :ensure t
    :config
    (load-theme 'zenburn t)))

(when use-zerodark 
  (use-package zerodark-theme
    :ensure t
    :config
    (load-theme 'zerodark t)
    (zerodark-setup-modeline-format)))

(when (or use-moe-dark use-moe-light)
  (use-package moe-theme :ensure t
    :config
    (moe-theme-set-color 'orange)
    (if use-moe-dark
	(moe-dark)
      (moe-light))))

(when (or use-tao-yin use-tao-yang)
  (use-package tao-theme :ensure t
    :config
    (if use-tao-yin 
	(load-theme 'tao-yin t)
      (load-theme 'tao-yang t))))

(when use-green-phosphor
  (use-package green-phosphor-theme :ensure t
    :config
    (load-theme 'green-phosphor t)))

(when use-monochrome
  (use-package monochrome-theme :ensure t
    :config
    (load-theme 'monochrome t)))

(when use-dracula
  (use-package dracula-theme
    :ensure t
    :config (load-theme 'dracula t)))

(when use-leuven 
  (load-theme 'leuven t)
  (defun bunny-set-hl-line-for-lighter-theme ()
    (let ((color
	   (cond ((evil-motion-state-p) '("#d7d7ff" . "#ffffff"))
		 ((evil-insert-state-p) '("#ffffff" . "#ffffff"))
		 ((evil-normal-state-p) '("#d7ffd7" . "#ffffff"))
		 ((evil-visual-state-p) '("#ffffd7" . "#ffffff"))
		 ((evil-emacs-state-p)  '("#ffd7ff" . "#ffffff")))))
      (set-face-background 'hl-line (car color))))
  (add-hook 'post-command-hook 'bunny-set-hl-line-for-lighter-theme)
  (defadvice load-theme (before theme-dont-propagate activate)
    (remove-hook 'post-command-hook 'bunny-set-hl-line-for-lighter-theme)))

(when use-modus-operandi
  (use-package modus-operandi-theme :ensure t)
  (load-theme 'modus-operandi t))

(when use-doom
  (use-package doom-themes
    :ensure t
    :config
    ;; Global settings (defaults)
    (setq doom-themes-enable-bold t    
	  doom-themes-enable-italic t)
    (load-theme 'doom-city-lights t)
    ;;(load-theme 'doom-nord-light t)
    (setq doom-city-lights-brighter-comments t)
    (set-face-attribute 'region nil :background "#666")
    (doom-themes-neotree-config)
    (doom-themes-org-config)))

(awhen use-eshell-git-prompt
  (use-package eshell-git-prompt :ensure t
    :config
    (eshell-git-prompt-use-theme 'robbyrussell)))

(use-package all-the-icons :ensure t)

;;; This mode-line requires that projectile and evil is loaded.
(when use-doom-modeline
  (use-package eldoc-eval :ensure t)
  (use-package doom-modeline
    :ensure t
    :defer t
    :hook (after-init . doom-modeline-init)))


(when use-vscode-dark-plus
  (use-package vscode-dark-plus-theme
    :ensure t
    :config
    (load-theme 'vscode-dark-plus t)))
