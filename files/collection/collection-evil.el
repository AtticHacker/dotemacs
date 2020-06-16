;;; collection/collection-evil.el -*- lexical-binding: t; -*-

(use-package evil-collection
  :straight t
  :after evil
  :config
  (setq evil-collection-mode-list
        (remove 'lispy evil-collection-mode-list))
  (evil-collection-init))

(use-package evil
  :straight t
  :init
  (setq evil-want-keybinding nil)
  :config
  (require 'evil-collection)
  ;; This breaks company mode
  (define-key evil-insert-state-map (kbd "C-k") nil)
  (define-key evil-insert-state-map (kbd "C-v") (lambda () (interactive)))
  (define-key evil-visual-state-map (kbd "TAB") #'indent-region)
  (define-key evil-visual-state-map (kbd "ii") #'evil-insert)

  (setq scroll-preserve-screen-position t)
  ;; This prevents the screen from completely scrolling up
  ;; (advice-add 'evil-scroll-page-up :after #'kwrooijen/recenter)
  (advice-add 'evil-scroll-page-down :after #'kwrooijen/recenter)
  (advice-add 'evil-search-next :after #'kwrooijen/recenter)
  (advice-add 'evil-search-previous :after #'kwrooijen/recenter)
  (evil-mode 1))

(use-package evil-magit
  :straight t
  :after magit)

(use-package evil-nerd-commenter
  :straight t
  :bind* (("M-/" . evilnc-comment-or-uncomment-lines)))

(provide 'collection-evil)