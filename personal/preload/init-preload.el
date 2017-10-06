;;; init.el -- my emacs config
;;; Commentary:
;;; byte-compile-warnings: (not free-vars)
;;; Code:

(with-no-warnings
  (require 'cl))

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(provide 'init-preload)
