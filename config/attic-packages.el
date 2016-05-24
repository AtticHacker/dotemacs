(require 'package)
(require 'ert)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("elpa" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(defvar attic-mode-map (make-keymap) "attic-mode keymap.")
(define-minor-mode attic-mode
  "A minor mode for key mapping."
  t " attic" 'attic-mode-map)

(use-package ac-cider
  :ensure t)

(use-package ace-jump-mode
  :ensure t)

(use-package adjust-parens
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook #'adjust-parens-mode)
  (add-hook 'clojure-mode-hook #'adjust-parens-mode)
  (add-hook 'scheme-mode-hook #'adjust-parens-mode)
  (add-hook 'racket-mode-hook #'adjust-parens-mode))

(use-package aggressive-indent
  :ensure t)

(use-package alchemist
  :ensure t
  :config
  (setq alchemist-hooks-compile-on-save t
        alchemist-hooks-test-on-save t)

  (add-hook 'alchemist-iex-mode-hook #'company-mode)
  (bind-key "M-N" 'mc/mark-next-like-this alchemist-mode-map)
  (bind-key "M-P" 'mc/mark-previous-like-this alchemist-mode-map)
  (bind-key "M-n" 'alchemist-goto-jump-to-next-def-symbol alchemist-mode-map)
  (bind-key "M-p" 'alchemist-goto-jump-to-previous-def-symbol alchemist-mode-map)

  ;; God mode
  (bind-key "C-c C-a C-c C-b" 'alchemist-compile-this-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-c C-c" 'alchemist-compile alchemist-mode-map)
  (bind-key "C-c C-a C-c C-f" 'alchemist-compile-file alchemist-mode-map)
  (bind-key "C-c C-a C-e C-b" 'alchemist-execute-this-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-e C-e" 'alchemist-execute alchemist-mode-map)
  (bind-key "C-c C-a C-e C-f" 'alchemist-execute-file alchemist-mode-map)
  (bind-key "C-c C-a C-h C-e" 'alchemist-help-search-at-point alchemist-mode-map)
  (bind-key "C-c C-a C-h C-h" 'alchemist-help alchemist-mode-map)
  (bind-key "C-c C-a C-h C-i" 'alchemist-help-history alchemist-mode-map)
  (bind-key "C-c C-a C-h C-r" 'alchemist-refcard alchemist-mode-map)
  (bind-key "C-c C-a C-i C-b" 'alchemist-iex-compile-this-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-i C-c" 'alchemist-iex-send-current-line-and-go alchemist-mode-map)
  (bind-key "C-c C-a C-i C-i" 'alchemist-iex-run alchemist-mode-map)
  (bind-key "C-c C-a C-i C-l" 'alchemist-iex-send-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-i C-m" 'alchemist-iex-send-region-and-go alchemist-mode-map)
  (bind-key "C-c C-a C-i C-p" 'alchemist-iex-project-run alchemist-mode-map)
  (bind-key "C-c C-a C-i C-r" 'alchemist-iex-send-region alchemist-mode-map)
  (bind-key "C-c C-a C-m C-c" 'alchemist-mix-compile alchemist-mode-map)
  (bind-key "C-c C-a C-m C-r" 'alchemist-mix-run alchemist-mode-map)
  (bind-key "C-c C-a C-m C-t C-." 'alchemist-mix-test-at-point alchemist-mode-map)
  (bind-key "C-c C-a C-m C-t C-b" 'alchemist-mix-test-this-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-m C-t C-f" 'alchemist-mix-test-file alchemist-mode-map)
  (bind-key "C-c C-a C-m C-t C-." 'alchemist-mix-test-at-point alchemist-mode-map)
  (bind-key "C-c C-a C-m C-t C-b" 'alchemist-mix-test-this-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-m C-t C-f" 'alchemist-mix-test-file alchemist-mode-map)
  (bind-key "C-c C-a C-o C-!" 'alchemist-macroexpand-close-popup alchemist-mode-map)
  (bind-key "C-c C-a C-o C-I" 'alchemist-macroexpand-once-print-region alchemist-mode-map)
  (bind-key "C-c C-a C-o C-K" 'alchemist-macroexpand-print-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-o C-L" 'alchemist-macroexpand-once-print-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-o C-R" 'alchemist-macroexpand-print-region alchemist-mode-map)
  (bind-key "C-c C-a C-o C-i" 'alchemist-macroexpand-once-region alchemist-mode-map)
  (bind-key "C-c C-a C-o C-k" 'alchemist-macroexpand-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-o C-l" 'alchemist-macroexpand-once-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-o C-r" 'alchemist-macroexpand-region alchemist-mode-map)
  (bind-key "C-c C-a C-p C-f" 'alchemist-project-find-test alchemist-mode-map)
  (bind-key "C-c C-a C-p C-l" 'alchemist-project-find-lib alchemist-mode-map)
  (bind-key "C-c C-a C-p C-o" 'alchemist-project-toggle-file-and-tests-other-window alchemist-mode-map)
  (bind-key "C-c C-a C-p C-s" 'alchemist-project-toggle-file-and-tests alchemist-mode-map)
  (bind-key "C-c C-a C-p C-t" 'alchemist-project-run-tests-for-current-file alchemist-mode-map)
  (bind-key "C-c C-a C-v C-!" 'alchemist-eval-close-popup alchemist-mode-map)
  (bind-key "C-c C-a C-v C-e" 'alchemist-eval-quoted-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-v C-h" 'alchemist-eval-print-quoted-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-v C-i" 'alchemist-eval-print-region alchemist-mode-map)
  (bind-key "C-c C-a C-v C-j" 'alchemist-eval-quoted-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-v C-k" 'alchemist-eval-print-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-v C-l" 'alchemist-eval-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-v C-o" 'alchemist-eval-region alchemist-mode-map)
  (bind-key "C-c C-a C-v C-q" 'alchemist-eval-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-v C-r" 'alchemist-eval-print-quoted-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-v C-u" 'alchemist-eval-quoted-region alchemist-mode-map)
  (bind-key "C-c C-a C-v C-w" 'alchemist-eval-print-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-v C-y" 'alchemist-eval-print-quoted-region alchemist-mode-map)
  (bind-key "C-c C-a C-m C-t C-." 'alchemist-mix-test-at-point alchemist-mode-map)
  (bind-key "C-c C-a C-m C-t C-b" 'alchemist-mix-test-this-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-m C-t C-f" 'alchemist-mix-test-file alchemist-mode-map)
  (bind-key "C-c C-a C-m C-t C-." 'alchemist-mix-test-at-point alchemist-mode-map)
  (bind-key "C-c C-a C-m C-t C-b" 'alchemist-mix-test-this-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-m C-t C-f" 'alchemist-mix-test-file alchemist-mode-map)
  (bind-key "C-c C-a C-n C-R" 'alchemist-phoenix-routes alchemist-mode-map)
  (bind-key "C-c C-a C-n C-c" 'alchemist-phoenix-find-controllers alchemist-mode-map)
  (bind-key "C-c C-a C-n C-l" 'alchemist-phoenix-find-channels alchemist-mode-map)
  (bind-key "C-c C-a C-n C-m" 'alchemist-phoenix-find-models alchemist-mode-map)
  (bind-key "C-c C-a C-n C-r" 'alchemist-phoenix-router alchemist-mode-map)
  (bind-key "C-c C-a C-n C-s" 'alchemist-phoenix-find-static alchemist-mode-map)
  (bind-key "C-c C-a C-n C-t" 'alchemist-phoenix-find-templates alchemist-mode-map)
  (bind-key "C-c C-a C-n C-v" 'alchemist-phoenix-find-views alchemist-mode-map)
  (bind-key "C-c C-a C-n C-w" 'alchemist-phoenix-find-web alchemist-mode-map)
  (bind-key "C-c C-a C-r" 'alchemist-mix-rerun-last-test alchemist-mode-map)
  (bind-key "C-c C-a C-t" 'alchemist-mix-test alchemist-mode-map)
  (bind-key "C-c C-a C-x" 'alchemist-mix alchemist-mode-map)
  (bind-key "C-c C-a C-o C-!" 'alchemist-macroexpand-close-popup alchemist-mode-map)
  (bind-key "C-c C-a C-o C-I" 'alchemist-macroexpand-once-print-region alchemist-mode-map)
  (bind-key "C-c C-a C-o C-K" 'alchemist-macroexpand-print-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-o C-L" 'alchemist-macroexpand-once-print-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-o C-R" 'alchemist-macroexpand-print-region alchemist-mode-map)
  (bind-key "C-c C-a C-o C-i" 'alchemist-macroexpand-once-region alchemist-mode-map)
  (bind-key "C-c C-a C-o C-k" 'alchemist-macroexpand-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-o C-l" 'alchemist-macroexpand-once-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-o C-r" 'alchemist-macroexpand-region alchemist-mode-map)
  (bind-key "C-c C-a C-v C-!" 'alchemist-eval-close-popup alchemist-mode-map)
  (bind-key "C-c C-a C-v C-e" 'alchemist-eval-quoted-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-v C-h" 'alchemist-eval-print-quoted-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-v C-i" 'alchemist-eval-print-region alchemist-mode-map)
  (bind-key "C-c C-a C-v C-j" 'alchemist-eval-quoted-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-v C-k" 'alchemist-eval-print-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-v C-l" 'alchemist-eval-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-v C-o" 'alchemist-eval-region alchemist-mode-map)
  (bind-key "C-c C-a C-v C-q" 'alchemist-eval-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-v C-r" 'alchemist-eval-print-quoted-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-v C-u" 'alchemist-eval-quoted-region alchemist-mode-map)
  (bind-key "C-c C-a C-v C-w" 'alchemist-eval-print-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-v C-y" 'alchemist-eval-print-quoted-region alchemist-mode-map)
  (bind-key "C-c C-a C-i C-b" 'alchemist-iex-compile-this-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-i C-c" 'alchemist-iex-send-current-line-and-go alchemist-mode-map)
  (bind-key "C-c C-a C-i C-i" 'alchemist-iex-run alchemist-mode-map)
  (bind-key "C-c C-a C-i C-l" 'alchemist-iex-send-current-line alchemist-mode-map)
  (bind-key "C-c C-a C-i C-m" 'alchemist-iex-send-region-and-go alchemist-mode-map)
  (bind-key "C-c C-a C-i C-p" 'alchemist-iex-project-run alchemist-mode-map)
  (bind-key "C-c C-a C-i C-r" 'alchemist-iex-send-region alchemist-mode-map)
  (bind-key "C-c C-a C-p C-f" 'alchemist-project-find-test alchemist-mode-map)
  (bind-key "C-c C-a C-p C-l" 'alchemist-project-find-lib alchemist-mode-map)
  (bind-key "C-c C-a C-p C-o" 'alchemist-project-toggle-file-and-tests-other-window alchemist-mode-map)
  (bind-key "C-c C-a C-p C-s" 'alchemist-project-toggle-file-and-tests alchemist-mode-map)
  (bind-key "C-c C-a C-p C-t" 'alchemist-project-run-tests-for-current-file alchemist-mode-map)
  (bind-key "C-c C-a C-h C-e" 'alchemist-help-search-at-point alchemist-mode-map)
  (bind-key "C-c C-a C-h C-h" 'alchemist-help alchemist-mode-map)
  (bind-key "C-c C-a C-h C-i" 'alchemist-help-history alchemist-mode-map)
  (bind-key "C-c C-a C-h C-r" 'alchemist-refcard alchemist-mode-map)
  (bind-key "C-c C-a C-e C-b" 'alchemist-execute-this-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-e C-e" 'alchemist-execute alchemist-mode-map)
  (bind-key "C-c C-a C-e C-f" 'alchemist-execute-file alchemist-mode-map)
  (bind-key "C-c C-a C-c C-b" 'alchemist-compile-this-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-c C-c" 'alchemist-compile alchemist-mode-map)
  (bind-key "C-c C-a C-c C-f" 'alchemist-compile-file alchemist-mode-map)
  (bind-key "C-c C-a C-m C-c" 'alchemist-mix-compile alchemist-mode-map)
  (bind-key "C-c C-a C-m C-r" 'alchemist-mix-run alchemist-mode-map)
  (bind-key "C-c C-a C-m C-t C-." 'alchemist-mix-test-at-point alchemist-mode-map)
  (bind-key "C-c C-a C-m C-t C-b" 'alchemist-mix-test-this-buffer alchemist-mode-map)
  (bind-key "C-c C-a C-m C-t C-f" 'alchemist-mix-test-file alchemist-mode-map)
  (bind-key "C-c C-a C-n C-R" 'alchemist-phoenix-routes alchemist-mode-map)
  (bind-key "C-c C-a C-n C-c" 'alchemist-phoenix-find-controllers alchemist-mode-map)
  (bind-key "C-c C-a C-n C-l" 'alchemist-phoenix-find-channels alchemist-mode-map)
  (bind-key "C-c C-a C-n C-m" 'alchemist-phoenix-find-models alchemist-mode-map)
  (bind-key "C-c C-a C-n C-r" 'alchemist-phoenix-router alchemist-mode-map)
  (bind-key "C-c C-a C-n C-s" 'alchemist-phoenix-find-static alchemist-mode-map)
  (bind-key "C-c C-a C-n C-t" 'alchemist-phoenix-find-templates alchemist-mode-map)
  (bind-key "C-c C-a C-n C-v" 'alchemist-phoenix-find-views alchemist-mode-map)
  (bind-key "C-c C-a C-n C-w" 'alchemist-phoenix-find-web alchemist-mode-map))

(use-package auto-complete
  :ensure t
  :init
  (global-auto-complete-mode)
  :config
  (setq ac-auto-show-menu 0.3
        ac-candidate-limit 15
        ac-delay 0.3)
  (bind-key "<return>" (lambda() (interactive) (ac-stop) (call-interactively (key-binding (kbd "C-m")))) ac-complete-mode-map)
  (bind-key "SPC" (lambda() (interactive) (ac-stop) (insert " ")) ac-complete-mode-map)
  (bind-key "C-m" (lambda() (interactive) (ac-stop) (newline)) ac-complete-mode-map)
  (bind-key ":" (lambda() (interactive) (ac-stop) (insert ":")) ac-complete-mode-map)
  (bind-key "." (lambda() (interactive) (ac-stop) (insert ".")) ac-complete-mode-map)
  (bind-key "C-p" 'ac-previous ac-complete-mode-map)
  (bind-key "M-j" 'yas/expand ac-complete-mode-map)
  (bind-key "C-n" 'ac-next ac-complete-mode-map))

(use-package beacon
  :ensure t
  :init
  (beacon-mode t)
  (add-to-list 'beacon-dont-blink-major-modes 'mu4e-compose-mode)
  (add-to-list 'beacon-dont-blink-major-modes 'mu4e-headers-mode)
  (add-to-list 'beacon-dont-blink-major-modes 'mu4e-main-mode))

(use-package cargo
  :ensure t)

(use-package clojure-mode
  :ensure t
  :config
  (bind-key "C-x C-e" 'cider-eval-last-sexp clojure-mode-map)
  (defun attic-clojure-hook ()
    (paredit-mode 1)
    (electric-pair-mode -1)
    (aggressive-indent-mode 1)
    (cider-mode 1)
    (setq-local helm-dash-docsets '("Clojure")))
  (add-hook 'clojure-mode-hook 'attic-clojure-hook))

(use-package clj-refactor
  :ensure t
  :config
  (defhydra cljr-refactor-all (:color blue)
    "[Clojure refactor]"
    ("c"  hydra-cljr-cljr-menu/body "cljr-menu")
    ("o"  hydra-cljr-code-menu/body "code-menu")
    ("h"  hydra-cljr-help-menu/body "help-menu")
    ("n"  hydra-cljr-ns-menu/body "ns-menu")
    ("p"  hydra-cljr-project-menu/body "project-menu")
    ("t"  hydra-cljr-toplevel-form-menu/body "toplevel-form-menu"))
  (cljr-add-keybindings-with-prefix "C-c C-m")
  (define-key clojure-mode-map (kbd "C-c C-a") 'cljr-refactor-all/body)
  (add-hook 'clojure-mode-hook #'clj-refactor-mode))

(use-package cljr-helm
  :ensure t
  :config
  (define-key clojure-mode-map (kbd "C-c C-l") 'cljr-helm))


(use-package cider
  :ensure t
  :config
  (add-hook 'cider-repl-mode-hook #'paredit-mode)
  (setq cider-auto-jump-to-error nil))

(use-package comint
  :config
  (setq tramp-default-method "ssh"          ; uses ControlMaster
        comint-scroll-to-bottom-on-input t  ; always insert at the bottom
        comint-scroll-to-bottom-on-output nil ; always add output at the bottom
        comint-scroll-show-maximum-output t ; scroll to show max possible output
        comint-completion-autolist t     ; show completion list when ambiguous
        comint-input-ignoredups t           ; no duplicates in command history
        comint-completion-addsuffix t       ; insert space/slash after file completion
        comint-buffer-maximum-size 20000    ; max length of the buffer in lines
        comint-prompt-read-only nil         ; if this is t, it breaks shell-command
        comint-get-old-input (lambda () "") ; what to run when i press enter on a
                                        ; line above the current prompt
        comint-input-ring-size 5000         ; max shell history size
        protect-buffer-bury-p nil)

  (defun make-my-shell-output-read-only (text)
    "Add to comint-output-filter-functions to make stdout read only in my shells."
    (interactive)
    (if (equal major-mode 'shell-mode)
        (let ((inhibit-read-only t)
              (output-end (process-mark (get-buffer-process (current-buffer)))))
          (put-text-property comint-last-output-start output-end 'read-only t))))
  (add-hook 'comint-output-filter-functions 'make-my-shell-output-read-only)
  (add-hook 'comint-output-filter-functions 'comint-truncate-buffer))

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.3)
  (setq company-minimum-prefix-length 1)
  (add-to-list 'company-backends 'company-elm)
  (bind-key "M-f" 'company-complete-selection company-active-map)
  (bind-key "<return>" (lambda() (interactive) (company-abort) (newline)) company-active-map)
  (bind-key "SPC" (lambda() (interactive) (company-abort) (insert " ")) company-active-map)
  (bind-key "C-m" (lambda() (interactive) (company-abort) (newline)) company-active-map)
  (bind-key ":" (lambda() (interactive) (company-abort) (insert ":")) company-active-map)
  (bind-key "." (lambda() (interactive) (company-abort) (insert ".")) company-active-map)
  (bind-key "M-h" 'helm-company company-active-map)
  (bind-key "M-j" 'yas/expand company-active-map)
  (bind-key "C-n" 'company-select-next company-active-map)
  (bind-key "C-p" 'company-select-previous company-active-map))

(use-package company-racer
  :ensure t)

(use-package dash
  :ensure t)

(use-package dired
  :config
  (require 'dired)
  (bind-key "c f" 'helm-ls-git-ls dired-mode-map)
  (bind-key "z" 'helm-buffers-list dired-mode-map)
  (bind-key "c m" 'magit-status dired-mode-map)
  (bind-key ";" 'attic-semi-colon/body dired-mode-map)
  (bind-key "c z" 'attic-make-map dired-mode-map))

(use-package doc-view
  :config
  (define-key doc-view-mode-map (kbd "j") 'doc-view-next-line-or-next-page)
  (define-key doc-view-mode-map (kbd "k") 'doc-view-previous-line-or-previous-page)
  (define-key doc-view-mode-map (kbd "l") 'image-forward-hscroll)
  (define-key doc-view-mode-map (kbd "h") 'image-backward-hscroll))

(use-package dockerfile-mode
  :ensure t)

(use-package elfeed
  :ensure t
  :config
  (setq elfeed-search-filter "@12-months-ago")
  (setq elfeed-feeds
        '("http://feeds.5by5.tv/changelog"
          "http://feeds.twit.tv/floss.xml"
          "http://thecommandline.net/cmdln"
          "http://cloudevangelist.jellycast.com/podcast/feed/123"))
  (bind-key "j" 'elfeed-open-in-emms elfeed-show-mode-map)
  (bind-key ";" 'attic-semi-colon/body elfeed-show-mode-map)
  (bind-key ";" 'attic-semi-colon/body elfeed-search-mode-map)
  (bind-key "z" 'helm-M-x elfeed-show-mode-map)
  (bind-key "z" 'helm-M-x elfeed-search-mode-map)
  (defun url-copy-file-to-path (url path)
    (let* ((file-name (car (last (split-string  url "/"))))
           (full-path (expand-file-name file-name path)))
      (unless (file-exists-p full-path)
        (url-copy-file url full-path))
      full-path))

  (defun elfeed-open-in-emms ()
    (interactive)
    (save-excursion
      (goto-char 1)
      (let ((done nil))
        (while (and (re-search-forward ".*mp3$" nil t)
                    (not done))
          (backward-char 1)
          (when (get-text-property (point) 'shr-url)
            (setq kill-ring (cdr kill-ring))
            (let* ((url (string-remove-prefix  "Copied " (shr-copy-url)))
                   (full-path (url-copy-file-to-path url "~/Podcasts/")))
              (emms-play-file full-path)
              (setq done t))))))))

(use-package elixir-mode
  :ensure t
  :config
  (defun attic-elixir-hook ()
    (electric-pair-mode)
    (auto-complete-mode 0)
    (paredit-mode 1)
    (setq tab-stop-list tab-stop-list-2)
    (company-mode)
    (alchemist-mode)
    (setq-local helm-dash-docsets '("Elixir")))
  (add-hook 'elixir-mode-hook 'attic-elixir-hook))

(use-package elm-mode
  :ensure t
  :config
  (defun elm-reactor ()
    (interactive)
    (async-shell-command "elm-reactor" "*elm-reactor*"))
  (defun attic-elm-hook ()
    (add-hook 'elm-mode-hook #'elm-oracle-setup-completion)
    (company-mode)
    (electric-pair-mode))
  (add-hook 'elm-mode-hook 'attic-elm-hook))

(use-package elscreen
  :ensure t
  :init
  (elscreen-start)
  (defun elscreen-create-initial-5-screens ()
    (interactive)
    (elscreen-kill-others)
    (elscreen-create) (elscreen-create) (elscreen-create)
    (elscreen-create) (elscreen-create) (elscreen-kill 0)
    (elscreen-goto 1))
  (elscreen-create-initial-5-screens)
  :config
  (defun elscreen-goto-template (num)
    `(defun ,(read  (concat "elscreen-goto-" (number-to-string num))) ()
       ,(concat "Go to elscreen workspace " (number-to-string num) ".")
       (interactive)
       (elscreen-goto ,num)))

  (defmacro elscreen-goto-workspace-list (&rest nums)
    (let ((forms (mapcar 'elscreen-goto-template nums)))
      `(progn ,@forms)))

  (elscreen-goto-workspace-list 1 2 3 4 5 6 7 8 9)
  (setq elscreen-display-screen-number nil
        elscreen-prefix-key nil
        elscreen-tab-display-control nil
        elscreen-tab-display-kill-screen nil))

(use-package emms
  :ensure t
  :init
  (when (and (file-exists-p "~/Music/")
             (>  (length (directory-files "~/Music/")) 2))
    (emms-standard)
    (emms-default-players)
    (emms-add-directory-tree "~/Music/")
    (emms-toggle-repeat-playlist)
    (emms-shuffle)
    (emms-playing-time-enable-display))
  :config
  (setq emms-setup-default-player-list '(emms-player-vlc)
        emms-volume-change-amount 5))

(use-package erc
  :config
  (erc-truncate-mode 1)
  (erc-scrolltobottom-mode 1)
  (setq erc-nick "kwrooijen")
  (setq erc-prompt-for-password nil)
  (setq erc-ignore-list '("*Flowdock*" "Flowdock" "-Flowdock-"))
  (setq erc-hide-list '("JOIN" "PART" "QUIT"))
  (bind-key "" 'function erc-mode-map)
  (bind-key "C-M-m" 'erc-send-current-line erc-mode-map)
  (bind-key "RET" (lambda() (interactive) (message "Use C-M-m to send")) erc-mode-map)
  (add-hook 'erc-mode-hook 'toggle-modeline))

(use-package erlang
  :ensure t
  :config
  (setq inferior-erlang-machine-options '("-sname" "emacs"))
  (bind-key "M-/" 'erlang-get-error erlang-mode-map)
  (bind-key "C-c C-k"
            (lambda() (interactive)
              (inferior-erlang)
              (split-window)
              (other-window 1)
              (other-window -1)) erlang-mode-map)
  (bind-key "M-n" 'highlight-symbol-next erlang-mode-map)
  (bind-key "M-p" 'highlight-symbol-prev erlang-mode-map)
  (bind-key "M-n" 'highlight-symbol-next erlang-mode-map)
  (bind-key "M-p" 'highlight-symbol-prev erlang-mode-map)
  (bind-key ">"   (lambda() (interactive) (insert ">")) erlang-mode-map)

  (defun flymake-erlang-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy 'flymake-create-temp-intemp))
           (local-file (file-relative-name temp-file (file-name-directory buffer-file-name))))
      (list "~/.emacs.d/scripts/erlang/erlang-flymake" (list local-file))))

  (defun erlang-get-error ()
    (interactive)
    (async-shell-command
     (format "~/.emacs.d/scripts/erlang/erlang-flymake %s" buffer-file-name) "[Erlang Errors]"))

  (defun attic-erlang-hook ()
    (if (not (is-tramp-mode))
        (progn
          (flymake-erlang-init)
          (flymake-mode 1)))
    (electric-pair-mode)
    (fix-tabs 4)
    (auto-complete-mode 1)
    (setq-local helm-dash-docsets '("Erlang")))
  (add-hook 'erlang-mode-hook 'attic-erlang-hook))

(use-package eshell
  :init
  (defun eshell-broadcast(&optional yank-eshell-input)
    (interactive)
    (if (or eshell-mode (equal major-mode 'shell-mode))
        (let ((buff (get-buffer-window))
              (col (current-column)))
          (eshell-bol)
          (setq eshell-indentation-column (point))
          (move-end-of-line 1)
          (setq eshell-oel-column (point))
          (kill-ring-save eshell-indentation-column eshell-oel-column)
          (move-to-column col)
          (if eshell-mode (unless yank-eshell-input (eshell-send-input))
            (unless yank-eshell-input (comint-send-input)))
          (other-window 1)
          (while (not (eq (get-buffer-window) buff))
            (if (or eshell-mode (equal major-mode 'shell-mode))
                (progn
                  (end-of-buffer)
                  (yank)
                  (if eshell-mode (unless yank-eshell-input (eshell-send-input))
                    (unless yank-eshell-input (comint-send-input)))))
            (other-window 1)))))

  (defun eshell-broadcast-diff()
    (interactive)
    (let ((buff-win (get-buffer-window))
          (buff (current-buffer)))
      (other-window 1)
      (while (not (eq (get-buffer-window) buff-win))
        (if (or eshell-mode (equal major-mode 'shell-mode))
            (progn
              (highlight-changes-mode -1)
              (highlight-compare-buffers buff (current-buffer))))
        (sleep-for 0.1)
        (end-of-buffer)
        (recenter-top-bottom (window-height))
        (other-window 1))
      (highlight-changes-mode -1)
      (recenter-top-bottom (window-height))))

  (defun attic-eshell-hook ()
    (bind-key "M-p" 'eshell-previous-input eshell-mode-map)
    (bind-key "M-n" 'eshell-next-input eshell-mode-map)
    (bind-key "C-i" 'helm-esh-pcomplete eshell-mode-map)
    (bind-key "M-m" 'eshell-bol eshell-mode-map)
    (bind-key "C-M-m" 'eshell-broadcast eshell-mode-map))
  (add-hook 'eshell-mode-hook 'attic-eshell-hook))

(when (equal mode-lock 'evil)
  (use-package evil
    :ensure t
    :config
    (define-key evil-normal-state-map (kbd "<SPC>") 'attic-semi-colon/body)
    (define-key evil-normal-state-map (kbd "[") 'evil-bracket-open)
    (define-key evil-normal-state-map (kbd "]") 'evil-bracket-close)
    (defun evil-bracket-open ()
      (interactive)
      (if (member major-mode '(scheme-mode emacs-lisp-mode))
          (evil-lispy/enter-state-left)))
    (defun evil-bracket-close ()
      (interactive)
      (if (member major-mode '(scheme-mode emacs-lisp-mode))
          (evil-lispy/enter-state-right))))

  (use-package evil-paredit
    :ensure t
    :config
    (evil-paredit-mode))
  (use-package evil-lispy
    :ensure t
    :config
    (add-hook 'scheme-mode-hook 'evil-lispy-mode)
    (add-hook 'emacs-lisp-mode-hook 'evil-lispy-mode)))

(use-package eww
  :config
  (bind-key "n" (lambda() (interactive) (scroll-up 1)) eww-mode-map)
  (bind-key "p" (lambda() (interactive) (scroll-down 1)) eww-mode-map)
  (bind-key "v" 'scroll-up-command eww-mode-map))

(use-package expand-region
  :ensure t
  :init
  (bind-key "M-@" 'er/expand-region attic-mode-map))

(use-package flycheck-rust
  :ensure t)

(use-package flyspell
  :config
  (define-key flyspell-mode-map (kbd "C-;") 'attic-semi-colon/body))

(use-package geiser
  :ensure t
  :config
  (defun evil-geiser-eval-last-sexp ()
    (interactive)
    (save-excursion
      (forward-char 1)
      (geiser-eval-last-sexp nil)))
  (defun attic-geiser-hook ()
    (define-key geiser-mode-map (kbd "M-.") 'find-tag)
    (define-key geiser-mode-map (kbd "C-x C-e") 'evil-geiser-eval-last-sexp)
    (paredit-mode 1))
  (add-hook 'geiser-mode-hook 'attic-geiser-hook)
  (add-hook 'geiser-repl-mode-hook 'attic-geiser-hook))

(use-package gist
  :ensure t)

(use-package git-gutter+
  :ensure t
  :config
  (global-git-gutter+-mode t))

(use-package git-gutter-fringe+
  :ensure t
  :config
  (global-git-gutter+-mode t))

(when (equal mode-lock 'god)
  (use-package god-mode
    :ensure t
    :ensure hydra
    :config
    (defun god-repeater--set-hydra-function (var)
      `(defhydra ,(make-symbol (concat "hydra-god-repeater-" var))
         (god-local-mode-map "g")
         "God repeater"
         (,var (call-interactively (key-binding (kbd ,(concat "M-" var))))
               ,(let ((function-name (format "%s" (lookup-key
                                                   (current-global-map)
                                                   (kbd (concat "M-" var))))))
                  (if (> (length function-name) 50)
                      (concat "M-" var)
                    function-name)))))

    (defmacro god-repeater--set-characters (&rest vars)
      (let ((forms (mapcar 'god-repeater--set-hydra-function vars)))
        `(progn ,@forms)))

    (god-repeater--set-characters
     "q" "w" "e" "r" "t" "y" "u" "i" "o"
     "p" "a" "s" "d" "f" "g" "h" "j" "k"
     "l" "z" "x" "c" "v" "b" "n" "m"
     "1" "2" "3" "4" "5" "6" "7" "8" "9"
     "0" "!" "@" "#" "$" "%" "^" "&" "*"
     "(" ")" "_" "+" "{" "}" "|" ":" "\""
     "<" ">" "?" "-" "=" "[" "]" ";" "'"
     "\\" "," "." "/" "`" "~")

    ;; Special cases
    (defhydra hydra-god-repeater-g (god-local-mode-map "g") ("g" goto-line))
    (defhydra hydra-god-repeater-G (god-local-mode-map "g") ("G" goto-line))

    (god-mode)
    (bind-key "i" (lambda () (interactive) (god-local-mode -1)) god-local-mode-map)
    (bind-key "u" 'undo god-local-mode-map)
    (bind-key "h" 'ace-jump-mode god-local-mode-map)
    (bind-key "M-u" 'redo god-local-mode-map)
    (bind-key "J" '(lambda () (interactive) (join-line -1)) god-local-mode-map)
    (bind-key "/" 'attic/comment god-local-mode-map)
    (when (equal key-setup 'hybrid)
      (define-key god-local-mode-map (kbd "SPC") 'mp/goto-lot-position)
      (define-key god-local-mode-map (kbd "h") 'backward-char)
      (define-key god-local-mode-map (kbd "j") 'next-line)
      (define-key god-local-mode-map (kbd "k") 'previous-line)
      (define-key god-local-mode-map (kbd "l") 'forward-char)
      (define-key god-local-mode-map (kbd "f") 'iy-go-up-to-char)
      (define-key god-local-mode-map (kbd "F") 'iy-go-to-char-backward)
      (define-key god-local-mode-map (kbd "T") 'iy-go-to-char-backward)
      (define-key god-local-mode-map (kbd "b") 'backward-word)
      (define-key god-local-mode-map (kbd "p") 'yank)
      (define-key god-local-mode-map (kbd "P") 'yank-pop-or-kill-ring)
      (define-key god-local-mode-map (kbd "y") 'kill-ring-save)
      (define-key god-local-mode-map (kbd "n") 'undefined)
      (define-key god-local-mode-map (kbd "v") 'set-mark-command)
      (define-key god-local-mode-map (kbd "w") 'forward-word)
      (define-key god-local-mode-map (kbd "$") 'move-end-of-line)
      (define-key god-local-mode-map (kbd "0") 'move-beginning-of-line)

      (define-key god-local-mode-map (kbd "e") 'paredit-forward)
      (define-key god-local-mode-map (kbd "E") 'paredit-backward)

      (define-key god-local-mode-map (kbd "r") 'replace-char)
      (define-key god-local-mode-map (kbd "s") 'delete-char-and-insert)
      (define-key god-local-mode-map (kbd "a") 'forward-char-and-insert)
      (define-key god-local-mode-map (kbd "A") 'move-end-of-line-and-insert)
      (define-key god-local-mode-map (kbd "o") 'vim-o)
      (define-key god-local-mode-map (kbd "O") 'vim-O)
      (define-key god-local-mode-map (kbd "d") 'compose-delete)
      (define-key god-local-mode-map (kbd "D") 'safe-kill-line)
      (define-key god-local-mode-map (kbd "C") 'compose-replace)
      (define-key god-local-mode-map (kbd "Q") 'kmacro-start-macro)
      (define-key god-local-mode-map (kbd "q") 'kmacro-end-or-call-macro-repeat))

    (defun my-update-cursor ()
      (setq cursor-type (if (or god-local-mode buffer-read-only)
                            'box
                          'bar)))

    (add-hook 'god-mode-enabled-hook 'my-update-cursor)
    (add-hook 'god-mode-disabled-hook 'my-update-cursor)

    (add-hook 'sh-mode-hook 'attic-lock)
    (add-hook 'sql-mode-hook 'attic-lock)
    (add-hook 'makefile-gmake-mode-hook 'attic-lock)
    (add-hook 'python-mode-hook 'attic-lock)
    (add-hook 'yaml-mode-hook 'attic-lock)
    (add-hook 'dockerfile-mode-hook 'attic-lock)
    (add-hook 'markdown-mode-hook 'attic-lock)
    (add-hook 'clojure-mode-hook 'attic-lock)

    (add-to-list 'god-exempt-major-modes 'elfeed-show-mode)
    (add-to-list 'god-exempt-major-modes 'elfeed-search-mode)
    (add-to-list 'god-exempt-major-modes 'gnus-summary-mode)
    (add-to-list 'god-exempt-major-modes 'gnus-group-mode)
    (add-to-list 'god-exempt-major-modes 'term-mode)
    (add-to-list 'god-exempt-major-modes 'help-mode)
    (add-to-list 'god-exempt-major-modes 'grep-mode)
    (add-to-list 'god-exempt-major-modes 'doc-view-mode)
    (add-to-list 'god-exempt-major-modes 'top-mode)
    (add-to-list 'god-exempt-major-modes 'dired-mode)
    (add-to-list 'god-exempt-major-modes 'magit-status-mode)
    (add-to-list 'god-exempt-major-modes 'magit-revision-mode)
    (add-to-list 'god-exempt-major-modes 'mu4e-main-mode)
    (add-to-list 'god-exempt-major-modes 'mu4e-headers-mode)
    (add-to-list 'god-exempt-major-modes 'mu4e-view-mode)
    (add-to-list 'god-exempt-major-modes 'twittering-mode)))

(use-package grep
  :config
  (bind-key "n" 'next-line grep-mode-map)
  (bind-key "p" 'previous-line grep-mode-map)
  (bind-key "TAB" (lambda() (interactive) (error-preview "*grep*")) grep-mode-map)
  (bind-key "v" 'scroll-up-command grep-mode-map)
  (bind-key ";" 'attic-semi-colon/body grep-mode-map)
  (bind-key ";" 'attic-semi-colon/body grep-mode-map)
  (bind-key "z" 'helm-buffers-list grep-mode-map))

(use-package hackernews
  :ensure t)

(use-package haskell-mode
  :ensure t
  :config
  (defun run-haskell-test ()
    (interactive)
    (my-up-to-script "*.cabal" "cabal build ; cabal test --log=/dev/stdout" "[Haskell Tests]"))

  (defun hoogle-search (query)
    "Search with hoogle commandline"
    (interactive "sHoogle query: ")
    (if (get-buffer "*Hoogle*") (kill-buffer "*Hoogle*"))
                                        ; get the version of hoogle so
                                        ; I don't have to manually
                                        ; adjust it for each update
    (shell-command
     (format "version=`hoogle --version | head -n 1
        | awk '{print $2}' | cut -c 2- | rev | cut -c 2- | rev`;
        data=\"/databases\"; two=$version$data; hoogle \"%s\"
        --data=$HOME/.lazyVault/sandboxes/hoogle/cabal/share/hoogle-$two"
             query))
    (switch-to-buffer "*Shell Command Output*")
    (rename-buffer "*Hoogle*")
    (haskell-mode)
    (previous-buffer))

  (defun attic-haskell-hook ()
    (electric-pair-mode)
    (turn-on-haskell-doc-mode)
    (turn-on-haskell-indentation)
    (setq-local helm-dash-docsets '("Haskell")))
  (add-hook 'haskell-mode-hook 'attic-haskell-hook))

(use-package helm
  :ensure t
  :config
  (setq
   ;; truncate long lines in helm completion
   helm-truncate-lines t
   ;; may be overridden if 'ggrep' is in path (see below)
   helm-grep-default-command "grep -a -d skip %e -n%cH -e %p %f"
   helm-grep-default-recurse-command "grep --exclude-dir=\"dist\" -a -d recurse %e -n%cH -e %p %f"
   ;; do not display invisible candidates
   helm-quick-update t
   ;; be idle for this many seconds, before updating in delayed sources.
   helm-idle-delay 0.01
   ;; be idle for this many seconds, before updating candidate buffer
   helm-input-idle-delay 0.01
   ;; open helm buffer in another window
   helm-split-window-default-side 'other
   ;; limit the number of displayed canidates
   helm-candidate-number-limit 200
   ;; don't use recentf stuff in helm-ff
   helm-ff-file-name-history-use-recentf nil
   ;; fuzzy matching
   helm-buffers-fuzzy-matching t
   helm-semantic-fuzzy-match t
   helm-imenu-fuzzy-match t
   helm-completion-in-region-fuzzy-match t
   helm-echo-input-in-header-line t
   ;; Don't ask to create new file
   helm-ff-newfile-prompt-p nil
   helm-reuse-last-window-split-state t
   helm-ff-transformer-show-only-basename nil
   ;; Split window down
   helm-split-window-in-side-p t
   ;; Split when multiple windows open
   helm-swoop-split-with-multiple-windows t
   ;; Show relative path
   helm-ls-git-ls-show-abs-or-relative 'relative
   ;; Don't show colors in Tramp mode
   helm-ff-tramp-not-fancy t
   ;; Smarter completion for Helm
   helm-ff-smart-completion t
   ;; Helm-dash should use W3m for showing documentation
   helm-dash-browser-func 'eww
   ;; Don't add delay when choosing
   helm-exit-idle-delay 0
   ;; Don't display header
   helm-display-header-line nil
   ;; Set a min / max height of 30% of current buffer
   helm-autoresize-max-height 30
   helm-autoresize-min-height 30
   helm-bookmark-show-location t
   helm-always-two-windows t
   helm-imenu-execute-action-at-once-if-one nil)
  ;; Try to hide source header as much as possible
  (set-face-attribute 'helm-source-header nil :height 0.1 :background "#000"  :foreground "#000")

  ;; Work around for the [Display not ready] error when typing too awesomely fast
  (defun my/helm-exit-minibuffer ()
    (interactive)
    (helm-exit-minibuffer))
  (eval-after-load "helm"
    '(progn
       (define-key helm-map (kbd "<RET>") 'my/helm-exit-minibuffer)))

  (define-key attic-mode-map (kbd "M-[") 'helm-resume)
  (define-key attic-mode-map (kbd "M-x") 'helm-M-x)
  (define-key helm-map (kbd "C-b") 'nil)
  (define-key helm-map (kbd "C-f") 'nil)
  (define-key helm-map (kbd "M-b") 'nil)
  (define-key helm-map (kbd "M-f") 'forward-word)
  (define-key helm-map (kbd "M-s") 'helm-select-action)
  (define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "M-?") 'helm-help)
  (defhydra helm-like-unite ()
    ("q" keyboard-escape-quit "exit")
    ("<spc>" helm-toggle-visible-mark "mark")
    ("a" helm-toggle-all-marks "(un)mark all")
    ("v" helm-execute-persistent-action)
    ("g" helm-beginning-of-buffer "top")
    ("h" helm-previous-source)
    ("l" helm-next-source)
    ("G" helm-end-of-buffer "bottom")
    ("j" helm-next-line "down")
    ("J" helm-next-source "down source")
    ("K" helm-prev-source "up source")
    ("k" helm-previous-line "up")
    ("i" nil "cancel"))
  (key-chord-define helm-map "jh" 'helm-like-unite/body)

  (defun helm-hide-minibuffer-maybe ()
    (when (with-helm-buffer helm-echo-input-in-header-line)
      (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
        (overlay-put ov 'window (selected-window))
        (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
                                `(:background ,bg-color :foreground ,bg-color)))
        (setq-local cursor-type nil))))
  (add-hook 'helm-minibuffer-set-up-hook 'helm-hide-minibuffer-maybe))

(use-package helm-dash
  :ensure t
  :init
  (bind-key "C-c C-s C-d" 'helm-dash attic-mode-map))

(use-package helm-descbinds
  :ensure t)

(use-package helm-ls-git
  :ensure t)

(use-package helm-projectile
  :ensure t
  :config
  (setq projectile-use-git-grep t)
  :init
  (projectile-global-mode 1))

(use-package helm-swoop
  :ensure t
  :config
  (define-key helm-swoop-map (kbd "M-e") 'helm-swoop-edit)
  :init
  (bind-key "C-c C-s C-s" 'helm-multi-swoop attic-mode-map)
  (bind-key "C-c C-s C-f" 'helm-swoop-find-files-recursively attic-mode-map))

(use-package highlight-numbers
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'highlight-numbers-mode))

(use-package highlight-symbol
  :ensure t
  :config
  ;; Highlight delay for multiple occurences
  (setq highlight-symbol-idle-delay 0))

(use-package hl-defined
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook 'hdefd-highlight-mode)
  (add-hook 'scheme-mode-hook 'hdefd-highlight-mode)
  (add-hook 'clojure-mode-hook 'hdefd-highlight-mode)
  (setq hdefd-highlight-type 'functions)
  (set-face-attribute 'hdefd-functions nil :inherit 'font-lock-function-name-face))

(use-package hydra
  :ensure t
  :config
  (defhydra attic-emms (:color red)
    "EMMS"
    ("a" emms-pause "Pause")
    ("g" emms-playlist-mode-go "Playlist")
    ("n" emms-next "Next")
    ("p" emms-previous "Previous")
    ("]" emms-volume-raise "+")
    ("[" emms-volume-lower "-")
    ("f" emms-seek-forward "f")
    ("b" emms-seek-backward "b")
    ("q" nil "Quit" :color blue)))

(use-package indy
  :ensure t)

(use-package iy-go-to-char
  :ensure t)

(use-package jazz-theme
  :ensure t)

(use-package js2-mode
  :ensure t)

(use-package key-chord
  :ensure t
  :init
  (key-chord-mode t)
  :config
  (key-chord-define-global "xs" '(lambda ()
                                   (interactive)
                                   (attic-lock)
                                   (save-buffer)))

  (key-chord-define helm-map ";j" 'helm-keyboard-quit)
  (when (equal mode-lock 'god)
    (key-chord-define-global ";j" 'attic-lock)
    (key-chord-define attic-mode-map ";j" 'attic-lock))
  (when (equal mode-lock 'evil)
    (key-chord-define-global ";j" 'evil-force-normal-state)
    (key-chord-define attic-mode-map ";j" 'evil-force-normal-state))
  (key-chord-define isearch-mode-map ";j" 'isearch-abort))

(use-package linum
  :config
  ;; Always display 2 columns in linum mode (no stuttering)
  (setq linum-format (quote "%3d"))
  (setq linum-disabled-modes-list
        '(mu4e-compose-mode
          mu4e-headers-mode
          mu4e-main-mode)))

(use-package lispy
  :ensure t)

(use-package macrostep
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package magit
  :ensure t
  :config
  (bind-key "g" 'magit-refresh magit-status-mode-map)
  (bind-key ";" 'attic-semi-colon/body magit-status-mode-map)
  (bind-key ";" 'attic-semi-colon/body magit-revision-mode-map)
  (setq magit-last-seen-setup-instructions "1.4.0"))

(use-package mu4e
  :config
  (require 'smtpmail)
  (define-key mu4e-main-mode-map (kbd "p") 'previous-line)
  (define-key mu4e-main-mode-map (kbd "n") 'next-line)
  (define-key mu4e-main-mode-map (kbd "z") 'helm-buffers-list)
  (define-key mu4e-main-mode-map (kbd "v") 'scroll-up-command)
  (define-key mu4e-headers-mode-map (kbd ";") 'attic-semi-colon/body)
  (define-key mu4e-headers-mode-map (kbd "v") 'scroll-up-command)
  (define-key mu4e-view-mode-map (kbd ";") 'attic-semi-colon/body)
  (define-key mu4e-view-mode-map (kbd "f") 'epa-mail-verify)
  (define-key mu4e-view-mode-map (kbd "v") 'scroll-up-command)
  (define-key mu4e-compose-mode-map (kbd "M-s") 'mml-secure-sign-pgp)
  (setq message-send-mail-function 'smtpmail-send-it
        mu4e-get-mail-command "offlineimap"
        mu4e-maildir (expand-file-name "~/Mail")
        starttls-use-gnutls t
        smtpmail-starttls-credentials '(("mail.hover.com" 587 nil nil))
        smtpmail-default-smtp-server "mail.hover.com"
        smtpmail-smtp-server "mail.hover.com"
        smtpmail-smtp-service 587
        smtpmail-debug-info t
        mu4e-update-interval 60
        message-kill-buffer-on-exit t
        mu4e-hide-index-messages t
        ;; Requires html2text package
        mu4e-html2text-command "html2text -utf8 -width 72"
        mu4e-view-show-images t))

(use-package mu4e-alert
  :ensure t
  :init
  (mu4e-alert-enable-mode-line-display))

(use-package mu4e-maildirs-extension
  :ensure t
  :init
  (mu4e-maildirs-extension))

(use-package org
  :config
  (when (file-exists-p "~/Documents/notes/Org")
    (setq org-log-done 'time
          org-capture-templates '()
          org-src-fontify-natively t)
    (setq org-capture-templates
          '(("1" "Done" entry
             (file+headline "~/Documents/notes/Org/Done.org" "Done")
             (file "~/.emacs.d/Templates/Done.orgtpl"))
            ("2" "Retro" entry
             (file+headline "~/Documents/notes/Org/Retro.org" "Done")
             (file "~/.emacs.d/Templates/Retro.orgtpl"))
            ("3" "Todo" entry
             (file+headline "~/Documents/notes/Org/Todo.org" "Todo")
             (file "~/.emacs.d/Templates/Todo.orgtpl"))))
    (defun add-my-todos-to-org (list)
      "Adds All the files in Todo directory to my list of todo subjects."
      (let ((c 0)
            (r '()))
        (while (nth c list)
          (let ((key (char-to-string (+ c 97)))
                (val (nth c list)))
            (add-to-list 'org-capture-templates
                         `(,key ,val entry
                                (file+headline ,(concat "~/Documents/notes/Org/Todo/" val) ,val)
                                (file "~/.emacs.d/Templates/GenericTodo.orgtpl")))
            (setq c (+ c 1))))))

    (defun org-keys-hook ()
      (define-prefix-command 'org-mode-custom-map)
      (define-key org-mode-map (kbd "C-c C-o") 'org-mode-custom-map)
      (define-key org-mode-custom-map (kbd "C-l") 'browse-url-at-point)
      (define-key org-mode-custom-map (kbd "C-t") 'org-todo))
    (add-my-todos-to-org
     (directory-files
      (expand-file-name "~/Documents/notes/Org/Todo")
      nil
      "^\\([^#|^.]\\|\\.[^.]\\|\\.\\..\\)"))
    (add-hook 'org-mode-hook 'org-keys-hook)))

(use-package paredit
  :ensure t
  :config
  (define-key paredit-mode-map (kbd "C-w") 'paredit-kill-region)
  (define-key paredit-mode-map (kbd "M-R") 'paredit-splice-sexp-killing-backward)
  (define-key paredit-mode-map (kbd "C-j") 'iy-go-up-to-char)
  (define-key paredit-mode-map (kbd "C-c C-r") 'paredit-reindent-defun)
  (define-key paredit-mode-map (kbd "C-q") 'paredit-backward-delete)
  (define-key paredit-mode-map (kbd "M-q") 'paredit-backward-kill-word)
  (define-key paredit-mode-map (kbd "C-c C-p") 'maybe-paredit-copy-sexp-up)
  (define-key paredit-mode-map (kbd "C-c C-n") 'maybe-paredit-copy-sexp-down)

  (setq ignore-paredit-copy '(elixir-mode erlang-mode))

  (defun maybe-paredit-copy-sexp-down ()
    (interactive)
    (if (member major-mode ignore-paredit-copy)
        (copy-line-down)
      (paredit-copy-sexp-down)))

  (defun maybe-paredit-copy-sexp-up ()
    (interactive)
    (if (member major-mode ignore-paredit-copy)
        (copy-line-up)
      (paredit-copy-sexp-up)))

  (when (equal mode-lock 'evil)
    (add-hook 'paredit-mode-hook 'evil-paredit-mode))
  (when (equal mode-lock 'god)
    (bind-key ";"
              (lambda ()
                (interactive)
                (if god-local-mode
                    (attic-semi-colon/body)
                  (paredit-semicolon)))
              paredit-mode-map)
    (define-key paredit-mode-map (kbd ")")
      (lambda () (interactive)
        (if god-local-mode
            (call-interactively (key-binding (kbd "C-)")))
          (paredit-close-round))))
    (define-key paredit-mode-map (kbd "(")
      (lambda () (interactive)
        (if (or (not god-local-mode) (region-active-p))
            (paredit-open-round)
          (call-interactively
           (key-binding (kbd "C-(")))))))

  (defun paredit-copy-sexp-down ()
    (interactive)
    (let ((prev-column (current-column)))
      (paredit-forward)
      (paredit-backward)
      (kill-sexp)
      (yank)
      (paredit-newline)
      (yank)
      (paredit-reindent-defun)
      (paredit-backward)
      (move-to-column prev-column)))

  (defun paredit-copy-sexp-up ()
    (interactive)
    (let ((prev-column (current-column)))
      (paredit-forward)
      (paredit-backward)
      (kill-sexp)
      (yank)
      (paredit-backward)
      (let ((copy-indent (current-column)))
        (beginning-of-line)
        (open-line 1)
        (insert (make-string copy-indent 32))
        (yank)
        (paredit-reindent-defun)
        (paredit-backward)
        (move-to-column prev-column)))))

(use-package powerline
  :ensure t
  :config
  (setq powerline-default-separator 'wave))

(use-package racer
  :ensure t
  :config
  ;; Set path to racer binary
  (setq racer-cmd "/usr/local/bin/racer")
  ;; Set path to rust src directory
  (setq racer-rust-src-path "/usr/local/src/rust/src/"))

(use-package racket-mode
  :ensure t
  :config
  (defun attic-racket-hook ()
    (paredit-mode 1))
  (add-hook 'racket-mode-hook 'attic-racket-hook))

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'scheme-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'racket-mode-hook #'rainbow-delimiters-mode))

(use-package redo+
  :ensure t
  :init
  (bind-key "M-_" 'redo attic-mode-map))

(use-package ruby-mode
  :config
  ;; Don't use deep indent in Ruby
  (setq ruby-deep-indent-paren nil)

  (defun attic-ruby-hook ()
    (electric-pair-mode)
    (setq-local helm-dash-docsets '("Ruby")))
  (add-hook 'ruby-mode-hook 'attic-ruby-hook))

(use-package rust-mode
  :ensure t
  :config
  (add-hook 'rust-mode-hook 'cargo-minor-mode)
  (defun attic-rust-hook ()
    (racer-mode)
    ;; Hook in racer with eldoc to provide documentation
    (racer-turn-on-eldoc)
    ;; Use company-racer in rust mode
    (set (make-local-variable 'company-backends) '(company-racer))
    ;; Key binding to jump to method definition
    (local-set-key (kbd "M-.") #'racer-find-definition)
    (electric-pair-mode)
    (setq-local tab-width 4)
    (setq-local helm-dash-docsets '("Rust"))
    (company-mode)
    (auto-complete-mode -1))
  (add-hook 'rust-mode-hook 'attic-rust-hook))

(use-package s
  :ensure t)

(use-package scheme
  :config
  (defun attic-scheme-mode-hook ()
    (paredit-mode 1)
    (company-mode t)
    (auto-complete-mode -1)
    (aggressive-indent-mode))
  (add-hook 'scheme-mode-hook 'attic-scheme-mode-hook))

(use-package scheme-complete
  :ensure t
  :config
  (eval-after-load 'scheme
    '(define-key scheme-mode-map "\t" 'scheme-complete-or-indent))
  (autoload 'scheme-get-current-symbol-info "scheme-complete" nil t)
  (add-hook 'scheme-mode-hook
            (lambda ()
              (make-local-variable 'eldoc-documentation-function)
              (setq eldoc-documentation-function 'scheme-get-current-symbol-info)
              (eldoc-mode))))

(use-package spacemacs-theme
  :ensure t)

(use-package swiper
  :ensure t)

(use-package string-edit
  :ensure t)

(use-package term
  :config
  (defun attic-term-hook ()
    (setq yas-dont-activate t))
  (add-hook 'term-mode-hook 'attic-term-hook)
  (add-hook 'ansi-term-mode-hook 'attic-term-hook))

(use-package toml-mode
  :ensure t
  :config
  (add-hook 'toml-mode-hook 'cargo-minor-mode))

(use-package transpose-mark
  :ensure t)

(use-package twittering-mode
  :ensure t
  :config
  (setq twittering-icon-mode t
        ;; Use master password for twitter instead of authenticating every time
        twittering-cert-file "/etc/ssl/certs/ca-bundle.crt"
        twittering-use-master-password t
        twittering-convert-fix-size 24)
  (bind-key "s" 'twittering-search twittering-mode-map)
  (bind-key ";" 'attic-semi-colon/body twittering-mode-map)
  (bind-key "q" (lambda () (interactive) (switch-to-buffer nil)) twittering-mode-map)
  (bind-key "w" 'delete-window twittering-mode-map)
  (add-hook 'twittering-mode-hook 'toggle-modeline))

(use-package vi-tilde-fringe
  :ensure t
  :init
  (global-vi-tilde-fringe-mode 1))

(use-package web-mode
  :ensure t
  :config
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4))

(use-package window-numbering
  :ensure t
  :init
  (window-numbering-mode t))

(use-package winner
  :config
  (winner-mode t)
  ;; Buffers to be ignored by Winner
  (setq winner-boring-buffers
        '("*Completions*"
          "*Compile-Log*"
          "*inferior-lisp*"
          "*Fuzzy Completions*"
          "*Apropos*"
          "*dvc-error*"
          "*Help*"
          "*cvs*"
          "*Buffer List*"
          "*Ibuffer*")))

(use-package wisp-mode
  :ensure t
  :config
  (defun attic-wisp-hook ()
    (paredit-mode 1)
    (electric-pair-mode -1)
    (aggressive-indent-mode -1))
  (add-hook 'wisp-mode-hook 'attic-wisp-hook))

(use-package wrap-region
  :ensure t)

(use-package ws-butler
  :ensure t
  :init
  (ws-butler-global-mode)
  :config
  ;; Disable aftersave
  (defun ws-butler-after-save ()))

(use-package yaml-mode
  :ensure t)

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode t)
  (add-hook 'snippet-mode-hook
            (lambda ()
              (setq-local require-final-newline nil))))

(if window-system
    (require 'git-gutter-fringe+)
  (require 'git-gutter+))

;;;; TODO require emacs lisp?
(defun attic-emacs-lisp-hook ()
  (aggressive-indent-mode)
  (paredit-mode 1)
  (setq-local helm-dash-docsets '("Emacs Lisp")))

(add-hook 'emacs-lisp-mode-hook 'attic-emacs-lisp-hook)

;; Modes
(display-battery-mode t)
(show-paren-mode t)
(wrap-region-global-mode t)
(electric-pair-mode t)

(provide 'attic-packages)
