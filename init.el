;; -*- Emacs-Lisp -*-

;; Use cl
(require 'cl)

;; Packaging junk
(eval-after-load "package"
  '(progn
     (add-to-list 'package-archives
                  '("marmalade" . "http://marmalade-repo.org/packages/") t)))

;; Resize the window to fit vertically on the screen and have 87 columns
(setq my-frame-width 87)
(setq my-frame-height (if window-system
                          (/ (- (x-display-pixel-height) 60)
                                           (frame-char-height))
                        60))
(setq default-frame-alist `((width . ,my-frame-width) (height . ,my-frame-height)))

;; Set yas/root-directory after yasnippet is loaded
(eval-after-load "yasnippet"
  '(progn
     (setq yas/root-directory '("~/Code/Projects/snippets"))))

;; Removing mention of a few minor modes in the modeline
(eval-after-load "diminish"
  '(progn
     (diminish 'wrap-region-mode)
     (diminish 'yas/minor-mode)))

;; Adding $HOME/info as an infodir, if it exists

;; (let ((infodir (format "%s/info" (getenv "HOME"))))
;;   (if (file-accessible-directory-p infodir)
;;       (add-to-list 'Info-directory-list infodir)))

;; Set SBCL as our CL implementation for Slime
;; (setq inferior-lisp-program "sbcl")
;; (add-to-list 'load-path "~/.emacs.d/slime")
;; ;;(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; (require 'slime)
(setq inferior-lisp-program "sbcl")

;; Set my email address
(setq user-mail-address "tensorpuddin@devio.us")

;; Start the server
(server-start)

;; Set up the custom file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)
