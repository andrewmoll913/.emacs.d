(setq inhibit-startup-message t)
(tool-bar-mode 0)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-engines-alist
	'(("elixir"  . "\\.html.eex\\'")))
  (setq web-mode-ac-sources-alist
	'(("css" . (ac-source-css-property))
	  ("html" . (ac-source-words-in-buffer ac-source-abbrev))))
  (setq web-mode-enable-auto-closing t))

(use-package impatient-mode
  :ensure t)

(use-package alchemist
  :ensure t
  :config
  (progn
    (setq alchemist-project-compile-when-needed t)
    (define-key elixir-mode-map (kbd "C-c a i t") 'alchemist-iex-reload)))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package counsel
  :ensure t)

(use-package magit
  :ensure t
  :config
  (progn
    (global-set-key (kbd "C-x g") 'magit-status)
    (global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)))

(use-package php-mode
  :ensure t)
 
(use-package swiper
  :ensure t
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (global-set-key "\C-s" 'swiper)
    (global-set-key "\C-r" 'swiper)
    (global-set-key (kbd "C-x b") 'ivy-switch-buffer)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-load-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)))

(use-package avy
  :ensure t
  :config
  (progn
    (global-set-key (kbd "C-;") 'avy-goto-char)
    (global-set-key (kbd "C-:") 'avy-goto-char-2)
    (global-set-key (kbd "M-g f") 'avy-goto-line)
    (global-set-key (kbd "M-g e") 'avy-goto-word)))

(use-package ace-window
  :ensure t
  :config
  (progn
    (global-set-key (kbd "C-x o") 'ace-window)
    (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))))

(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))

(global-set-key (kbd "C-`") 'push-mark-no-activate)

(defun jump-to-mark ()
  "Jumps to the local mark, respecting the `mark-ring' order. This is the same as using \\[set-mark-command] with the prefix argument."
  (interactive)
  (set-mark-command 1))
(global-set-key (kbd "M-`") 'jump-to-mark)

;; set M-/ to use hippie-expand
(global-set-key (kbd "M-/") 'hippie-expand)

(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(defun alchemist-iex-reload (&optional arg)
  (interactive "P")
  (when (buffer-live-p alchemist-iex-buffer)
    (kill-process (get-buffer-process alchemist-iex-buffer))
    (sleep-for 1)
    (if arg
	(call-interactively 'alchemist-iex-project-run)
      (call-interactively 'alchemist-iex-run))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(alchemist-company-show-annotation t)
 '(desktop-save-mode nil)
 '(erldoc-man-index "file:///c:/Program%20Files/erl9.0/doc/man_index.html")
 '(ibuffer-saved-filter-groups
   (quote
    (("tutor"
      ("lisp"
       (used-mode . emacs-lisp-mode))
      ("csrc"
       (used-mode . c-mode))))))
 '(ibuffer-saved-filters
   (quote
    (("gnus"
      ((or
	(mode . message-mode)
	(mode . mail-mode)
	(mode . gnus-group-mode)
	(mode . gnus-summary-mode)
	(mode . gnus-article-mode))))
     ("programming"
      ((or
	(mode . emacs-lisp-mode)
	(mode . cperl-mode)
	(mode . c-mode)
	(mode . java-mode)
	(mode . idl-mode)
	(mode . lisp-mode)))))))
 '(ido-mode (quote both) nil (ido))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (impatient-mode web-mode php-mode org-journal ox-asciidoc erlang auto-overlays counsel org-bullets which-key try use-package ace-window ivy swiper avy magit alchemist)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Go" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))
