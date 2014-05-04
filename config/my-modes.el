(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(ido-mode 1)
;(global-linum-mode 1)
(auto-complete-mode 1)
(multiple-cursors-mode 1)
(workgroups-mode 1)
(show-paren-mode t)
(electric-pair-mode 1)
(window-numbering-mode 1)
(yas-global-mode 1)
(undo-tree-mode 1)
(column-number-mode 1)
(fringe-mode 0)
(god-mode)
(global-rainbow-delimiters-mode)

(modify-frame-parameters nil '((wait-for-wm . nil)))

(define-global-minor-mode my-global-linum-mode linum-mode
  (lambda () (when (not (memq major-mode
    (list 'twittering-mode 'erlang-shell-mode)))
      (linum-mode))))

(my-global-linum-mode 1)

(define-globalized-minor-mode global-auto-complete-mode auto-complete-mode
  (lambda () (when(not (memq major-mode
    (list 'shell-mode 'minibuffer-mode 'erlang-shell-mode)))
               (auto-complete-mode))))

(define-globalized-minor-mode global-column-enforce-mode column-enforce-mode
  (lambda () (when(not (memq major-mode
    (list 'shell-mode 'minibuffer-mode 'org-mode 'erlang-shell-mode)))
      (column-enforce-mode))))

(define-globalized-minor-mode global-wrap-region-mode
  wrap-region-mode wrap-region-mode)

(define-globalized-minor-mode global-godly-mode
  god-local-mode god-local-mode)

(global-godly-mode 1)
(global-auto-complete-mode 1)
(global-column-enforce-mode 1)
(global-wrap-region-mode 1)

(provide 'my-modes)
