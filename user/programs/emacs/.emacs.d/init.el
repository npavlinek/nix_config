(defun running-nixos ()
  (file-exists-p "/etc/NIXOS"))

(unless (running-nixos)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (require 'use-package-ensure)
  (setq use-package-always-ensure t))

(require 'use-package)

(let ((custom-temporary-file-directory
       (concat temporary-file-directory "emacs-np/")))
  (ignore-errors
    (make-directory custom-temporary-file-directory))
  (setq custom-file (expand-file-name
                     "custom.el"
                     custom-temporary-file-directory)
        auto-save-file-name-transforms `((".*" ,custom-temporary-file-directory t))
        backup-directory-alist `(("." . ,custom-temporary-file-directory))))

(let ((coding-system 'utf-8-unix))
  (prefer-coding-system coding-system)
  (set-default-coding-systems coding-system)
  (set-terminal-coding-system coding-system)
  (set-keyboard-coding-system coding-system)
  (setq-default buffer-file-coding-system coding-system))

(defun edit-emacs-config ()
  (interactive)
  (let ((config-file
         (cond ((running-nixos) "~/src/nix_config/user/programs/emacs/.emacs.d/config.org")
               (t "~/.emacs.d/config.org"))))
    (find-file config-file)))

(column-number-mode 1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(setq-default fill-column 80)

(show-paren-mode)

(setq inhibit-startup-screen t)

;; (use-package gruvbox-theme
;;   :config (load-theme 'gruvbox-dark-hard t))

(use-package doom-themes
  :config (load-theme 'doom-vibrant t))

(defun font-exists-p (font)
  "Return t if FONT exists and nil otherwise."
  (if (null (x-list-fonts font)) nil t))

(let ((font "Iosevka Extended")
      (font-size "10"))
  (when (font-exists-p font)
    (set-frame-font (concat font "-" font-size) nil t)))

(setq-default indent-tabs-mode nil)

(setq-default show-trailing-whitespace t)

(setq-default indicate-empty-lines t)

(setq backup-by-copying t
      version-control t
      delete-old-versions t)

(setq sentence-end-double-space nil)

(setq org-adapt-indentation nil)

(add-hook 'org-mode-hook #'(lambda ()
                             (unless (string-equal system-type "windows-nt")
                               (flyspell-mode))))

(ido-mode 1)
(ido-everywhere)
(setq ido-enable-flex-matching t
      ido-create-new-buffer 'always)

(use-package magit
  :bind ("C-x g" . magit-status))

(global-set-key (kbd "C-,") #'recompile)

(add-hook 'compilation-mode-hook
          #'(lambda () (setq truncate-lines nil
                             show-trailing-whitespace nil)))

(defun google-c++-style ()
  (c-set-style "stroustrup")
  (c-set-offset 'access-label '/)
  (c-set-offset 'innamespace '0)
  (c-set-offset 'member-init-intro '++)
  (setq c-basic-offset 2
        compile-command "cmake --build build "))

(add-hook 'c++-mode-hook #'google-c++-style)

(use-package clang-format+
  :hook (c++-mode . clang-format+-mode))

(use-package cmake-mode)

(use-package css-mode
  :config (setq css-indent-offset 2))

(use-package paredit
  :hook (emacs-lisp-mode . paredit-mode)
  :hook (lisp-mode . paredit-mode))

(use-package haskell-mode)
