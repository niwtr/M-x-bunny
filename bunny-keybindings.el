(require 'evil)
(require 'evil-leader)
(require 'undo-tree)
(require 'bunny-minor-mode-leader-keymap)

;; evil
(setq evil-toggle-key "C-z")
(define-key evil-normal-state-map "/" 'counsel-grep-or-swiper)
(define-key evil-normal-state-map (kbd "<tab>") 'evil-indent-line)
(define-key evil-normal-state-map (kbd "TAB") 'evil-indent-line)
(define-key evil-normal-state-map (kbd "C-f") 'scroll-down-10)
(define-key evil-normal-state-map (kbd "C-b") 'scroll-up-10)
(define-key evil-normal-state-map (kbd "C-o") 'evil-jump-forward)
(define-key evil-normal-state-map (kbd "C-p") 'evil-jump-backward)
(define-key evil-normal-state-map (kbd "u") 'undo-tree-undo)

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
  (define-key evil-normal-state-map (kbd "M-RET") 'evil-multi-edit-put-marker-and-move)
  (define-key evil-multiedit-state-map (kbd "z") 'ace-jump-zap-to-char)
  (define-key evil-multiedit-state-map (kbd "Z") 'ace-jump-zap-up-to-char))

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
;; (evil-global-set-key 'operator (kbd "t") 'ace-jump-line-mode)
(evil-global-set-key 'normal (kbd "z") 'ace-jump-zap-to-char)
(evil-global-set-key 'normal (kbd "Z") 'ace-jump-zap-up-to-char)
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
(evil-global-set-key 'visual (kbd "?") 'bunny-swiper-at-point)
(evil-global-set-key 'normal (kbd "C-/") 'ivy-resume)
(evil-global-set-key 'visual (kbd "C-/") 'ivy-resume)
;; used in terminal, identical to C-/
(evil-global-set-key 'normal (kbd "C-_") 'ivy-resume)
(evil-global-set-key 'visual (kbd "C-_") 'ivy-resume)
(evil-global-set-key 'operator (kbd "C-_") 'ivy-resume)
(evil-global-set-key 'insert (kbd "C-_") 'ivy-resume)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
(define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)
(define-key swiper-map (kbd "?") 'swiper-avy)
(define-key swiper-map (kbd "<escape>") 'minibuffer-keyboard-quit)


;; counsel
(require 'counsel)
(evil-leader/set-key
  "<SPC>" 'counsel-M-x
  "dv" 'describe-variable
  "dk" 'describe-key
  "df" 'describe-function
  "eb" (lambda () (interactive) (eval-buffer) (message "Buffer evaluated."))
  "ee" 'eval-defun
  "f" 'counsel-find-file
  "F" 'counsel-recentf
  "k" 'counsel-yank-pop
  "b" 'ivy-switch-buffer)

(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
(setq ivy-posframe-display-functions-alist
      '((swiper          . nil)
	(counsel-M-x     . ivy-posframe-display-at-frame-center)
	(t               . ivy-posframe-display-at-frame-center)))


(evil-global-set-key 'insert (kbd "M-x") 'smex)
(evil-global-set-key 'visual (kbd "M-x") 'smex)
(evil-global-set-key 'normal (kbd "M-x") 'smex)

;; this is suboptimal
(evil-global-set-key 'normal (kbd "M-o") 'counsel-projectile-switch-to-buffer)
(evil-leader/set-key
  "ps" 'counsel-projectile-switch-project
  "pf" 'counsel-projectile-find-file
  "ppa" 'projectile-add-known-project
  "ppc" 'projectile-cleanup-known-projects
  "ppd" 'projectile-remove-known-project
  "ppC" 'projectile-clear-known-projects
  "pa" (cond ((locate-file "rg" exec-path) 'counsel-projectile-rg)
	     ((locate-file "ag" exec-path) 'counsel-projectile-ag)
	     (t
	      (defun counsel-projectile-ag-dummy ()
		(interactive)
		(message
		 "You don't have rg or ag installed in your computer. Install them first."))
	      'counsel-projectile-ag-dummy)))

;; dired
(evil-collection-define-key 'normal
  'dired-mode-map "y" '(lambda (&optional noeffect)
			 (interactive)
			 (dired-copy-filename-as-kill 0)))
(evil-collection-define-key 'normal
  'dired-mode-map "Q" '(lambda (&optional arg)
			 (interactive)
			 (kill-this-buffer)))
(require 'dired-subtree)
(evil-collection-define-key 'normal
  'dired-mode-map (kbd "TAB") 'dired-subtree-toggle)

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
;; fix keybinds for GUI mode.
(evil-define-key 'normal magit-mode-map (kbd "<tab>") 'magit-section-toggle)
(evil-leader/set-key
  "gs" 'magit-status)


(define-minor-mode-leader-keymap 'emacs-lisp-mode
  ("d" . 'xref-find-definitions)
  ("r" . 'xref-find-references)
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

(defun renew-bunny-eshell-keybindings ()
  (require 'bunny-eshell-extensions)
  (evil-define-key 'normal eshell-mode-map (kbd "C-n") 'bunny-eshell-next-within-project)
  (evil-define-key 'insert eshell-mode-map (kbd "C-n") 'bunny-eshell-next-within-project)
  (evil-define-key 'visual eshell-mode-map (kbd "C-n") 'bunny-eshell-next-within-project)
  (evil-define-key 'normal eshell-mode-map (kbd "C-p") 'bunny-eshell-prev-within-project)
  (evil-define-key 'insert eshell-mode-map (kbd "C-p") 'bunny-eshell-prev-within-project)
  (evil-define-key 'visual eshell-mode-map (kbd "C-p") 'bunny-eshell-prev-within-project)
  (evil-leader/set-key
    "\\" 'bunny-neo-eshell
    "|" 'bunny-eshell-command)

  (evil-define-key 'normal eshell-mode-map (kbd "<RET>")
    #'bunny-eshell-maybe-commit-last)
  (evil-define-key 'normal eshell-mode-map (kbd "F")
    #'bunny-eshell-goto-input-line-and-insert)


  (evil-global-set-key 'normal (kbd "\\") 'bunny-ivy-eshell-finder)
  (define-minor-mode-leader-keymap 'eshell-mode :overwrite t
    ("c" . 'eshell-clear)
    ("i" . 'eshell-interrupt-process)
    ("," . (lambda ()
	     (interactive)
	     (eshell-interrupt-process)
	     (bunny-eshell-goto-input-line-and-insert)))))

(renew-bunny-eshell-keybindings)
(add-hook ;; renewing a new eshell may override the previous keybinding settings. 
 'eshell-mode-hook #'renew-bunny-eshell-keybindings)

(require 'bunny-insert-surroundings)
(evil-leader/set-key
  "i(" 'bunny-insert-surroundings-paren
  "i[" 'bunny-insert-surroundings-bracket
  "i{" 'bunny-insert-surroundings-fancy-bracket
  "i'" 'bunny-insert-surroundings-quote
  "ii" 'bunny-insert-surroundings
  "i\"" 'bunny-insert-surroundings-biquote)


;;; --------------------- lang python --------------------------------

(evil-global-set-key 'normal "ew"  'er/mark-word)
(evil-global-set-key 'normal "ej"  'er/mark-symbol)
(evil-global-set-key 'normal "em"  'er/mark-method-call)
;; (evil-global-set-key 'normal "ep"  'er/mark-inside-pairs)
;; (evil-global-set-key 'normal "eP"  'er/mark-outside-pairs)
;; (evil-global-set-key 'normal "e)"  'er/mark-outside-pairs)
(evil-global-set-key 'normal "ep" 'er/bunny-mark-inside-quote)
(evil-global-set-key 'normal "eP" 'er/bunny-mark-outside-quote)
(evil-global-set-key 'normal "e)" 'er/bunny-mark-outside-quote)
(evil-global-set-key 'normal "eq"  'er/mark-inside-quotes)
(evil-global-set-key 'normal "e'"  'er/mark-inside-quotes)
(evil-global-set-key 'normal "eQ"  'er/mark-outside-quotes)
(evil-global-set-key 'normal "e\""  'er/mark-outside-quotes)
(evil-global-set-key 'normal "ec"  'er/mark-comment)
(evil-global-set-key 'normal "ew"  'er/mark-word)
(evil-global-set-key 'normal "ef"  'er/mark-defun)
(evil-define-key 'normal python-mode-map "es" 'er/mark-python-statement)
(evil-define-key 'normal python-mode-map "eb" 'er/mark-python-block)

(define-minor-mode-leader-keymap 'python-mode :overwrite t
  ("d" . 'xref-find-definitions)
  ("o" . 'xref-find-definitions-other-window)
  ("r" . 'xref-find-references)
  ("e" . 'python-shell-run)
  ("C" . 'python-clear-shell)
  ("c" . 'python-shell-send-buffer))
(when use-anaconda
  (require 'anaconda-mode)
  (define-minor-mode-leader-keymap 'python-mode :overwrite t
    ("adc" . 'anaconda-mode-find-definitions)
    ("adw" . 'anaconda-mode-find-definitions-other-window)
    ("arc" . 'anaconda-mode-find-references)
    ("arw" . 'anaconda-mode-find-references-other-window)
    ("asc" . 'anaconda-mode-find-assignments)
    ("asw" . 'anaconda-mode-find-assignments-other-window)
    ("ao" . 'anaconda-mode-show-doc)))
(when use-company-jedi
  (require 'company-jedi)
  (define-minor-mode-leader-keymap 'python-mode :overwrite nil
    ("d" . 'jedi:goto-definition)
    ("b" . 'jedi:goto-definition-pop-marker)))
(when use-jedi
  (require 'jedi)
  (define-minor-mode-leader-keymap 'python-mode :overwrite nil
    ("sd" . 'jedi:show-doc)
    ("d" . 'jedi:goto-definition)
    ("b" . 'jedi:goto-definition-pop-marker)))

;;; -------------------- lang CPP ---------------------------------
(when ss-use-feature-cpp
  (define-minor-mode-leader-keymap 'c++-mode :overwrite t
    ("d" . 'xref-find-definitions)
    ("r" . 'xref-find-references)
    ("o" . 'xref-find-definitions-other-window)
    ("e" . 'bunny-compile-and-run-c++-file))
  (when (eq ss-c++-system 'ggtags)
    (define-minor-mode-leader-keymap 'c++-mode :overwrite nil
      ("g" . 'ggtags-create-tags)))

  (when (eq ss-c++-system 'lsp)
    (define-minor-mode-leader-keymap 'c++-mode :overwrite nil
      ("d" . 'lsp-find-definition)
      ("r" . 'lsp-find-references))))


;;; -------------------- lang lisp ---------------------------------
(when ss-use-feature-lisp
  (when  use-slime
    (require 'slime)
    (define-minor-mode-leader-keymap 'lisp-mode
      ("C" . 'slime-connect)
      (","  . 'slime-compile-defun)
      ("ee" . 'slime-eval-defun)
      ("mo" . 'slime-macroexpand-1)
      ("mm" . 'slime-macroexpand-all)
      ("eb" . 'slime-eval-buffer)))
  
  (when use-sly
    (require 'sly)
    (evil-define-key 'normal sly-mrepl-mode-map (kbd "0") 'sly-db-invoke-restart-0)
    (evil-define-key 'normal sly-mrepl-mode-map (kbd "1") 'sly-db-invoke-restart-1)
    (evil-define-key 'normal sly-mrepl-mode-map (kbd "2") 'sly-db-invoke-restart-2)
    (evil-define-key 'normal sly-mrepl-mode-map (kbd "3") 'sly-db-invoke-restart-3)
    (evil-define-key 'normal sly-mrepl-mode-map (kbd "4") 'sly-db-invoke-restart-4)
    (evil-define-key 'normal sly-mrepl-mode-map (kbd "5") 'sly-db-invoke-restart-5)
    (evil-define-key 'normal sly-mrepl-mode-map (kbd "6") 'sly-db-invoke-restart-6)
    (evil-define-key 'normal sly-mrepl-mode-map (kbd "7") 'sly-db-invoke-restart-7)
    (evil-define-key 'normal sly-mrepl-mode-map (kbd "8") 'sly-db-invoke-restart-8)
    (define-minor-mode-leader-keymap 'lisp-mode
      ("1" . 'sly-db-invoke-restart)
      ("C" . 'sly-connect)
      (","  . 'sly-compile-defun)
      ("mo" . 'sly-macroexpand-1)
      ("mm" . 'sly-macroexpand-all)
      ("ee" . 'sly-eval-defun)
      ("eb" . 'sly-eval-buffer)))
  )




;;; ---------------------- lang LaTeX -------------------------------
(when ss-use-feature-latex
  (require 'tex)
  (define-minor-mode-leader-keymap 'LaTeX-mode
    ("me" . 'LaTeX-mark-environment)
    ("ms" . 'LaTeX-mark-section)
    ("e" .  'LaTeX-environment)
    ("c" .  'LaTeX-close-environment)
    ("ps" . 'preview-section)
    ("pd" . 'preview-document)
    ("pr" . 'preview-region)
    ("pe" . 'preview-environment)))


;;;; experimental ;;;;;;
(require 'hydra)
(defhydra hydra-window ()
  "Bunny Window Manager"
  ("q" nil)
  ("d" delete-window "kill this window")
  ("h" bunny-window-left "new window left")
  ("l" bunny-window-right "new window right")
  ("j" bunny-window-down "new window down")
  ("k" bunny-window-up "new window up")
  ("H" windmove-left "left")
  ("J" windmove-down "down")
  ("K" windmove-up "up")
  ("L" windmove-right "right"))
(evil-global-set-key 'normal (kbd "M-w") 'hydra-window/body)



;;; to make compatibility with emacs state.
(evil-global-set-key 'insert (kbd "C-a") 'move-beginning-of-line)
(evil-global-set-key 'insert (kbd "C-e") 'move-end-of-line)
(evil-global-set-key 'insert (kbd "C-p") 'previous-line)
(evil-global-set-key 'insert (kbd "C-n") 'next-line)
(evil-global-set-key 'insert (kbd "C-k") 'kill-line)
(evil-global-set-key 'insert (kbd "C-d") 'hungry-delete-forward)

(evil-global-set-key 'insert (kbd "M-p") 'backward-paragraph)
(evil-global-set-key 'insert (kbd "M-n") 'forward-paragraph)


(require 'bunny-tweaks)
(define-key evil-visual-state-map (kbd ">") 'bunny-evil-shift-right-visual)
(define-key evil-visual-state-map (kbd "<") 'bunny-evil-shift-left-visual)

(require 'bunny-pair-ranger)
(evil-global-set-key 'normal (kbd ")") 'bunny-pair-ranger-forward-to-right-bracket)
(evil-global-set-key 'normal (kbd "(") 'bunny-pair-ranger-backward-to-left-bracket)
(evil-global-set-key 'visual (kbd ")") 'bunny-pair-ranger-forward-to-right-bracket)
(evil-global-set-key 'visual (kbd "(") 'bunny-pair-ranger-backward-to-left-bracket)


;; 
;; bunny-keybindings.el ends here.

