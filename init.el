;;
;; Init
;;
(defvar bootstrap-version)

(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

;;
;; Helpers
;;

(defmacro add-hook* (mode fn)
  `(add-hook ,mode (lambda () ,fn)))

;;
;; Packages
;;

(use-package doom-themes
  :straight t
  :config
  (load-theme 'doom-one t))

(use-package evil
  :straight t
  :init
  (defun evil-recenter (&rest x)
    (evil-scroll-line-to-center (line-number-at-pos)))
  (setq evil-want-keybinding nil)
  :config
  (advice-add 'evil-scroll-page-down :after #'evil-recenter)
  (advice-add 'evil-scroll-page-up :after #'evil-recenter)
  (advice-add 'evil-search-next :after #'evil-recenter)
  (advice-add 'evil-search-previous :after #'evil-recenter)
  (evil-mode 1))

(use-package evil-leader
  :straight t
  :config
  (global-evil-leader-mode))

(use-package evil-collection
  :straight t
  :after evil
  :config
  (evil-collection-init))

(use-package vi-tilde-fringe
  :straight t
  :config
  (global-vi-tilde-fringe-mode t))

(use-package which-key
  :straight t
  :config
  (which-key-mode))

(use-package magit
  :straight t
  :config
  (evil-collection-init 'magit))

(use-package evil-magit
  :straight t
  :after magit)

(use-package clojure-mode
  :straight t
  :config
  (add-hook 'clojure-mode-hook #'lispy-mode))

(use-package cider
  :straight t
  :init
  (setq cider-auto-jump-to-error nil))

(use-package wrap-region
  :straight t
  :config
  (wrap-region-global-mode))

(use-package expand-region
  :straight t
  :bind* (("M-@" . er/expand-region)))

(use-package diff-hl
  :straight t
  :init
  (setq diff-hl-margin-symbols-alist
        '((insert . "▐") (delete . "▐") (change . "▐")
          (unknown . "▐") (ignored . "▐")))

  :custom-face
  (diff-hl-margin-insert ((t (:foreground "#5be56b" :inherit nil))) )
  (diff-hl-margin-delete ((t (:foreground "#e85555" :inherit nil))) )
  (diff-hl-margin-change ((t (:foreground "#fcb75d" :inherit nil))) )
  :config
  ;; (global-diff-hl-mode 1)
  (diff-hl-margin-mode 1))

(use-package winum
  :straight t
  :bind* (("M-1" . winum-select-window-1)
          ("M-2" . winum-select-window-2)
          ("M-3" . winum-select-window-3)
          ("M-4" . winum-select-window-4)
          ("M-5" . winum-select-window-5)
          ("M-6" . winum-select-window-6)
          ("M-7" . winum-select-window-7)
          ("M-8" . winum-select-window-8)
          ("M-9" . winum-select-window-9))
  :config
  (winum-mode))

(use-package doom-modeline
  :straight t
  :config
  (doom-modeline-mode 1))

(use-package helm
  :straight t
  :config
  (evil-collection-init 'helm)
  (define-key global-map (kbd "M-x") #'helm-M-x)
  (define-key helm-map (kbd "C-j") #'helm-next-line)
  (define-key helm-map (kbd "C-k") #'helm-previous-line)
  (define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
  (define-key helm-map (kbd "<tab>") #'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") #'helm-select-action)
  (define-key helm-map (kbd "<escape>") #'helm-keyboard-quit))

(use-package helm-ag
  :straight t
  :config
  (define-key helm-ag-map (kbd "C-j")
    (lambda ()
      (interactive)
      (helm-next-line)
      (helm-execute-persistent-action)))
  (define-key helm-ag-map (kbd "C-k")
    (lambda ()
      (interactive)
      (helm-previous-line)
      (helm-execute-persistent-action))))

(use-package helm-swoop
  :straight t)

(use-package helm-ag
  :straight t)

(use-package helm-projectile
  :straight t)

(use-package anzu
  :straight t
  :bind* (("M-%" . anzu-query-replace))
  :init
  (global-anzu-mode))

(use-package key-chord
  :straight t
  :config
  (add-hook* 'prog-mode-hook (key-chord-mode 1))
  (add-hook* 'isearch-mode-hook (key-chord-mode 1))
  (key-chord-define-global "xs" (lambda () (interactive)
                                  (evil-normal-state)
                                  (save-buffer))))

(use-package multiple-cursors
  :straight (mc :host github
                :repo "kwrooijen/mc"
                :files (:defaults (:exclude "*.el.in")))
  :bind* (("M-K" . mc/mark-previous-like-this)
          ("M-J" . mc/mark-next-like-this))
  :config
  (multiple-cursors-mode t))

(use-package ws-butler
  :straight t
  :config
  (ws-butler-global-mode)
  ;; Disable aftersave
  (defun ws-butler-after-save ()))

(use-package undo-tree
  :straight t
  :bind (("M-u" . undo-tree-redo)))

(use-package lispy
  :straight t
  :config
  (add-hook 'lispy-mode-hook #'lispyville-mode))

(use-package lispyville
  :straight t)

;;
;; Functions
;;

(defun capitalize-previous-word ()
  (interactive)
  (save-excursion
    (backward-word)
    (capitalize-word 1)))

;;
;; Key bindings
;;

(bind-key* "M-+" 'align-regexp)
(bind-key* "M-C" 'capitalize-previous-word)

;;
;; Configuration
;;

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)
(global-hl-line-mode 1)

;; Smooth Scrolling
(setq scroll-margin 1
      scroll-conservatively 10000
      scroll-step 1
      auto-window-vscroll nil)

;; Don’t use tabs
(setq-default indent-tabs-mode nil)

(setq mac-command-modifier 'meta)

(set-frame-font "-*-Fira Mono-*-*-*-*-10-*-*-*-*-*-*-*" nil t)

;;
;; Keybindings
;;

(evil-leader/set-key

 ;; Buffers
 "b b" 'helm-mini

 ;; Files
 "f f" 'helm-find-files

 ;; Git
 "g g" 'magit-status

 ;; Project
 "p p" 'helm-projectile-switch-project
 "p f" 'helm-projectile-find-file

 ;; Search
 "s s" 'helm-swoop-without-pre-input
 "s p" 'helm-projectile-ag

 ;; Window
 "w s" 'evil-window-split

 ;; Resume
 "r r" 'helm-resume
 "r y" 'helm-show-kill-ring)

(evil-leader/set-leader "SPC")


;; TODO check these
;; (anzu-mode
;; +org-pretty-mode
;; git-gutter-mode
;; global-whitespace-newline-mode
;; global-whitespace-mode
;; whitespace-newline-mode
;; whitespace-mode
;; highlight-parentheses-mode
;; highlight-quoted-mode
;; rainbow-delimiters-mode
;; vi-tilde-fringe-mode
;; goto-address-prog-mode
;; goto-address-mode
;; highlight-numbers-mode
;; smartparens-mode
;; ws-butler-mode
;; projectile-mode
;; gcmh-mode
;; better-jumper-local-mode
;; company-search-mode
;; company-mode
;; helm-mode
;; helm-ff--delete-async-modeline-mode
;; evil-goggles-mode
;; evil-escape-mode
;; org-capture-mode
;; pcre-mode
;; hl-todo-mode
;; org-cdlatex-mode
;; org-src-mode
;; org-list-checkbox-radio-mode
;; orgtbl-mode
;; org-table-follow-field-mode
;; org-table-header-line-mode
;; magit-blame-mode
;; magit-file-mode
;; magit-wip-initial-backup-mode
;; magit-wip-before-change-mode
;; magit-wip-after-apply-mode
;; magit-wip-after-save-local-mode
;; magit-wip-mode
;; smerge-mode
;; diff-minor-mode
;; git-commit-mode
;; mml-mode
;; with-editor-mode
;; which-key-mode
;; buffer-face-mode
;; text-scale-mode
;; global-auto-revert-mode
;; auto-revert-tail-mode
;; auto-revert-mode
;; solaire-mode
;; evil-snipe-local-mode
;; flycheck-mode
;; clj-refactor-mode
;; superword-mode
;; subword-mode
;; sgml-electric-tag-pair-mode
;; paredit-mode
;; yas-minor-mode
;; cider--debug-mode
;; cider-mode
;; cider-auto-test-mode
;; cider-popup-buffer-mode
;; cider-enlighten-mode
;; vc-parent-buffer
;; lispyville-mode
;; lispy-other-mode
;; lispy-goto-mode
;; lispy-mode
;; outline-minor-mode
;; helm-migemo-mode
;; counsel-mode
;; compilation-minor-mode
;; compilation-shell-minor-mode
;; compilation-in-progress
;; ivy-mode
;; xref-etags-mode
;; edebug-mode
;; override-global-mode
;; mc-hide-unmatched-lines-mode
;; rectangular-region-mode
;; multiple-cursors-mode
;; +web-wordpress-mode
;; +web-jekyll-mode
;; +emacs-lisp-ert-mode
;; +data-vagrant-mode
;; undo-tree-visualizer-selection-mode
;; undo-tree-mode
;; reveal-mode
;; flyspell-mode
;; ispell-minor-mode
;; ns-auto-titlebar-mode
;; general-override-local-mode
;; general-override-mode
;; eldoc-mode
;; visible-mode
;; visual-line-mode
;; next-error-follow-minor-mode
;; abbrev-mode
;; overwrite-mode
;; auto-fill-function
;; defining-kbd-macro
;; isearch-mode)
