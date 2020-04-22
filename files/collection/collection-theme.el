;;; collection/collection-theme.el -*- lexical-binding: t; -*-

(use-package doom-themes
  :straight t
  :config
  (setq dark-theme? t)
  (defun toggle-theme ()
    (interactive)
    (if dark-theme?
        (load-theme 'doom-one-light t)
      (load-theme 'doom-one t))
    (solaire-mode-swap-bg)
    (setq dark-theme? (not dark-theme?)))

  (load-theme 'doom-one t))

(use-package vi-tilde-fringe
  :straight t
  :config

  (add-hook 'text-mode-hook #'vi-tilde-fringe-mode)
  (add-hook 'prog-mode-hook #'vi-tilde-fringe-mode)
  (add-hook* 'vi-tilde-fringe-mode-hook
             (setq left-fringe-width 8
                   right-fringe-width 8)))

(use-package doom-modeline
  :straight t
  :config
  (doom-modeline-mode 1))

(use-package solaire-mode
  :straight t
  :hook
  ((change-major-mode after-revert ediff-prepare-buffer) . turn-on-solaire-mode)
  (minibuffer-setup . solaire-mode-in-minibuffer)
  :config
  (solaire-global-mode +1)
  (solaire-mode-swap-bg))

(provide 'collection-theme)
