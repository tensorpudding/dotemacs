(add-to-list 'load-path "~/.emacs.d")

;; Packaging junk
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

;; The packages we need
(defvar upstream-packages '(auctex clojure-mode go-mode haskell-mode
                                   ido-ubiquitous idle-highlight
                                   idle-highlight-mode magit paredit projectile
                                   scala-mode scpaste slime slime-repl smex
                                   undo-tree vala-mode yasnippet))

(defmacro with-shell-command (command out-buffer errmessage)
  `(if (not (eq (call-process-shell-command ,command nil ,out-buffer) 0))
       (message ,errmessage)
     (switch-to-buffer ,out-buffer)))

(defun my-install-file (package)
  (with-demoted-errors
    (package-install-file package)))

;; Set up emacs for us, with all the packages we want.
(defun setup-emacs ()
  (interactive)
  ;; Update package definitions
  (message "Updating package archives...")
  (when (not package-archive-contents)
    (package-refresh-contents))
  ;; First install the upstream packages mentioned before.
  (dolist (p upstream-packages)
    (when (not (package-installed-p p))
      (message "Installing package %s" p)
      (my-install-file p)))
  ;; Fetch e-s-k if it's not there
  (let ((logbuf (get-buffer-create "*emacs-setup-log*")))
    (cd "~/.emacs.d/")
    (if (not (file-exists-p "~/.emacs.d/emacs-starter-kit"))
        (progn (message "Cloning emacs-starter-kit...")
               (with-shell-command "git clone -b v2 git://github.com/tensorpudding/emacs-starter-kit.git" logbuf "Error cloning emacs-starter-kit")))
    (cd "~/.emacs.d/emacs-starter-kit")
    ;; Pull the latest revision and tar it up
    (message "Pulling latest version of emacs-starter-kit...")
    (with-shell-command "git pull" logbuf "Error pulling changes.")
    (message "Creating package tarball...")
    (cd "~/.emacs.d/emacs-starter-kit")
    (if (file-exists-p "~/.emacs.d/emacs-starter-kit/starter-kit-2.0.3")
        (delete-directory "~/.emacs.d/emacs-starter-kit/starter-kit-2.0.3" t))
    (if (file-exists-p "~/.emacs.d/emacs-starter-kit/starter-kit-2.0.3.tar")
        (delete-file "~/.emacs.d/emacs-starter-kit/starter-kit-2.0.3.tar"))
    (with-shell-command "bash tar.sh 2.0.3" logbuf "Error creating tarball.")
    (my-install-file "~/.emacs.d/emacs-starter-kit/starter-kit-2.0.3.tar")
    ;; Now install all the modules
    (message "Installing modules...")
    (let ((esk-modules (directory-files "modules" t "\\.el$")))
      (dolist (p esk-modules)
        (with-demoted-errors (my-install-file p))))))

;; Resize the window to fit vertically, and have 87 vertical columns
(defun set-frame-size-by-resolution ()
  (interactive)
  (if window-system
      (progn
	(add-to-list 'default-frame-alist (cons 'width 87))
	(add-to-list 'default-frame-alist 
		     (cons 'height (/ (- (x-display-pixel-height) 60)
				      (frame-char-height)))))))

(set-frame-size-by-resolution)

;; Set yas/root-directory
(setq yas/root-directory '("~/Code/Projects/snippets"))

;; Set SBCL as our CL implementation for Slime
;; (setq inferior-lisp-program "sbcl")
;; (add-to-list 'load-path "~/.emacs.d/slime")
;; ;;(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; (require 'slime)
(setq inferior-lisp-program "sbcl")

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
 '(foreground-color "#708183")
 '(scheme-program-name "racket")
 '(send-mail-function (quote sendmail-send-it)))
