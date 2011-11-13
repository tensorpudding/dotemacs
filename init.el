(add-to-list 'load-path "~/.emacs.d")

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(defun set-frame-size-by-resolution ()
  (interactive)
  (if window-system
      (progn
	(add-to-list 'default-frame-alist (cons 'width 85))
	(add-to-list 'default-frame-alist 
		     (cons 'height (/ (- (x-display-pixel-height) 60)
				      (frame-char-height)))))))

(set-frame-size-by-resolution)

;; Set yas/root-directory
(setq yas/root-directory '("~/Code/Projects/snippets"))

;; Start the server
(server-start)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(background-color "#042028")
 '(background-mode dark)
 '(c-default-style (quote ((c++-mode . "stroustrup") (java-mode . "java") (awk-mode . "awk") (other . "gnu"))))
 '(column-number-mode t)
 '(cursor-color "#708183")
 '(custom-enabled-themes (quote (adwaita)))
 '(custom-safe-themes (quote ("5f5644eaf825f7ef4a7f8137540821a3a2ca009e" "e74544a27828e83ae2fc825cd77b7a2c6490a733" "5600dc0bb4a2b72a613175da54edb4ad770105aa" "a22ec513302bbedd659ec3571ca9911b12f7ebe7" "f8f89bc6e899f305cb9766d15bb02205eb462528" "ca7fdd2df444433d6f6097a5b5c24d8949c546a3" "0174d99a8f1fdc506fa54403317072982656f127" default)))
 '(fill-column 70)
 '(foreground-color "#708183"))
