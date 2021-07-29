(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu 0.0)
 '(ansi-color-names-vector
   ["#E8E8E8" "#3C3C3C" "#616161" "#0E0E0E" "#252525" "#3C3C3C" "#171717" "#0E0E0E"])
 '(beacon-color 0)
 '(beacon-size 10)
 '(bunny-kill-ring-webserver-port 9002)
 '(bunny-kill-ring-webserver-type 'GET)
 '(column-number-mode t)
 '(company-backends
   '(company-bbdb company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-files
                  (company-dabbrev-code company-gtags company-etags company-keywords)
                  company-oddmuse company-dabbrev))
 '(company-lsp-enable-recompletion t)
 '(company-lsp-enable-snippet nil)
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-safe-themes
   '("e6df46d5085fde0ad56a46ef69ebb388193080cc9819e2d6024c9c6e27388ba9" "a2d15037241981e30bd11f2dd72375e417732deade35f4badafed7b97375dfeb" "ae3a3bed17b28585ce84266893fa3a4ef0d7d721451c887df5ef3e24a9efef8c" "274fa62b00d732d093fc3f120aca1b31a6bb484492f31081c1814a858e25c72e" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "801a567c87755fe65d0484cb2bded31a4c5bb24fd1fe0ed11e6c02254017acb2" "59e82a683db7129c0142b4b5a35dbbeaf8e01a4b81588f8c163bd255b76f4d21" "aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" "7f89ec3c988c398b88f7304a75ed225eaac64efa8df3638c815acc563dfd3b55" "e2fd81495089dc09d14a88f29dfdff7645f213e2c03650ac2dd275de52a513de" "a622aaf6377fe1cd14e4298497b7b2cae2efc9e0ce362dade3a58c16c89e089c" "2a9039b093df61e4517302f40ebaf2d3e95215cb2f9684c8c1a446659ee226b9" "dbade2e946597b9cda3e61978b5fcc14fa3afa2d3c4391d477bdaeff8f5638c5" "2627cddb3ebd7823f798168e36839f337c5a9572309fea8b3d85f2f7ce0fdd99" "7fa9e1ed443cd2d9ef9833817f26aafe198a8055c0d78233d5be9a5745877267" "ade910242ef032a4199806257f69a9e4b9b4e80fbcf4b693d701b22e477ca48f" "26bd9b67f3bdb19c17febb7796a9e5d1e14f82ab4099e94305ad4918c5b022d0" "920646d21132c1f76cb077c72ef9d1eba81e6409b8bdb51d82e8ea391439a33e" "61dde410fce3f36ff4fd7864225387b145bd249f52f7a08e7bd04e42c0c2c40b" "5bcaeefee593e5197d48b1dcbce279cb8f9452436329f0bce12fb92679cd4b34" "4f87f2f541e36b9c02d27b52824739003a322fdee06113b558d07216f3363517" "57ebf11644c4b38c04cd21ad074fe103f48cd2275b70b6f08e9bd2c160f5bfeb" "8dbc1da0cd5c532b867b5dc36a1dd7f0c0a1b93faf502ce41b990e4eea478b30" "6868ab8fcffd93b16fe736f838a7182c2f72bf51480bd279af7c26b8126aabe6" "965a9379c46f6d3f529e802189d40a0a3609adafeac30efed96094efaa5c7156" "2fd7cca461e81f3e55a5cf503f938ada99f01bff39a41bd084ff80038fe8fe12" "cab317d0125d7aab145bc7ee03a1e16804d5abdfa2aa8738198ac30dc5f7b569" "cc0dbb53a10215b696d391a90de635ba1699072745bf653b53774706999208e3" "39dd7106e6387e0c45dfce8ed44351078f6acd29a345d8b22e7b8e54ac25bac4" "196df8815910c1a3422b5f7c1f45a72edfa851f6a1d672b7b727d9551bb7c7ba" "a62f0662e6aa7b05d0b4493a8e245ab31492765561b08192df61c9d1c7e1ddee" "b3bcf1b12ef2a7606c7697d71b934ca0bdd495d52f901e73ce008c4c9825a3aa" "12670281275ea7c1b42d0a548a584e23b9c4e1d2dabb747fd5e2d692bcd0d39b" "8150ded55351553f9d143c58338ebbc582611adc8a51946ca467bd6fa35a1075" "0daf22a3438a9c0998c777a771f23435c12a1d8844969a28f75820dd71ff64e1" "2ae4b0c50dd49a5f74edeae3e49965bf8853954b63c5712a7967ea0a008ecd5b" "8d5f22f7dfd3b2e4fc2f2da46ee71065a9474d0ac726b98f647bc3c7e39f2819" "44247f2a14c661d96d2bff302f1dbf37ebe7616935e4682102b68c0b6cc80095" "ff79b206ad804c41a37b7b782aca44201edfa8141268a6cdf60b1c0916343bd4" "9d9fda57c476672acd8c6efeb9dc801abea906634575ad2c7688d055878e69d6" "2c88b703cbe7ce802bf6f0bffe3edbb8d9ec68fc7557089d4eaa1e29f7529fe1" "cd736a63aa586be066d5a1f0e51179239fe70e16a9f18991f6f5d99732cabb32" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "3a3de615f80a0e8706208f0a71bbcc7cc3816988f971b6d237223b6731f91605" "0cd56f8cd78d12fc6ead32915e1c4963ba2039890700458c13e12038ec40f6f5" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "946e871c780b159c4bb9f580537e5d2f7dba1411143194447604ecbaf01bd90c" "08a89acffece58825e75479333109e01438650d27661b29212e6560070b156cf" "26d49386a2036df7ccbe802a06a759031e4455f07bda559dcf221f53e8850e69" "e61752b5a3af12be08e99d076aedadd76052137560b7e684a8be2f8d2958edc3" "13d20048c12826c7ea636fbe513d6f24c0d43709a761052adbca052708798ce3" "93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" "086970da368bb95e42fd4ddac3149e84ce5f165e90dfc6ce6baceae30cf581ef" "0e0c37ee89f0213ce31205e9ae8bce1f93c9bcd81b1bcda0233061bb02c357a8" "ecba61c2239fbef776a72b65295b88e5534e458dfe3e6d7d9f9cb353448a569e" "f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "b181ea0cc32303da7f9227361bb051bbb6c3105bb4f386ca22a06db319b08882" "3eb93cd9a0da0f3e86b5d932ac0e3b5f0f50de7a0b805d4eb1f67782e9eb67a4" "a566448baba25f48e1833d86807b77876a899fc0c3d33394094cf267c970749f" default))
 '(display-time-mode t)
 '(elpy-modules
   '(elpy-module-company elpy-module-eldoc elpy-module-highlight-indentation elpy-module-sane-defaults))
 '(fci-rule-color "#56697A" t)
 '(flycheck-error-list-minimum-level 'warning)
 '(golden-ratio-mode nil)
 '(helm-ff-lynx-style-map nil)
 '(ivy-height 20)
 '(jdee-db-active-breakpoint-face-colors (cons "#10151C" "#5EC4FF"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#10151C" "#8BD49C"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#10151C" "#384551"))
 '(lsp-enable-eldoc nil)
 '(lsp-enable-snippet nil)
 '(lsp-enable-xref t)
 '(lsp-highlight-symbol-at-point t)
 '(lsp-pyls-server-command '("/raid_sdc/home/ntr/anaconda3/envs/py2pt1.0/bin/pyls"))
 '(lsp-ui-doc-border "MediumPurple1")
 '(lsp-ui-doc-enable t)
 '(lsp-ui-doc-max-height 10)
 '(lsp-ui-doc-max-width 50)
 '(lsp-ui-flycheck-enable nil)
 '(lsp-ui-peek-enable t)
 '(lsp-ui-sideline-enable t)
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(package-selected-packages
   '(dumb-jump undo-tree lsp-pyright ccls emacs-ccls hydra leetcode helm-ag realgud-ipdb dap-mode evil-smartparens company-insert-selected company-jedi ggtags auto-complete flycheck json-mode buffer-expose lispyville lentic forge parrot flymake-diagnostic-at-point annotate cyberpunk-theme ranger symbol-overlay keyfreq eyebrowse expand-region god-mode gruvbox-theme ob-ipython ace-jump-zap evil-terminal-cursor-changer evil-org htmlize color-theme-approximate ivy swiper beacon ace-jump-mode zone-rainbow evil-vimish-fold linum-relative org-download writeroom-mode typing-game evil-goggles tao-theme quasi-monochrome-theme minimal-theme monochrome-theme evil-mc iedit smartscan evil-collection workgroups realgud yaml-mode elfeed ycm dracula-theme markdown-mode+ symon latex-pretty-symbols macrostep academic-phrases company-statistics dashboard multi-term golden-ratio company-anaconda anaconda-mode airline-themes powerline-evil doom-themes neotree helm projectile evil ace-jump-buffer replace-pairs which-key try use-package))
 '(pdf-tools-handle-upgrades nil)
 '(pdf-view-midnight-colors '("#ffffff" . "#222222"))
 '(pixel-scroll-mode nil)
 '(pyim-dicts '((:name "pyim-bigdict" :file ss-bigdict-path)))
 '(pyim-page-length 8)
 '(tool-bar-mode nil)
 '(vc-annotate-background "#1D252C")
 '(vc-annotate-color-map
   (list
    (cons 20 "#8BD49C")
    (cons 40 "#a1c9a1")
    (cons 60 "#bcbc94")
    (cons 80 "#EBBF83")
    (cons 100 "#d7a179")
    (cons 120 "#d7946c")
    (cons 140 "#D98E48")
    (cons 160 "#d7876c")
    (cons 180 "#d78779")
    (cons 200 "#E27E8D")
    (cons 220 "#d77979")
    (cons 240 "#d76c6c")
    (cons 260 "#D95468")
    (cons 280 "#a15f5f")
    (cons 300 "#6b5f5f")
    (cons 320 "#355f5f")
    (cons 340 "#56697A")
    (cons 360 "#56697A")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0 :color "blue"))))
 '(ivy-current-match ((t (:background "#666"))))
 '(lsp-ui-sideline-symbol ((t (:background "color-27" :foreground "grey" :box (:line-width -1 :color "grey") :height 0.99))))
 '(lsp-ui-sideline-symbol-info ((t (:background "color-27" :slant italic :height 0.99))))
 '(swiper-match-face-2 ((t (:background "#666" :foreground "black" :weight bold)))))
