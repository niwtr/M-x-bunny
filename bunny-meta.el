;; emacs-china, melpa, or all
(setq ss-package-archives-source 'emacs-china)
(setq ss-shell-path "/bin/zsh")

;; appearance
(setq ss-ui-theme 'zenburn)
;; (setq ss-ui-theme 'modus-operandi)

(setq use-doom-modeline t)
(setq use-eshell-git-prompt 'powerline)

;; (setq ss-font-family "Source Code Pro")
(setq ss-font-family "IBM Plex Mono")
(setq ss-font-height 125)

;; python
(setq ss-python-env 'default)
(setq ss-python-system nil)
(setq ss-ms-pyls-executable 'default)

;; lisp
(setq ss-use-feature-lisp nil)
(setq ss-lisp-system nil) ;; slime or sly or nil
(setq ss-inferior-lisp-program "/home/niutr/bin/ecl")

;; cpp
(setq ss-use-feature-cpp nil)
(setq ss-c++-system 'ggtags)
(setq ss-ccls-executable "/usr/local/bin/ccls2")

;; scala
(setq ss-use-feature-scala nil)
(setq ss-scala-use-sbt nil)


;; latex
(setq ss-use-feature-latex nil)

;; multi-editing
(setq use-iedit nil)
(setq use-evil-multiedit t)


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
