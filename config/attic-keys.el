(define-prefix-command 'attic-make-map)

(defun attic-key(key function)
  (define-key attic-mode-map (kbd key) function))

(global-set-key (kbd "C-M-]") 'attic-mode)
(mapcar (lambda(a) (attic-key (nth 0 a) (nth 1 a)))
        '(("C-c C-o" switch-to-minibuffer)
          ("C-c C-=" increment-decimal)
          ("C-c C--" decrement-decimal)
          ("C-;" attic-semi-colon/body)
          ("C-'" helm-M-x)
          ("C-z" helm-buffers-list)
          ("C-j" iy-go-to-char)
          ("M-j" iy-go-to-char-backward)
          ("C-q" backward-delete-char)
          ("M-q" backward-kill-word)
          ("C-S-V" x-clipboard-yank)
          ("C-S-C" clipboard-kill-ring-save)
          ("C-M-q" backward-kill-sexp)
          ("C-x C-f" helm-find-files)
          ("C-x C-1" delete-other-windows)
          ("C-x C-2" split-window-below)
          ("C-x C-3" split-window-right)
          ("C-x C-4" delete-window)
          ("C-x C-8" fill-paragraph)
          ("C-x C-b" helm-buffers-list)
          ("C-x C-k" kill-this-buffer)
          ("C-c C-p" copy-line-up)
          ("C-c C-n" copy-line-down)
          ;; Meta keys
          ("M-+" align-regexp)
          ("M-C" capitalize-previous-word)
          ("M-i" tab-to-tab-stop-line-or-region)
          ("M-I" tab-to-tab-stop-line-or-region-backward)
          ("M-y" yank-pop-or-kill-ring)))

(define-key attic-mode-map
  (kbd "C-;")
  (defhydra attic-semi-colon (:color blue)
    "Attic"
    ("'" helm-org-capture-templates nil)
    ("C-'" helm-org-capture-templates nil)
    ("." create-tags "Tag")
    ("C-." create-tags nil)
    ("0" elscreen-goto-0 nil)
    ("C-0" elscreen-goto-0 nil)
    ("1" elscreen-goto-1 nil)
    ("C-1" elscreen-goto-1 nil)
    ("2" elscreen-goto-2 nil)
    ("C-2" elscreen-goto-2 nil)
    ("3" elscreen-goto-3 nil)
    ("C-3" elscreen-goto-3 nil)
    ("4" elscreen-goto-4 nil)
    ("C-4" elscreen-goto-4 nil)
    ("5" elscreen-goto-5 nil)
    ("C-5" elscreen-goto-5 nil)
    ("6" elscreen-goto-6 nil)
    ("C-6" elscreen-goto-6 nil)
    ("7" elscreen-goto-7 nil)
    ("C-7" elscreen-goto-7 nil)
    ("8" elscreen-goto-8 nil)
    ("C-8" elscreen-goto-8 nil)
    ("9" elscreen-goto-9 nil)
    ("C-9" elscreen-goto-9 nil)
    (";" elscreen-toggle nil)
    ("C-;" elscreen-toggle nil)
    ("<SPC>" pop-to-mark-command nil)
    ("C-<SPC>" pop-to-mark-command nil)
    ("M-d" helm-swoop nil)
    ("C-M-d" helm-swoop nil)
    ("[" winner-undo nil :color red)
    ("C-[" winner-undo nil :color red)
    ("]" winner-redo nil :color red)
    ("C-]" winner-redo nil :color red)
    ("a" async-shell-command "ASync Shell")
    ("C-a" async-shell-command nil)
    ("b" helm-bookmarks "Bookmarks")
    ("C-b" helm-bookmarks nil)
    ("d" (lambda() (interactive) (helm-swoop :$query "")) "Swoop")
    ("C-d" (lambda() (interactive) (helm-swoop :$query "")) nil)
    ("e" eww "Eww")
    ("C-e" eww nil)
    ("f" attic-file/body)
    ("C-f" attic-file/body)
    ("g" magit-status "Magit")
    ("i" remove-newline-space nil)
    ("C-i" remove-newline-space nil)
    ("j" attic-lock "Lock")
    ("C-j" attic-lock nil)
    ("k" kill-buffer "Kill")
    ("C-k" kill-buffer nil)
    ("m" attic-emms/body "EMMS")
    ("C-m" attic-emms/body nil)
    ("q" attic-make/body "Make")
    ("C-q" attic-make/body nil)
    ("s" shell-command "Shell")
    ("C-s" shell-command nil)
    ("x" helm-M-x "M-x")
    ("C-x" helm-M-x nil)
    ("r" rgrep "RGrep")
    ("C-r" rgrep nil)
    ("t" transpose-mark nil)
    ("C-t" transpose-mark nil)
    ("c" attic-macro/body "Macro")
    ("C-c" attic-macro/body nil)
    ))

(defhydra attic-macro (:color blue :hint nil)
  "
^Call^                   ^Edit^                 ^Save^                ^View^
^^^^^^^^------------------------------------------------------------------------------
_s_: Start             _C-e_: Edit repeat       _b_: Bind to key      _C-n_: Cycle next
_k_: Call or repeat    _r_: Edit                _n_: Name last        _C-p_: Cycle prev
_q_: Query             _e_: Edit kbd macro      _x_: To register      _C-v_: Macro view
_r_: Apply region      _l_: Edit lossage        _C-f_: Set format
_C-d_: Delete head     _ _: Step edit-macro     _C-c_: Set counter
"
  ("s"    kmacro-start-macro)
  ("k"    kmacro-end-or-call-macro-repeat)
  ("r"    apply-macro-to-region-lines)
  ("q"    kbd-macro-query)
  ("C-n"  kmacro-cycle-ring-next)
  ("C-p"  kmacro-cycle-ring-previous)
  ("C-v"  kmacro-view-macro-repeat)
  ("C-d"  kmacro-delete-ring-head)
  ("C-t"  kmacro-swap-ring)
  ("C-l"  kmacro-call-ring-2nd-repeat)
  ("C-f"  kmacro-set-format)
  ("C-c"  kmacro-set-counter)
  ("C-i"  kmacro-insert-counter)
  ("C-a"  kmacro-add-counter)
  ("C-e"  kmacro-edit-macro-repeat)
  ("r"    kmacro-edit-macro)
  ("e"    edit-kbd-macro)
  ("l"    kmacro-edit-lossage)
  (" "    kmacro-step-edit-macro)
  ("b"    kmacro-bind-to-key)
  ("n"    kmacro-name-last-macro)
  ("x"    kmacro-to-register))

(defhydra attic-make (:color blue)
  "[Make]"
  ("p" attic/make-stop    "Stop")
  ("r" attic/make-restart "Restart")
  ("s" attic/make-start   "Start")
  ("t" attic/make-test    "Test")
  ("o" attic/make-go      "Go")
  ("q" attic/make-default "Make")
  ("c" attic/make-custom  "Custom"))


(defhydra attic-file (:color blue :hint nil)
  "
^File^                   ^Buffer^
^^^^^^^^----------------------------------------
_f_: helm-find-files     _j_: helm-buffer-list
_d_: helm-ls-git-ls      _b_: helm-bookmarks
^ ^                      _l_: next-buffer
^ ^                      _h_: previous-buffer
"
  ("f" helm-find-files)
  ("d" helm-ls-git-ls)
  ("b" helm-bookmarks)
  ("j" helm-buffers-list)
  ("h" previous-buffer :color red)
  ("l" next-buffer :color red))

;; Make keys
(define-key isearch-mode-map (kbd "<escape>") 'isearch-abort)
(define-key isearch-mode-map (kbd "M-g") 'isearch-abort)
(define-key isearch-mode-map (kbd "TAB") 'isearch-exit)

;; Other Keys
(global-set-key [f3] 'describe-key)
(global-set-key [f4] 'send-to-pastie)
(global-set-key [f6] 'describe-mode)
(global-set-key [f7] 'get-current-buffer-major-mode)
(global-set-key [f9] 'toggle-menu-bar-mode-from-frame)
(global-set-key [f11] 'screenshot-frame)

;; C Keys
(defun c-keys-hook ()
(define-key c-mode-base-map (kbd "C-/") 'attic/comment))

;; Package Menu mode
(define-key package-menu-mode-map (kbd ";") 'attic-semi-colon/body)

(require 'doc-view)
(define-key doc-view-mode-map (kbd "j") 'doc-view-next-line-or-next-page)
(define-key doc-view-mode-map (kbd "k") 'doc-view-previous-line-or-previous-page)

(define-key doc-view-mode-map (kbd ";") 'attic-semi-colon/body)
(define-key doc-view-mode-map (kbd "z") 'helm-buffers-list)

(define-key help-mode-map (kbd ";") 'attic-semi-colon/body)
(define-key help-mode-map (kbd "z") 'helm-buffers-list)

(define-key messages-buffer-mode-map (kbd ";") 'attic-semi-colon/body)
(define-key messages-buffer-mode-map (kbd "z") 'helm-buffers-list)

(defun attic-minibuffer-setup-hook ()
  (attic-mode 0))

;; Other unset keys
(global-unset-key "\C-x\C-z")
(global-unset-key "\C-z")
(provide 'attic-keys)
