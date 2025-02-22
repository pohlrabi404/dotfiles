(setq doom-font
      (font-spec
       :family "FiraCode Nerd Font"
       :size 14
       :weight 'light))

(setq doom-theme 'doom-gruvbox)

(setq display-line-numbers-type 'relative)
(setq org-directory "~/org/")

(use-package! org-auto-tangle
  :defer t
  :init
  (setq org-auto-tangle-default t)
  (setq org-hide-emphasis-markers t)
  :hook (org-mode . org-auto-tangle-mode))

(use-package! org-bullets
  :config
  (add-hook! org-mode (lambda () (org-bullet-mode 1)) ))

(use-package! fzf
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        fzf/grep-command "rg --no-heading -nH"
        fzf/position-bottom t
        fzf/window-height 30))

(use-package! centered-cursor-mode
  :config
  (global-centered-cursor-mode))
