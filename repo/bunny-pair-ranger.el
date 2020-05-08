;;; -*- lexical-binding: t; -*-

(require 'hydra)


;; (defun bunny-forward-to-char-in-line ()
;;   (interactive)
;;   (bunny-move-to-char-in-line t bunny-pair-last-target))

;; (defun bunny-backward-to-char-in-line ()
;;   (interactive)
;;   (bunny-move-to-char-in-line nil bunny-pair-last-target))

;; (defhydra bunny-pair-ranger-hydra ()
;;   "bunny-pair-ranger"
;;   ("q" nil)
;;   (")" bunny-forward-to-char-in-line)
;;   ("(" bunny-backward-to-char-in-line))
;; (defvar bunny-pair-last-target nil)
;; (defun bunny-pair-ranger-initial-right ()
;;   (interactive)
;;   (setf bunny-pair-last-target bunny-pair-ranger-right-pairs)
;;   (bunny-forward-to-char-in-line)
;;   (bunny-pair-ranger-hydra/body))

;; (defun bunny-pair-ranger-initial-left ()
;;   (interactive)
;;   (setf bunny-pair-last-target bunny-pair-ranger-left-pairs)
;;   (bunny-forward-to-char-in-line)
;;   (bunny-pair-ranger-hydra/body))


(defconst bunny-pair-ranger-right-pairs '(?\) ?\} ?\] ?\" ?\'))
(defconst bunny-pair-ranger-left-pairs '(?\( ?\{ ?\[ ?\" ?\'))

(defun bunny-move-to-char-in-line (forward char-set)
  (setq target-char nil)
  (setq boundary (if forward (point-at-eol) (point-at-bol)))
  (save-excursion
    (while (and (if forward 
		    (< (point) boundary)
		  (> (point) boundary))
		(null target-char))
      (if forward (forward-char) (backward-char))
      (when (member (char-after (point)) char-set)
	(setf target-char (point)))))
  (if target-char
      (goto-char target-char)
    (goto-char boundary)))

(defun bunny-pair-ranger-forward-to-right-bracket ()
  (interactive)
  (if (null current-prefix-arg) ;; forward
      (bunny-move-to-char-in-line t bunny-pair-ranger-right-pairs)
    (bunny-move-to-char-in-line nil bunny-pair-ranger-right-pairs)))

(defun bunny-pair-ranger-backward-to-left-bracket ()
  (interactive)
  (if (null current-prefix-arg) ;; backward 
      (bunny-move-to-char-in-line nil bunny-pair-ranger-left-pairs)
    (bunny-move-to-char-in-line t bunny-pair-ranger-left-pairs)))

(provide 'bunny-pair-ranger)
