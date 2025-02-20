(add-to-list 'load-path "~/.config/emacs/lisp/")

; add packages with settings
(require 'ps)
(use-package evil
  :ensure t (:wait t)
  :demand t
  :init
  (setq evil-want-keybinding nil)
  (evil-mode 1))

(use-package consult
  :ensure t (:wait t)
  :demand t
  :bind (
		 ("C-x b" . consult-buffer)
		 ("M-s g" . consult-ripgrep))
  :init
  (setq register-preview-delay 0)
  (setq xref-show-xrefs-function #'consult-xref
		xref-show-definitions-function #'consult-xref)
  )

(use-package vertico
  :ensure t (:wait t)
  :bind (:map vertico-map
			  ("C-j" . vertico-next)
			  ("C-k" . vertico-previous)
			  :map minibuffer-local-map
			  ("C-h" . backward-kill-word))
  :init
  (vertico-mode 1))
(use-package marginalia
  :ensure t (:wait t)
  :demand t
  :init
  (marginalia-mode 1))
(use-package orderless
  :ensure t (:wait t)
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (style basic partial-completion)))))

(use-package transient
  :ensure t (:wait t))
(use-package magit 
  :ensure t (:wait t))
(use-package evil-collection
  :ensure t (:wait t)
  :after evil
  :init
  (setq evil-want-keybinding nil)
  (evil-collection-init))
(use-package fzf
  :ensure t
  (:wait t)
  :bind (
		 ("C-x C-f" . fzf)
		 ("C-x C-d" . fzf-grep-dwim)
		 ("C-x C-g" . fzf-grep))
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
	fzf/executable "fzf"
	fzf/grep-command "rg --no-heading -nH"
	fzf/position-bottom t
	fzf/window-height 15))

(use-package gruvbox-theme
  :ensure t (:wait t)
  :demand t
  :init
  (load-theme 'gruvbox t)
  )

;; add options related
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ;no more esc spamming
(global-display-line-numbers-mode 1)
(setq-default display-line-numbers-type 'relative
	      display-line-numbers-width 3
	      )
(setq-default tab-width 4
	      ident-tabs-mode nil)

;; add theme related
(setq inhibit-startup-message t)

(menu-bar-mode -1) ;no more bar bullshit
(tool-bar-mode -1)
(scroll-bar-mode -1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7b8f5bbdc7c316ee62f271acf6bcd0e0b8a272fdffe908f8c920b0ba34871d98" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
