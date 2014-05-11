(defvar attic-minor-mode-map (make-keymap) "attic-minor-mode keymap.")
(defvar insert-mode-map (make-keymap) "insert-mode keymap.")

(key-chord-define-global ";;" 'god-mode-enable)

(key-chord-define isearch-mode-map ";;" 'isearch-abort)

(key-chord-define insert-mode-map "xs"
                  (lambda() (interactive)
                    (if (string-equal (buffer-name) "*Helm Swoop Edit*")
                        (helm-swoop--edit-complete))
                    (god-mode-enable)
                    (save-buffer)))

;; Control Keys
(define-key attic-minor-mode-map (kbd "C-u") 'pop-to-mark-command)
(define-key attic-minor-mode-map (kbd "C-q") 'backward-delete-char)
(define-key attic-minor-mode-map (kbd "C--") 'undo)
(define-key attic-minor-mode-map (kbd "C-l") 'iy-go-up-to-char)

(define-key attic-minor-mode-map (kbd "C-h") 'helm-M-x)
(define-key attic-minor-mode-map (kbd "C-z") 'helm-buffers-list)
(define-key attic-minor-mode-map (kbd "C-.") 'helm-resume)
(define-key attic-minor-mode-map (kbd "C-j") 'ace-jump-mode)
(define-key attic-minor-mode-map (kbd "C-/") 'comment-or-uncomment-region)

;; Control Prefix
(define-key attic-minor-mode-map (kbd "C-x C-f") 'helm-find-files)
(define-key attic-minor-mode-map (kbd "C-c C-f") 'helm-ls-git-ls)
(define-key attic-minor-mode-map (kbd "C-c C-o") 'hoogle-search)
(define-key attic-minor-mode-map (kbd "C-c C-t") 'transpose-paragraphs)
(define-key attic-minor-mode-map (kbd "C-c C-m") 'magit-status)
(define-key attic-minor-mode-map (kbd "C-c C-q") 'kmacro-start-macro)
(define-key attic-minor-mode-map (kbd "C-c C-e") 'kmacro-end-or-call-macro-repeat)
(define-key attic-minor-mode-map (kbd "C-x C-1") 'delete-other-windows)
(define-key attic-minor-mode-map (kbd "C-x C-2") 'split-window-below)
(define-key attic-minor-mode-map (kbd "C-x C-3") 'split-window-right)
(define-key attic-minor-mode-map (kbd "C-x C-0") 'delete-window)

;; Control Prefix 3
(define-key attic-minor-mode-map (kbd "C-c C-w C-e") 'load-attic-workgroups)
(define-key attic-minor-mode-map (kbd "C-c C-w C-w") 'load-attic-workgroups2)
(define-key attic-minor-mode-map (kbd "C-c C-s C-g") 'helm-do-grep)
(define-key attic-minor-mode-map (kbd "C-c C-s C-m") 'helm-multi-swoop)
(define-key attic-minor-mode-map (kbd "C-c C-s C-s") (lambda() (interactive)
                                                   (helm-swoop :$query "")))
(define-key attic-minor-mode-map (kbd "C-c C-s C-r") (lambda () (interactive)
    (let ((current-prefix-arg '(1)))
      (call-interactively 'helm-do-grep))))

;; Make keys
(define-key attic-minor-mode-map (kbd "C-c C-z C-z") 'run-make)
(define-key attic-minor-mode-map (kbd "C-c C-z C-j") 'run-make-js)
(define-key attic-minor-mode-map (kbd "C-c C-z C-s") 'run-make-start)
(define-key attic-minor-mode-map (kbd "C-c C-z C-r") 'run-make-restart)

;; Meta Keys
(define-key attic-minor-mode-map (kbd "M-q") 'backward-kill-word)
(define-key attic-minor-mode-map (kbd "M-+") 'align-regexp)
(define-key attic-minor-mode-map (kbd "M-@") 'er/expand-region)
(define-key attic-minor-mode-map (kbd "M-k") 'kill-this-buffer)
(define-key attic-minor-mode-map (kbd "M-P") 'mc/mark-previous-like-this)
(define-key attic-minor-mode-map (kbd "M-N") 'mc/mark-next-like-this)
(define-key attic-minor-mode-map (kbd "M-*") 'mc/mark-all-like-this)
(define-key attic-minor-mode-map (kbd "M-_") 'redo)
(define-key attic-minor-mode-map (kbd "M-C-_") 'redo)
(define-key attic-minor-mode-map (kbd "M-C--") 'redo)
(define-key attic-minor-mode-map (kbd "M-j") (lambda() (interactive) (join-line -1)))
(define-key attic-minor-mode-map (kbd "M-g") 'goto-line)
(define-key mc/keymap (kbd "M-g") 'keyboard-escape-quit-mc)

;; Other Keys
(global-set-key [f7] 'get-current-buffer-major-mode)
(global-set-key [f1] 'copy-to-clipboard)
(global-set-key [f2] 'paste-from-clipboard)

;; Erlang Keys
(defun erlang-keys-hook ()
  (local-set-key (kbd "M-?") 'erlang-get-error)
  (local-set-key (kbd "M-n") 'flymake-goto-next-error)
  (local-set-key (kbd "M-p") 'flymake-goto-prev-error)
  (local-set-key (kbd "M-q") 'backward-kill-word)
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
)

;; Helm keys
(define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-map (kbd "M-f") 'helm-select-action)
(define-key helm-map (kbd "M-b") 'nil)
(define-key helm-map (kbd "C-f") 'nil)
(define-key helm-map (kbd "C-b") 'nil)
(define-key helm-map (kbd "C-g") 'nil)
(define-key helm-buffer-map (kbd "C-a") 'helm-buffers-toggle-show-hidden-buffers)
(define-key helm-swoop-map (kbd "M-e") 'helm-swoop-edit)

;; God mode
(define-key god-local-mode-map (kbd "i")   'god-mode-disable)
(define-key god-local-mode-map (kbd "[") (lambda ()
    (interactive) (scroll-down-line 3)))
(define-key god-local-mode-map (kbd "]") (lambda ()
    (interactive) (scroll-up-line 3)))

;; Modes
(define-minor-mode attic-minor-mode
"A minor mode so that my key settings override annoying major modes."

t " attic" 'attic-minor-mode-map)
(defun attic-minibuffer-setup-hook ()
(attic-minor-mode 0))

;; Disable Control keys in insert mode
(define-minor-mode insert-mode
  "Insert mode" nil nil 'insert-mode-map)

(let ((f (lambda () `(lambda () (interactive)
              (message (concat "Exit insert mode first."))))))
  (dolist (l '(("C-a") ("C-q") ("C-w") ("C-e") ("C-r") ("C-t")
               ("C-y") ("C-u") ("C-o") ("C-p") ("C-a") ("C-s")
               ("C-d") ("C-f") ("C-g") ("C-j") ("C-k") ("C-l")
               ("C-z") ("C-x") ("C-c") ("C-v") ("C-b") ("C-n") ))
    (define-key insert-mode-map
      (read-kbd-macro (car l)) (funcall f))))

;; Other unset keys
(global-unset-key "\M-x")
(global-unset-key "\C-x\C-z")
(provide 'my-keys)
