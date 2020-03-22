(require 'evil)
(defun bunny-evil-shift-left-visual ()
  (interactive)
  (evil-shift-left (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(defun bunny-evil-shift-right-visual ()
  (interactive)
  (evil-shift-right (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(defun new-python-scratch ()
  "open up a guaranteed new scratch buffer"
  (interactive)
  (switch-to-buffer (loop for num from 0
			  for name = (format "temp-buffer-%03i" num)
			  while (get-buffer name)
			  finally return name))
  (python-mode))

(defun new-python-scratch-with-current-clipboard ()
  "open up a guaranteed new scratch buffer"
  (interactive)
  (switch-to-buffer (loop for num from 0
			  for name = (format "temp-buffer-%03i" num)
			  while (get-buffer name)
			  finally return name))
  (python-mode)
  (insert "from typing import List\n")
  (yank))

(provide 'bunny-tweaks)
