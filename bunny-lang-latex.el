(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-engine 'xetex) ; use xetex engine
(setq TeX-PDF-mode t) ; pdf instead of dvi
(use-package tex
  :defer t
  :ensure auctex
  :config
  (setq TeX-auto-save t)
  (setq TeX-command-list
	'(("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
	   (plain-tex-mode ams-tex-mode texinfo-mode)
	   :help "Run plain TeX")
	  ("LaTeX" "xelatex -interaction nonstopmode %t" TeX-run-TeX nil
	   (latex-mode doctex-mode)
	   :help "Run LaTeX")))
  )
(use-package company-auctex :defer t :ensure t :config
  (add-hook 'latex-mode-hook #'company-auctex-init))
(use-package academic-phrases :ensure t)
