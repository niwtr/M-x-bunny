;;; The core of this config, DO NOT EDIT!
(defun bunny ()
  (interactive)
  (insert-image
   (create-image
    (concat dotemacs-dotd-path "/doc/bunny.png") 'png nil)))


(setq dotemacs-dotd-path (file-name-directory load-file-name))
(load (expand-file-name "bunny-meta.el" dotemacs-dotd-path))
(load (expand-file-name "bunny-core-packages.el" dotemacs-dotd-path))
(load (expand-file-name "bunny-appearance.el" dotemacs-dotd-path))
(load (expand-file-name "bunny-lang-python.el" dotemacs-dotd-path))
(when ss-use-feature-cpp
  (load (expand-file-name "bunny-lang-cpp.el" dotemacs-dotd-path)))
(when ss-use-feature-lisp
  (load (expand-file-name "bunny-lang-lisp.el" dotemacs-dotd-path)))
(when ss-use-feature-scala
  (load (expand-file-name "bunny-lang-scala.el" dotemacs-dotd-path)))
(when ss-use-feature-latex
  (load (expand-file-name "bunny-lang-latex.el" dotemacs-dotd-path)))
(load (expand-file-name "bunny-keybindings.el" dotemacs-dotd-path))
(load (expand-file-name "bunny-finetune.el" dotemacs-dotd-path))
(load custom-file)