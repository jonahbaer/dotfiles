;; Set up melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; setup for exwm mode (emacs as a window manager)
(require 'exwm)
(require 'exwm-randr)
(setq exwm-randr-workspace-output-plist '(0 "DP-0" 1 "DVI-D-0"))
(shell-command "xrandr --output DVI-D-0 --mode 1600x900 --output DP-0 --mode 1920x1080 --rate 144 --right-of DVI-D-0")
(exwm-randr-enable)
(require 'exwm-systemtray)
(exwm-systemtray-enable)
(require 'exwm-config)
(exwm-config-default)


;; set save directory
(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))

;; disable toobar, and scrollbar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(display-time-mode t)

;; use this one weird trick to fix window resizing
(setq frame-resize-pixelwise t)

;; font, cursor
(add-to-list 'default-frame-alist '(font . "Hack 11"))
(setq-default cursor-type 'bar)

;; when writing any kind of text
(add-hook 'text-mode-hook 'flyspell-mode)

;; some settings for elisp
(add-hook 'emacs-lisp-mode-hook 'company-mode)

;; some settings for c lang
(setq c-default-stype "k&r"
      c-basic-offset 4
      tab-width 4
      indent-tabs-mode t)
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))

;; some settings for rust lang
(add-hook 'rust-mode-hook
	  (lambda () (setq indent-tabs-mode nil)))

;; some settings for org-mode
(setq org-startup-indented t)

;; use-package
(eval-when-compile
  (require 'use-package))

;; This is for nurds
;; (use-package evil
;;   :config
;;   (evil-mode 1))

(use-package doom-themes
  :config (setq doom-themes-enable-bold t
		doom-themes-enable-italic t)
  (load-theme 'doom-vibrant t)
  (doom-themes-visual-bell-config)
  (setq doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package solaire-mode
  :hook (after-init . solaire-global-mode))

(use-package treemacs
  :config
  (global-set-key (kbd "<f5>") 'treemacs))

(use-package all-the-icons
  :init

  (use-package all-the-icons-ivy-rich
    :ensure t
    :init (all-the-icons-ivy-rich-mode 1))

  (use-package ivy-rich
    :ensure t
    :init (ivy-rich-mode 1)))

(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package smartparens
  :config
  (smartparens-global-mode))

(use-package aggressive-indent
  :config
  (global-aggressive-indent-mode 1)
  ;; (add-to-list 'aggressive-indent-excluded-modes) <- use this to stop aggressive-indent from running in certain modes
)

(use-package nlinum-relative
  :config
  ;; (nlinum-relative-setup-evil)
  (add-hook 'prog-mode-hook 'nlinum-relative-mode)
  (setq nlinum-relative-redisplay-delay 0.1))

(use-package vterm
  :ensure t
  :config
  (setq vterm-shell 'fish))

(use-package geiser
  :config
  (setq geiser-active-implementations '(mit)))

(use-package counsel
  :config
  (counsel-mode))

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
	lsp-completion-provider :capf
	lsp-keymap-prefix "s-l")

  (use-package lsp-ui :commands lsp-ui-mode)

  (use-package lsp-ivy :commands lsp-ivy-workspace-symbol))

(use-package ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
	 (lambda () (require 'ccls) (lsp))))

(use-package rustic)

(use-package ess-r-mode)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc --pdf-engine=xelatex")
  :config (setq tab-width 4
		indent-tabs-mode t)
  (company-mode 0))

(use-package which-key
  :config
  (which-key-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("0c6a36393d5782839b88e4bf932f20155cb4321242ce75dc587b4f564cb63d90" default))
 '(newsticker-url-list
   '(("Arch Linux" "https://archlinux.org/feeds/news/" nil nil nil)
     ("FiveThirtyEight" "https://fivethirtyeight.com/all/feed" nil nil nil)))
 '(org-agenda-files '("~/Documents/school/school.org"))
 '(package-selected-packages
   '(rustic solaire-mode doom-modeline doom-themes ess exwm vterm go-mode treemacs-magit treemacs-icons-dired treemacs-all-the-icons all-the-icons-ivy-rich treemacs all-the-icons magit aggressive-indent smartparens geiser company-lsp nlinum-relative ccls rainbow-delimiters markdown-mode counsel which-key lsp-ivy ivy company flycheck lsp-ui lsp-mode evil use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
