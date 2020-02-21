(defun bunny-window-left ()
  (interactive)
  (evil-window-vsplit)
  (windmove-right))

(defun bunny-window-right ()
  (interactive)
  (evil-window-vsplit))

(defun bunny-window-up ()
  (interactive)
  (evil-window-split)
  (windmove-down))

(defun bunny-window-down ()
  (interactive)
  (evil-window-split))



(provide 'bunny-window-manager)
