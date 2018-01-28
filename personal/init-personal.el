;;; init.el -- my emacs config
;;; Commentary:
;;; byte-compile-warnings: (not free-vars)
;;; Code:


(with-no-warnings
  (require 'cl))

(setq message-log-max 10000)
(global-set-key  (kbd "C-c c") 'org-capture)
;;; Package management

;; Please don't load outdated byte code
(setq load-prefer-newer t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)
(setq org-agenda-files '("~/org/tasks.org" "~/org/life.org"))

(require 'ein)
(require 'ein-loaddefs)
(require 'ein-notebook)
(require 'ein-subpackages)

(setq ns-function-modifier 'hyper)  ; make Fn key do Hyper

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq inhibit-startup-message t)
(column-number-mode t)
(delete-selection-mode 1)
(show-paren-mode t)
;; (global-linum-mode 1)

(tool-bar-mode -1)

(when (eq system-type 'darwin)
  (setq mac-option-modifier 'control) ; was alot
  (setq mac-command-modifier 'meta)
  (setq ns-function-modifier 'alt) ;fn is control -- was control
  )

;;; smooth scroll
(setq scroll-conservatively 10000)

(setq scroll-margin 3)

;; prevent mouse scrolling from sucking ass
(setq mouse-wheel-scroll-amount '(0.07))
(setq mouse-wheel-progressive-speed nil)

;; turn the friggan beep noise off!
(setq ring-bell-function 'ignore)

;; Emacs will not automatically add new lines
(setq next-line-add-newlines nil)

;; prevent too much line wrapping...
'(fill-column 1000)

;; allow narrowing
(put 'narrow-to-region 'disabled nil)

;; way to similar to exit emacs, unbind it
(global-unset-key (kbd "C-x c"))
;; Too similar to projectile find file, so unbind it
(global-unset-key (kbd "C-c C-p"))
;; y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "H-.") 'mc/mark-next-like-this)
(global-set-key (kbd "H-,") 'mc/mark-prev-like-this)
(global-set-key (kbd "H-a") 'mc/mark-all-like-this)
;; font for all unicode characters
(set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)

(setq company-global-modes '(not org-mode term-mode magit-mode Magit))
(setq org-agenda-include-diary t)

(global-set-key (kbd "C-;") 'other-frame)

;; helm
(use-package init-helm-vig
  :load-path "elisp"
  )

;; magit
(use-package init-magit-vig
  :load-path "elisp")

;; various functions & key bindings
(use-package init-fnkeys-vig
  :load-path "elisp")

;; winner
(use-package winner
  :ensure t
  :defer t
  :init
  (winner-mode 1))

;; ace-window
(use-package ace-window
  :ensure t
  :defer t
  :bind (("C-'" . ace-window)))

;; undo tree
(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :init
  (global-undo-tree-mode)
  :config
  (progn
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t))
  :bind (("C-x C-u" . undo-tree-visualize)
         ("C-z" . undo-tree-undo)
         ("M-z" . undo-tree-redo)
         )
  )

(use-package csharp-mode
  :mode "\\.cs$"
  :load-path "elisp"
  :init
  (progn
    (require 'flymake)
    (add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))
    ))

(use-package nyan-mode
  :if window-system
  :ensure t
  :config
  (nyan-mode)
  (nyan-start-animation)
  )

(use-package powerline
  :ensure t
  :config
  (powerline-default-theme))

(use-package dumb-jump
  :ensure t
  :config
  (progn
    (defun dumb-jump-go-autosave ()
      "Save before calling dump-jump-go."
      (interactive)
      (save-buffer)
      (dumb-jump-go)
      (recenter-top-bottom)
      )
    )
  :bind ( ("M-." . dumb-jump-go-autosave)
          ("M-," . dumb-jump-go-back))
  )


(use-package multiple-cursors                    ; multiple cursors
  :ensure t
  :bind ( ("C->" . mc/mark-next-like-this)
          ("C-<" . mc/mark-previous-like-this)
          ("C-c C-<" . mc/mark-all-like-this)))

(use-package expand-region                    ; expand-region
  :ensure t
  :bind ( ("<C-return>" . er/expand-region)))



(use-package dark-mint-theme
  :ensure t
  )

(use-package linum-relative
  :ensure t
  :config
  (linum-on))

;; (load-theme 'dark-mint t)

(disable-theme 'zenburn)
(setq prelude-theme 'dark-mint)

(set-face-background 'hl-line "#3e4446") ;make cursor line work like I want it to!
(set-face-foreground 'highlight nil)

(linum-relative-global-mode)            ;; turn put relative linum mode on

(require 'prelude-helm-everywhere)
(require 'prelude-key-chord)
(require 'key-chord)

(key-chord-define-global "pf" 'projectile-find-file)
(key-chord-define-global ";b" 'helm-mini)
(key-chord-define-global "pb" 'helm-projectile-switch-to-buffer)

(setq prelude-flyspell nil)
(setq prelude-whitespace nil)

(defun run-python-once ()
  (remove-hook 'python-mode-hook 'run-python-once)
  (run-python (python-shell-parse-command)))

(add-hook 'python-mode-hook 'run-python-once)


(provide 'init-personal)
