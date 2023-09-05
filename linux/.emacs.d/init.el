; PACKAGE INSTALLER (melpa)
(require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

; PACKAGES
(use-package all-the-icons              ; Needed by doom-modeline
  :ensure t)

(use-package autothemer                 ; Needed by kanagawa.el
  :ensure t)

;; keep the cursor centered to avoid sudden scroll jumps
(use-package centered-cursor-mode
  :ensure t
  :config
  ;; disable in terminal modes
  ;; also disable in Info mode, because it breaks going back with the backspace key
  (define-global-minor-mode my-global-centered-cursor-mode centered-cursor-mode
    (lambda ()
      (when (not (memq major-mode
                       (list 'Info-mode 'term-mode 'eshell-mode 'shell-mode 'erc-mode)))
        (centered-cursor-mode))))
  (my-global-centered-cursor-mode 1))

(use-package counsel
  :ensure t
  :bind
  (:map global-map
        ("C-x C-f"   .   counsel-find-file))
  :config
   (setq ivy-re-builders-alist '((swiper . ivy--regex-plus)
                                (t . ivy--regex-fuzzy))))

(use-package dashboard
  :ensure t
  :init
  (progn
    (setq dashboard-startup-banner 'logo)
    (setq dashboard-set-heading-icons t)
    (setq dashboard-show-shortcuts nil)
    (setq dashboard-set-file-icons t)
    (setq dashboard-footer-icon (all-the-icons-octicon "dashboard"
                                                       :height 1.1
                                                       :v-adjust -0.05
                                                       :face 'font-lock-keyword-face))
    (setq dashboard-items '((recents  . 3)
                            (bookmarks . 3)
                            (projects . 3)
                            (agenda . 3))))
  :config
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (dashboard-setup-startup-hook))

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-redo)
  (define-key evil-insert-state-map (kbd "C-y") 'evil-paste-before-cursor-after)
  (define-key evil-normal-state-map (kbd "C-e") 'evil-end-of-visual-line))

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))

;; LSP
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'"
  :hook (rust-mode-hook . lsp-deferred))

(use-package markdown-mode
  :ensure t)

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/.emacs.d/kasten"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode))

(use-package org-superstar
  :ensure t
  :config
  (setq org-hide-leading-stars nil)
  (setq org-superstar-leading-bullet ?\s)
  (setq org-indent-mode-turns-on-hiding-stars nil))

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode +1))

(use-package rainbow-delimiters
  :ensure t)

(use-package treemacs
  :ensure t
  :bind
  (:map global-map
        ([f8]        . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag))
  :config
  (setq treemacs-is-never-other-window t))

(use-package which-key
  :ensure t
  :config (which-key-mode))

;; HOOKS
(add-hook 'prog-mode-hook (lambda () (setq display-line-numbers 'relative))) ; will only display on normal/programming. in org mode, it's gone
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))) ; will turn the mode automatically on org mode
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; MODES
(tool-bar-mode -1)			; disable toolbar
(menu-bar-mode -1)			; disable menubar
(scroll-bar-mode -1)        ; disable scroll bar
(tooltip-mode -1)			; disable tooltip
(set-fringe-mode 10)        ; Give some breathing room
(global-hl-line-mode +1)    ; Highlight line for easier to find cursor
(delete-selection-mode 1)   ; Replace select
(save-place-mode 1)         ; Remember last cursor position in a file
(global-auto-revert-mode 1) ; Refresh buffers when there is changes outside of Emacs

;; FIXES
(put 'upcase-region 'disabled nil)      ; Upcase region bypass

; To fix the gap on fullscreen in DE
(setq frame-resize-pixelwise t)
(dotimes (n 3)
  (toggle-frame-maximized))

; Set custom set in here instead of in init.el
(setq custom-file (locate-user-emacs-file "custom_sets.el"))
(load custom-file 'noerror 'nomessage)

; Set tab to 4 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(setq backup-directory-alist '(("." . "~/.emacs.d/saves"))) ; Redirect backup buffers

(setq initial-scratch-message nil)                          ; No messages in scratch buffer
(setq inhibit-startup-message t)   ; no startup message

; No sound, only visual in modeline
(setq visible-bell t)

; THEMES
;; Add the theme directory to the Emacs load path
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'kanagawa t)

;; FONTS
(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font Mono" :height 120)
