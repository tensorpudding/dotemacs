-*- Mode: Emacs-Lisp -*-
(add-to-list 'load-path "~/.emacs.d")
(load-theme 'solarized-dark)
(enable-theme 'solarized-dark)

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(defun set-frame-size-by-resolution ()
  (interactive)
  (if window-system
      (progn
	(add-to-list 'default-frame-alist (cons 'width 90))
	(add-to-list 'default-frame-alist 
		     (cons 'height (/ (- (x-display-pixel-height) 60)
				      (frame-char-height)))))))

(set-frame-size-by-resolution)

(defun turn-on-line-numbering ()
  (interactive)
  (linum-mode 1)
  (setq linum-format "%5d "))

(add-hook 'prog-mode-hook 'turn-on-line-numbering)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("0174d99a8f1fdc506fa54403317072982656f127" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
