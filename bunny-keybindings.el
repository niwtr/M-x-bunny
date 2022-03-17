(global-set-key (kbd "C-z") 'undo-tree-undo)

;; ace jump and ace window.
(require 'ace-jump-mode)
(global-set-key (kbd "M-o") 'ace-window)

;; undo tree, overwrites undo-redo.
(require 'undo-tree)
(global-set-key (kbd "C-/") 'undo-tree-undo)

;; swiper and counsel
(require 'swiper)
(global-set-key (kbd "C-s") 'bunny-swiper-at-point)
(global-set-key (kbd "M-x") 'counsel-M-x)
(define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)
(define-key swiper-map (kbd "?") 'swiper-avy)
(define-key swiper-map (kbd "<escape>") 'minibuffer-keyboard-quit)
(global-set-key (kbd "C-x F") 'counsel-recentf)
;; counsel-yank-pop/


;; ido
(global-set-key (kbd "C-x b") 'ido-switch-buffer)

;; expand-region
(require 'expand-region)
(global-set-key (kbd "C-r") 'er/expand-region)

(setq bunny-c-j-keymap (make-sparse-keymap))

(global-set-key (kbd "C-j") bunny-c-j-keymap)
(define-key paredit-mode-map (kbd "C-j") bunny-c-j-keymap)

;; bunny-insert-surroundings
(require 'bunny-insert-surroundings)
(define-key bunny-c-j-keymap (kbd "i (") 'bunny-insert-surroundings-paren)
(define-key bunny-c-j-keymap (kbd "i [") 'bunny-insert-surroundings-bracket)
(define-key bunny-c-j-keymap (kbd "i {") 'bunny-insert-surroundings-fancy-bracket)
(define-key bunny-c-j-keymap (kbd "i '") 'bunny-insert-surroundings-quote)
(define-key bunny-c-j-keymap (kbd "i i") 'bunny-insert-surroundings)
(define-key bunny-c-j-keymap (kbd "i \"") 'bunny-insert-surroundings-biquote)

(define-key bunny-c-j-keymap (kbd "w v") 'split-window-horizontally)
(define-key bunny-c-j-keymap (kbd "w s") 'split-window-vertically)
(define-key bunny-c-j-keymap (kbd "w k") 'delete-window)
(define-key bunny-c-j-keymap (kbd "w t") 'transpose-frame)
(define-key bunny-c-j-keymap (kbd "w q") 'delete-window)

(define-key bunny-c-j-keymap (kbd "p f") 'projectile-find-file)
(define-key bunny-c-j-keymap (kbd "p a") 'counsel-projectile-rg)
(define-key bunny-c-j-keymap (kbd "p s") 'projectile-switch-project)
(define-key bunny-c-j-keymap (kbd "p C-a") 'projectile-add-known-project)

(define-key bunny-c-j-keymap (kbd "C-j") 'ace-jump-word-mode)

;; magit and git-timemachine
(require 'magit)
(require 'git-timemachine)
(define-key bunny-c-j-keymap (kbd "g s") 'magit-status)
(define-key bunny-c-j-keymap (kbd "g t") 'git-timemachine)

;; undo-tree
(require 'undo-tree)
(define-key bunny-c-j-keymap (kbd "v") 'undo-tree-visualize)


;; emacs lisp mode.
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-defun)
(define-key emacs-lisp-mode-map (kbd "C-c C-k") 'eval-buffer)
;; lisp interaction mode
(define-key lisp-interaction-mode-map (kbd "C-c C-c") 'eval-defun)
(define-key lisp-interaction-mode-map (kbd "C-c C-k") 'eval-buffer)

;; multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)
(define-key bunny-c-j-keymap (kbd "m c") 'mc/edit-lines)

;; eyebrowse
(global-set-key (kbd "M-1") 'eyebrowse-switch-to-window-config-1)
(global-set-key (kbd "M-2") 'eyebrowse-switch-to-window-config-2)
(global-set-key (kbd "M-3") 'eyebrowse-switch-to-window-config-3)
(global-set-key (kbd "M-4") 'eyebrowse-switch-to-window-config-4)

;; 
;; bunny-keybindings.el ends here.





