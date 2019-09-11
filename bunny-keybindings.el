(require 'evil)
(require 'evil-leader)
(require 'bunny-minor-mode-leader-keymap)

;; evil
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

;; evil-leader
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
  "+" 'toggle-frame-maximized)

;; symbol-overlay
(require 'symbol-overlay)
 (evil-leader/set-key "so" 'symbol-overlay-put)
(evil-leader/set-key "sm" 'symbol-overlay-mode)

;; evil-nerd-commenter
(require 'evil-nerd-commenter)
(evil-leader/set-key
  "cc" 'evilnc-comment-or-uncomment-lines)


;; evil-multiedit
(when use-evil-multiedit
  (require 'evil-multiedit)
  (evil-multiedit-default-keybinds)
  (define-key iedit-mode-occurrence-keymap (kbd "M-n") nil)
  (define-key iedit-mode-occurrence-keymap (kbd "M-p") nil)
  (define-key evil-normal-state-map (kbd "M-n") 'evil-multiedit-match-and-next)
  (define-key evil-multiedit-state-map (kbd "M-n") 'evil-multiedit-match-and-next)
  (define-key evil-visual-state-map (kbd "M-n") 'evil-multiedit-match-and-next)
  (define-key evil-normal-state-map (kbd "M-p") 'evil-multiedit-match-and-prev)
  (define-key evil-multiedit-state-map (kbd "M-p") 'evil-multiedit-match-and-prev)
  (define-key evil-visual-state-map (kbd "M-p") 'evil-multiedit-match-and-prev)
  (define-key evil-normal-state-map (kbd "M-RET") 'evil-multi-edit-put-marker-and-move))

;; projectile

;; neotree and ranger
(require 'neotree)
(require 'ranger)
(evil-leader/set-key
  "tt" 'neotree-toggle
  "td" 'dired
  "tr" 'ranger)

;; ace-jump
(require 'ace-jump-mode)
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
(evil-leader/set-key "." 'ace-jump-mode-pop-mark)

;; ace-jump-zap
(require 'ace-jump-zap)
(evil-leader/set-key
  "z" 'ace-jump-zap-to-char)

;; ace-window
(require 'ace-window)
(evil-global-set-key 'normal "t" 'ace-window) ;; set the global key to t.
(evil-global-set-key 'motion "t" 'ace-window) ;; set the global key to t.
(evil-collection-define-key 'normal 'dired-mode-map "t" 'ace-window)


;; swiper
(require 'swiper)
(evil-global-set-key 'normal (kbd "?") 'bunny-swiper-at-point)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
(define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)
(define-key swiper-map (kbd "?") 'swiper-avy)
(define-key swiper-map (kbd "<escape>") 'minibuffer-keyboard-quit)


;; helm
(require 'helm)
(evil-global-set-key 'normal (kbd "M-o") 'helm-projectile-switch-to-buffer)
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
(define-key helm-map (kbd "<tab>") #'helm-execute-persistent-action)
(define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
(define-key helm-map (kbd "<escape>") 'keyboard-escape-quit)


;; helm-projectile
(require 'helm-projectile)
(evil-leader/set-key
  "pf" 'helm-projectile-find-file
  "pa" 'helm-projectile-ag)

;; helm-descbinds
(require 'helm-descbinds)
(evil-leader/set-key "db" 'helm-descbinds)

;; helm-ag
(require 'helm-ag)
(evil-leader/set-key
  "ha" 'helm-ag)

;; dired
(evil-collection-define-key 'normal
  'dired-mode-map "y" '(lambda (&optional noeffect)
			 (interactive)
			 (dired-copy-filename-as-kill 0)))
(evil-collection-define-key 'normal
  'dired-mode-map "Q" '(lambda (&optional arg)
			 (interactive)
			 (kill-this-buffer)))

;; transpose-frame
(require 'transpose-frame)
(evil-leader/set-key "tf" 'transpose-frame)

;; buffer-move
(require 'buffer-move)
(evil-leader/set-key
  "<up>" 'buf-move-up
  "<down>" 'buf-move-down
  "<left>" 'buf-move-left
  "<right>" 'buf-move-right)

;; eyebrowse
(require 'eyebrowse)
(evil-global-set-key 'normal (kbd "gt") 'eyebrowse-next-window-config)
(evil-global-set-key 'normal (kbd "gT") 'eyebrowse-prev-window-config)
(evil-global-set-key 'normal (kbd "gc") 'eyebrowse-close-window-config)
(evil-global-set-key 'normal (kbd "g?") 'eyebrowse-switch-to-window-config)
(evil-leader/set-key
  "1" 'eyebrowse-switch-to-window-config-1
  "2" 'eyebrowse-switch-to-window-config-2
  "3" 'eyebrowse-switch-to-window-config-3
  "4" 'eyebrowse-switch-to-window-config-4)

;; suspend-frame
(evil-leader/set-key
  "sf" 'suspend-frame)

;; golden-ratio
(require 'golden-ratio)
(evil-leader/set-key
  "tg" 'golden-ratio-mode)


;; expand-ragion
(require 'expand-region)
(evil-leader/set-key "er" 'er/expand-region)
(evil-global-set-key 'normal (kbd "C-r") 'er/expand-region)
(evil-global-set-key 'normal (kbd "r") 'er/expand-region)

;; narrow-or-widen-dwim
(evil-leader/set-key "n" 'narrow-or-widen-dwim)

;; iedit
(when use-iedit
  (require 'iedit)
  (evil-leader/set-key "i" 'iedit-mode))


;; org-mode
(require 'org)
;;; fix tab  org mode
(evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle) 
(evil-define-key 'normal org-mode-map (kbd "TAB") #'org-cycle)
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

;; git-timemachine
(require 'git-timemachine)
(evil-leader/set-key
  "gt" 'git-timemachine)

;; magit
(require 'magit)
(evil-leader/set-key
  "gs" 'magit-status)


(define-minor-mode-leader-keymap 'emacs-lisp-mode
  ("e" . 'eval-defun)
  ("m" . 'emacs-lisp-macroexpand))
(use-minor-mode-leader-keymap 'lisp-interaction-mode 'emacs-lisp-mode)


;; bunny-register-jumper
(require 'bunny-register-jumper)
(evil-leader/set-key
  "ma" 'push-register
  "mj" 'pop-register)

;; bunny-sshfs
(require 'bunny-sshfs)
(evil-leader/set-key
  "mm" 'mount-sshfs
  "mu" 'umount-sshfs)

;; bunny-workgroups
(require 'bunny-workgroups)
(evil-leader/set-key
  "sc" 'wg-create-workgroup
  "ss" 'wg-switch-to-workgroup
  "sk" 'wg-kill-workgroup
  "sd" 'wg-delete-workgroup)

;; bunny-terminal-here
(require 'bunny-terminal-here)
(evil-leader/set-key "'" 'bunny-multi-term-here)
(if window-system
    (evil-leader/set-key "\"" 'bunny-iterm2-here)
  (evil-leader/set-key
    "\"" '(lambda () (interactive)
	    (message "bunny-iterm2-here is not supported in terminal."))))

;; bunny-eshell-extensions
(require 'bunny-eshell-extensions)
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


;; bunny-keybindings.el ends here.