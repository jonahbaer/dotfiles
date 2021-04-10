(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#262221" "#e84c58" "#91f368" "#eed891" "#41b0f3" "#cea2ca" "#6bd9db" "#eee6d3"])
 '(custom-safe-themes
   '("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default))
 '(newsticker-url-list
   '(("Slashdot" "http://rss.slashdot.org/Slashdot/slashdotMain" nil nil nil)
     ("Arch Linux" "https://archlinux.org/feeds/news/" nil nil nil)
     ("FiveThirtyEight" "https://fivethirtyeight.com/all/feed" nil nil nil)))
 '(org-agenda-files
   '("~/Documents/notes/misc.org" "~/Documents/school/school.org"))
 '(package-selected-packages
   '(zenburn-theme racket-mode kaolin-themes smart-mode-line helm-themes fish-mode helm-lsp helm all-the-icons-dired org-superstar popwin lsp-treemacs projectile helpful dashboard ace-jump-mode rustic go-mode all-the-icons magit aggressive-indent smartparens company-lsp nlinum-relative ccls rainbow-delimiters markdown-mode which-key company flycheck lsp-ui lsp-mode use-package))
 '(pos-tip-background-color "#2E2A29")
 '(pos-tip-foreground-color "#d4d4d6"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


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

;; when writing any kind of text
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'auto-fill-mode)

;; when writing code
(add-hook 'prog-mode-hook 'which-function-mode)

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
(setq org-startup-indented t)
(add-to-list 'org-modules 'org-habit)

;; use-package
(eval-when-compile
  (require 'use-package))

(use-package zenburn-theme
  :init
  (setq zenburn-use-variable-pitch t
	zenburn-scale-org-headlines t
	zenburn-scale-outline-headlines t)
  :config
  (load-theme 'zenburn t))

(use-package smart-mode-line
  :init
  (setq sml/theme 'respectful)
  :config
  (sml/setup))

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
  :config
  (helm-mode)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-x b") 'helm-buffers-list)
  (global-set-key (kbd "C-x r b") 'helm-bookmarks)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring))

(use-package popwin
  :config
  (popwin-mode 1))

(use-package treemacs
  :config
  ;; (require 'treemacs-all-the-icons)
  ;; (treemacs-load-theme "all-the-icons")
  (global-set-key (kbd "<f5>") 'treemacs))

(use-package all-the-icons)

(use-package all-the-icons-dired
  :init
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package smartparens
  :config
  (smartparens-global-mode))

(use-package aggressive-indent
  :hook
  (emacs-lisp-mode . aggressive-indent-mode)
  (scheme-mode . aggressive-indent-mode))

(use-package ace-jump-mode
  :config
  (autoload
    'ace-jump-mode
    "ace-jump-mode"
    "emacs quick move minor mode"
    t)
  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode))

(use-package nlinum-relative
  :hook (prog-mode . nlinum-relative-mode))

(use-package org-superstar
  :config (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))

(use-package helpful
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

(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map))

(use-package company)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package lsp-mode
  :hook (
	 (python-mode . lsp)
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
	lsp-keymap-prefix "s-l")
  (setq lsp-modeline-code-actions-segments '(count icon name))

  (use-package lsp-ui
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
	  lsp-ui-doc-position 'bottom))

  (use-package helm-lsp :commands helm-lsp-workspace-symbol)
  
  (use-package lsp-treemacs :commands lsp-treemacs-errors-list)

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
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
	 (lambda () (require 'ccls) (lsp))))

(use-package rustic)

(use-package go-mode)

(use-package racket-mode
  :hook (scheme-mode . racket-mode))

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
  :config
  (which-key-mode))
