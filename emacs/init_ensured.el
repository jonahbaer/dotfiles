(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2D2A2E" "#e84c58" "#91f368" "#eed891" "#41b0f3" "#cea2ca" "#6bd9db" "#eee6d3"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-safe-themes
   '("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default))
 '(fci-rule-color "#383838")
 '(newsticker-url-list
   '(("Slashdot" "http://rss.slashdot.org/Slashdot/slashdotMain" nil nil nil)
     ("Arch Linux" "https://archlinux.org/feeds/news/" nil nil nil)
     ("FiveThirtyEight" "https://fivethirtyeight.com/all/feed" nil nil nil)))
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(org-agenda-files
   '("~/Documents/notes/misc.org" "~/Documents/school/school.org"))
 '(org-format-latex-options
   '(:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
		 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(package-selected-packages
   '(solaire-mode doom-themes vterm elpy doom-modeline racket-mode helm-themes fish-mode helm-lsp helm org-superstar popwin lsp-treemacs projectile helpful dashboard rustic go-mode all-the-icons magit aggressive-indent smartparens company-lsp nlinum-relative ccls rainbow-delimiters markdown-mode which-key company flycheck lsp-ui lsp-mode use-package))
 '(pos-tip-background-color "#2E2A29")
 '(pos-tip-foreground-color "#d4d4d6")
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-document-title ((t (:foreground "#78DCE8" :underline t :weight bold :height 2.0))))
 '(org-level-1 ((t (:inherit outline-1 :extend nil :weight bold :height 1.5))))
 '(org-level-2 ((t (:inherit outline-2 :extend nil :weight bold :height 1.3)))))


;; Set up melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; set save directory
(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))

;; disable toobar, and scrollbar
(tool-bar-mode -1)
;; (menu-bar-mode -1)
(scroll-bar-mode -1)
(display-time-mode t)

;; use this one weird trick to fix window resizing
(setq frame-resize-pixelwise t)
(setq pixel-scroll-mode t)

;; font, cursor
(add-to-list 'default-frame-alist '(font . "Hack 11"))
;; (setq-default cursor-type 'bar)

;; show trailing whitespace
(setq-default show-trailing-whitespace t)

;; when writing any kind of text
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'auto-fill-mode)

;; when writing code
;; (add-hook 'prog-mode-hook 'which-function-mode)

;; some settings for elisp
(add-hook 'emacs-lisp-mode-hook 'company-mode)

;; some settings for c lang
;; (setq c-default-style "k&r"
;;       c-basic-offset 4
;;       tab-width 4
;;       indent-tabs-mode t)
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))

;; some settings for org-mode
(require 'org)
(setq org-startup-indented t
      org-list-allow-alphabetical t
      org-ellipsis "⮷"
      org-startup-with-latex-preview t
      org-hide-emphasis-markers t)
(add-to-list 'org-modules 'org-habit)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

(setq org-default-notes-file "~/Documents/notes/notes.org")
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Documents/notes/gtd.org" "Tasks")
	 "* TODO %?\n  %i\n  %a")
	("T" "Todo (no context link)" entry (file+headline "~/Documents/notes/gtd.org" "Tasks")
	 "* TODO %?\n %i\n")
	("j" "Journal" entry (file+datetree "~/Documents/notes/journal.org")
	 "* %?\nEntered on %U\n  %i\n  %a")
	("J" "Journal (no context link)" entry (file+datetree "~/Documents/notes/journal.org")
	 "* %?\nEntered on %U\n  %i\n")))

;; use-package
;; configuration macros to simplify emacs config
(eval-when-compile
  (require 'use-package))

(use-package vterm
  :ensure t
  :init
  (setq vterm-shell "/bin/fish"))

(use-package doom-themes
  :ensure t
  :init
  (use-package doom-modeline
  :ensure t
    :hook (after-init . doom-modeline-mode))

  (use-package solaire-mode
  :ensure t
    :hook (after-init . solaire-global-mode))

  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t
	doom-themes-treemacs-theme "doom-colors")

  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(use-package dashboard
  :ensure t
  :config
  (setq dashboard-banner-logo-title "Welcome to (GNU) Emacs: An extensible, customizable, free/libre text editor - and more."
	dashboard-startup-banner 'logo
	dashboard-set-heading-icons t
	dashboard-set-file-icons t
	dashboard-center-content t
	dashboard-projects-backend 'projectile
	dashboard-items '((recents . 5)
			  (bookmarks . 5)
			  (projects . 5)
			  (agenda . 5)
			  (registers . 5)))
  (dashboard-setup-startup-hook))

(use-package helm
  :ensure t
  :config
  (helm-mode)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-x b") 'helm-buffers-list)
  (global-set-key (kbd "C-x r b") 'helm-bookmarks)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring))

(use-package company-mode
  :ensure t
  :hook
  (emacs-lisp-mode . company-mode)
  (racket-mode . company-mode)
  :config
  (setq company-format-margin-function #'company-vscode-light-icons-margin))

(use-package popwin
  :ensure t
  :config
  (popwin-mode 1))

(use-package treemacs
  :ensure t
  :config
  ;; (require 'treemacs-all-the-icons)
  ;; (treemacs-load-theme "all-the-icons")
  (global-set-key (kbd "<f5>") 'treemacs))

(use-package all-the-icons)
  :ensure t

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode))

(use-package aggressive-indent
  :ensure t
  :hook
  (emacs-lisp-mode . aggressive-indent-mode)
  (scheme-mode . aggressive-indent-mode)
  (racket-mode . aggressive-indent-mode))

(use-package avy
  :ensure t
  :config
  (global-set-key (kbd "C-:") 'avy-goto-char)
  (global-set-key (kbd "C-'") 'avy-goto-char-2)
  (global-set-key (kbd "M-g f") 'avy-goto-line)
  (global-set-key (kbd "M-g w") 'avy-goto-word-1)
  (global-set-key (kbd "M-g e") 'avy-goto-word-0))

(use-package nlinum-relative
  :ensure t
  :hook (prog-mode . nlinum-relative-mode))

(use-package org-superstar
  :ensure t
  :config (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))

(use-package helpful
  :ensure t
  :config
  (setq counsel-describe-function-function #'helpful-callable)
  (setq counsel-describe-variable-function #'helpful-variable)
  (global-set-key (kbd "C-h f") #'helpful-callable)
  (global-set-key (kbd "C-h v") #'helpful-variable)
  (global-set-key (kbd "C-h k") #'helpful-key)
  (global-set-key (kbd "C-c C-d") #'helpful-at-point)
  (global-set-key (kbd "C-h F") #'helpful-function)
  (global-set-key (kbd "C-h C") #'helpful-command))

(use-package magit)
  :ensure t

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map))

(use-package company)
  :ensure t

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package lsp-mode
  :ensure t
  :hook (
	 ;; (python-mode . lsp)
	 (c-mode . lsp)
	 (rustic-mode . lsp)
	 (go-mode . lsp)
	 (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :init
  (setq company-minimum-prefix-length 1
	company-idle-delay 0.1) ;; default is 0.2
  (with-eval-after-load 'lsp-mode
    ;; :global/:workspace/:file
    (setq lsp-modeline-diagnostics-scope :workspace))
  ;; some settings to make lsp-mode work better
  (setq gc-cons-threshold 100000000
	read-process-output-max (* 1024 1024) ;; 1mb
	lsp-log-io nil
	lsp-completion-provider :capf
	lsp-keymap-prefix "s-l"
	lsp-modeline-code-actions-segments '(count icon name)
	lsp-enable-indentation t
	lsp-enable-on-type-formatting t)

  (use-package lsp-ui
  :ensure t
    :commands lsp-ui-mode
    :config
    (setq lsp-ui-sideline-show-diagnostics t
	  lsp-ui-sideline-show-hover t
	  lsp-ui-sideline-show-code-actions t
	  lsp-ui-sideline-update-mode 'line
	  lsp-ui-peek-always-show t
	  lsp-ui-peek-enable t
	  lsp-ui-peek-show-directory t
	  lsp-ui-doc-enable t
	  lsp-ui-doc-header t
	  lsp-ui-doc-use-childframe t
	  lsp-ui-doc-position 'bottom
	  lsp-ui-imenu-enable t))

  (use-package helm-lsp :commands helm-lsp-workspace-symbol)
  :ensure t

  (use-package lsp-treemacs :commands lsp-treemacs-errors-list)
  :ensure t

  ;; rust lsp
  (add-hook 'before-save-hook (lambda () (when (eq 'rustic-mode major-mode)
					   (lsp-format-buffer))))
  (setq rustic-lsp-server "rust-analyzer")

  ;; go lsp
  (defun lsp-go-install-save-hooks ()
    (add-hook 'before-save-hook #'lsp-format-buffer t t)
    (add-hook 'before-save-hook #'lsp-organize-imports t t))
  (add-hook 'go-mode-hook #'lsp-go-install-save-hooks))

(use-package ccls
  :ensure t
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
	 (lambda () (require 'ccls) (lsp))))

(use-package rustic)
  :ensure t

(use-package go-mode)
  :ensure t

(use-package racket-mode
  :ensure t
  :hook (scheme-mode . racket-mode))

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc --pdf-engine=xelatex")
  :config (setq tab-width 4
		indent-tabs-mode t
		markdown-enable-math t)
  (company-mode 0))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

