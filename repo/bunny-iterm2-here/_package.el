;;; packages.el --- niwtr-iterm2-here layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: 牛天睿 <Heranort@Anzalized-NiwTR.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `niwtr-iterm2-here-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `niwtr-iterm2-here/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `niwtr-iterm2-here/pre-init-PACKAGE' and/or
;;   `niwtr-iterm2-here/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst niwtr-iterm2-here-packages
  '())


(defvar private-directory configuration-layer-private-layer-directory)
(defvar niwtr-niwtr-iterm2-script-path (concat private-directory "niwtr-iterm2-here/niwtr-iterm2-helper.py"))
(defvar niwtr-niwtr-iterm2-shell-script-path (concat private-directory "niwtr-iterm2-here/niwtr-iterm2-helper.sh"))


(defun flatten (list)
  (mapcan (lambda (x) (if (listp x) x nil)) list))

(defun niwtr/iterm2-here ()
  (interactive)
  (setq path default-directory)
  (setq python "python")
  (setq script niwtr-niwtr-iterm2-script-path)
  (setq shell-script niwtr-niwtr-iterm2-shell-script-path)
  (if (tramp-tramp-file-p path)
      (let* ((cmdlist
              (remove "" (split-string path "/")))
             (ssh (substring (car cmdlist) 4 -1))
             (dir (apply 'concat (flatten (mapcar (lambda (x) (list "/" x)) (cdr cmdlist)))))
             (z-cmd (concat python " " script " " shell-script " " ssh " " dir)))
        (message z-cmd)
        (start-process "iterm"  "*Messages*" "python" script shell-script ssh dir))
    (let ((z-cmd (concat python " " script " " shell-script " " path)))
      (message z-cmd)
      (start-process "iterm" "*Messages*" "python" script shell-script path))))

(spacemacs/set-leader-keys
  "\"" 'niwtr/iterm2-here)


;;; packages.el ends here
