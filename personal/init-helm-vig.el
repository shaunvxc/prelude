;;; init-helm-vig.el --- My startup file for helm. -*- lexical-binding: t -*-
;;; Code:
;;; Commentary:
;;; Load all autoloads for helm and its extensions
;;

(use-package helm-swoop
  :ensure t
  :init
  (progn
    (setq helm-swoop-speed-or-color t)
    ;; Disable pre-input
    (setq helm-swoop-pre-input-function
          (lambda () ""))
    )
  :config
  (define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
  (define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)
  ;; (let (($map (make-sparse-keymap)))
  ;;   (set-keymap-parent $map helm-map)
  ;;   (define-key $map (kbd "C-c C-e") 'helm-swoop-edit)
  ;;   (define-key $map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
  ;;   (define-key $map (kbd "C-s") 'helm-swoop-yank-thing-at-point)
  ;;   (define-key $map (kbd "^") 'helm-swoop-caret-match)
  ;;   (delq nil $map))
  )

(use-package helm-config)

(defun my-helm-grep-do-git-grep (not-all)
  (interactive "P")
  (helm-grep-git-1 default-directory (null not-all)))


(use-package helm
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (setq helm-locate-command "mdfind -name %s %s")
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
          helm-input-idle-delay 0.01               ; this actually updates things reeeelatively quickly.
	  helm-split-window-in-side-p            t ; open helm buffer inside current window, not occupy whole other window
	  helm-move-to-line-cycle-in-source      t ; move to end or beginning of source when reaching top or bottom of source.
	  helm-ff-search-library-in-sexp         t ; search for library in `require' and `declare-function' sexp.
	  helm-scroll-amount                     8 ; scroll 8 lines other window using M-<next>/M-<prior>
	  helm-candidate-number-limit            100
          helm-quick-update                      t
	  helm-swoop-split-direction             'split-window-vertically
	  helm-swoop-split-with-multiple-windows t
	  )
    (helm-mode))
  :config
  ;; (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))

  (setq helm-ff-skip-boring-files t) ;; and this one
  (setq helm-ff-file-name-history-use-recentf t) ;; and this one
  :bind (("C-c h" . helm-command-prefix)
         ("M-i" . helm-multi-swoop-all)
         ("C-s" . helm-swoop)
	 ;; ("M-i" . helm-swoop-back-to-last-point)
	 ;; ("C-c M-i" . helm-multi-swoop)
	 ;; ("C-x M-i" . helm-multi-swoop-all)
	 ;; ("C-M-i" . helm-multi-swoop-all)
         ("C-0" . my-helm-grep-do-git-grep)
	 ("C-x C-f" . helm-find-files)
	 ("C-x C-b" . switch-to-buffer)
         ("C-h a" . helm-apropos)
         ("C-x C-b" . helm-buffers-list)
         ("C-x b" . helm-buffers-list)
         ("M-y" . helm-show-kill-ring)
         ("M-x" . helm-M-x)
         ("C-x c o" . helm-occur)
         ("C-x c s" . helm-swoop)
         ("C-x f" . helm-for-files)
         ("C-x c y" . helm-yas-complete)
	 ("C-x c SPC" . helm-all-mark-rings)))

(use-package helm-adaptive
  :config (helm-adaptive-mode 1))

(provide 'init-helm-vig)
;;; init-helm-vig.el ends here




