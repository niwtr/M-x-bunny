;; emacs-china, melpa, or all
(setq ss-package-archives-source 'emacs-china)
(setq ss-shell-path "/bin/zsh")

;; appearance
(setq ss-ui-theme 'vscode-dark-plus)
;; (setq ss-ui-theme 'defrault-emacs-black-theme)

(setq use-doom-modeline nil)
(setq use-eshell-git-prompt 'powerline)

;; (setq ss-font-family "Source Code Pro")
(setq ss-font-family "IBM Plex Mono")
(setq ss-font-height 110)

;; python
(setq ss-python-env 'default)
(setq ss-python-system 'anaconda)
(setq ss-ms-pyls-executable 'default)

;; lisp
(setq ss-use-feature-lisp t)
(setq ss-lisp-system 'slime) ;; slime or sly or nil
(setq ss-inferior-lisp-program "/usr/bin/sbcl")

;; cpp
(setq ss-use-feature-cpp t)
(setq ss-c++-system 'dumb-jump)
(setq ss-ccls-executable "/usr/local/bin/ccls2")

;; scala
(setq ss-use-feature-scala nil)
(setq ss-scala-use-sbt nil)


;; latex
(setq ss-use-feature-latex nil)

;; multi-editing
(setq use-iedit t)
(setq use-evil-multiedit nil)


;; sshfs support [optional]
(setq use-bunny-sshfs nil)
(setq ss-remote-relative-path "/home/ntr/")
(setq ss-remote-machine-url "ntr@192.168.80.55")
(setq ss-local-path "/Users/Heranort/Remote/")

;; do not change these if you do not know what they do exactly.
(setq ss-emacs-save-path (concat dotemacs-dotd-path "emacs.saves"))
(setq ss-custom-file (concat dotemacs-dotd-path "custom.el"))
(setq ss-repo-directory (concat dotemacs-dotd-path "repo/"))
(setq ss-theme-directory (concat dotemacs-dotd-path "repo/bunny-themes"))
(setq ss-snippets-dir (concat dotemacs-dotd-path "snippets/"))
