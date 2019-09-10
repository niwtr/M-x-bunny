(setq ss-emacs-save-path (concat dotemacs-dotd-path "emacs.saves"))
(setq ss-custom-file (concat dotemacs-dotd-path "custom.el"))
(setq ss-repo-directory (concat dotemacs-dotd-path "repo/"))
(setq ss-snippets-dir (concat dotemacs-dotd-path "snippets/"))

;; for online package repository config
(setq ss-country 'china)

(setq ss-shell-path "/bin/zsh")

;; appearance
(setq use-mono nil)
(setq use-moe nil)
(setq use-doom nil)
(setq use-tao nil)
(setq use-zerodark nil)
(setq use-green-phosphor nil)
(setq use-dracula nil) ;; another good theme for terminal.
(setq use-leuven t) ;; a built-in, light background theme.

(setq use-doom-modeline t)
(setq use-eshell-git-prompt 'powerline)
(setq ss-font-family "Source Code Pro")
(setq ss-font-height 120)



;; python
(setq ss-python-env 'default)
(setq ss-python-system 'lsp)
(setq ss-ms-pyls-directory
      "/raid_sdc/home/ntr/python-language-server/output/bin/Release/")

;; lisp
(setq ss-lisp-system nil) ;; slime or sly
(setq ss-inferior-lisp-program "/home/niutr/bin/ecl")

;; latex
(setq ss-have-latex nil)

;; multiple cursors
(setq use-iedit nil)
(setq use-evil-multiedit t)


;; sshfs support [optional]
(setq ss-remote-relative-path "/home/ntr/")
(setq ss-remote-machine-url "ntr@192.168.80.55")
(setq ss-local-path "/Users/Heranort/Remote/")
