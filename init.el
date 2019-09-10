;;; the core of this config.
(defun bunny ()
  (interactive)
  (insert-image
   (create-image
    (concat dotemacs-dotd-path "bunny.png") 'png nil)))


(setq dotemacs-dotd-path (expand-file-name "~/.emacs.d/"))
(load (expand-file-name "bunny-meta.el" dotemacs-dotd-path))
(load (expand-file-name "bunny-finetune.el" dotemacs-dotd-path))
(load (expand-file-name "bunny-core-packages.el" dotemacs-dotd-path))
(load (expand-file-name "bunny-appearance.el" dotemacs-dotd-path))
(load (expand-file-name "bunny-lang-python.el" dotemacs-dotd-path))
(load (expand-file-name "bunny-lang-lisp.el" dotemacs-dotd-path))
(load (expand-file-name "bunny-lang-latex.el" dotemacs-dotd-path))
(load custom-file)
