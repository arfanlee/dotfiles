;; DISPLAY LINE NUMBERS AND COLUMN
(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (setq display-line-numbers 'relative))))

;; Turn off display number in org-mode
(dolist (mode '(org-mode-hook
                markdown-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
(column-number-mode)

;; GLOBAL KEYBIND
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

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

;; FULLSCREEN
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; To fix the gap on fullscreen in DE
(setq frame-resize-pixelwise t)
(dotimes (n 3)
  (toggle-frame-maximized))

;; Org-mode stuff
(setq org-adapt-indentation t)     ; to indent contents under headings
(setq org-hide-emphasis-markers t) ; to hide markup symbols. e.g: /italics/ *bold*

;; For org code block
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)
   (java . t)
   (python . t)))

;; Set custom set in here instead of in init.el
(setq custom-file (locate-user-emacs-file "custom_sets.el"))
(load custom-file 'noerror 'nomessage)

;; Set tab to 4 spaces
(setq-default tab-width 4)
(setq-default evil-shift-width tab-width)
(setq indent-line-function 'insert-tab)

;; Use spaces instead of tabs for indentation
(setq-default indent-tabs-mode nil)

(setq backup-directory-alist '(("." . "~/.emacs.d/saves"))) ; Redirect backup buffers

(setq initial-scratch-message nil)     ; No messages in scratch buffer
(setq inhibit-startup-message t)       ; No startup message

;; No sound, only visual in modeline
(setq visible-bell t)

;; FUNCTIONS
;; Emacs as external editor
(defun dw/show-server-edit-buffer (buffer)
  ;; TODO: Set a transient keymap to close with 'C-c C-c'
  (split-window-vertically -15)
  (other-window 1)
  (set-buffer buffer))

(setq server-window #'dw/show-server-edit-buffer)

;; FONTS
(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font Mono" :height 120)
(set-face-attribute 'fixed-pitch nil :font "JetBrainsMono Nerd Font Mono" :height 120)

;; In case frame that is launched from emacsclient not using the font above.
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font Mono-12"))

;; PACKAGE INSTALLER (melpa)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; PACKAGES
(use-package all-the-icons              ; Needed by doom-modeline
  :ensure t)

;; THEMES
;; Add the theme directory to the Emacs load path
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(use-package autothemer                 ; Needed by kanagawa.el
  :ensure t
  :config
  (load-theme 'kanagawa t))

;; keep the cursor centered to avoid sudden scroll jumps
(use-package centered-cursor-mode
  :ensure t
  :config
  ;; disable in terminal modes
  ;; also disable in Info mode, because it breaks going back with the backspace key
  (define-global-minor-mode my-global-centered-cursor-mode centered-cursor-mode
    (lambda ()
      (when (not (memq major-mode
                       (list 'Info-mode 'term-mode 'eshell-mode 'shell-mode 'erc-mode 'vterm-mode)))
        (centered-cursor-mode))))
  (my-global-centered-cursor-mode 1))

(use-package centaur-tabs
  :ensure t
  :after evil
  :init
  (setq centaur-tabs-enable-key-keybindings t)
  :config
  (setq centaur-tabs-set-icons t) ; For prefix icon according to file type(s)
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-height 35)
  (setq centaur-tabs-set-bar 'under) ; The little line under focused tab
  (setq x-underline-at-descent-line t) ; The little line display fix for non-Spacemacs
  (setq centaur-tabs-gray-out-icons 'buffer)
  (setq centaur-tabs-set-modified-marker t) ; For the modified marker on close button
  (setq centaur-tabs-modified-marker "")
  (setq centaur-tabs-cycle-scope 'tabs) ; To only cycle tabs in current buffer
  (setq centaur-tabs-label-fixed-length 8)
  (centaur-tabs-headline-match)
  (centaur-tabs-enable-buffer-reordering)
  (centaur-tabs-mode t)
  :hook
  ;; Turns off tab in this modes
  (dashboard-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  (vterm-mode . centaur-tabs-local-mode)
  :bind
  (:map evil-normal-state-map
        ("C-<tab>" . centaur-tabs-forward)
        ("C-<iso-lefttab>" . centaur-tabs-backward)))

(use-package corfu
  :ensure t
  ;; :after lsp-mode
  ;; :hook (lsp-mode . corfu-mode)
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-preselect 'prompt)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.0)
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-prev)
        ([backtab] . corfu-previous))
  :init
  (corfu-history-mode)
  (global-corfu-mode))

(use-package kind-icon
  :ensure t
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package orderless
  :ensure t
  :init
  ;; Tune the global completion style settings to your liking!
  ;; This affects the minibuffer and non-lsp completion at point.
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

(use-package counsel
  :ensure t
  :bind
  (:map evil-normal-state-map
        ("C-x C-f" . counsel-find-file)
        ("M-x" . counsel-M-x))
  :hook (after-init . counsel-mode))    ; To make sure ivy-prescient started immediately

(use-package dashboard
  :ensure t
  :init
  (progn
    (setq dashboard-startup-banner 'logo)
    (setq dashboard-display-icons-p t)
    (setq dashboard-icon-type 'nerd-icons)
    (setq dashboard-set-heading-icons t)
    (setq dashboard-show-shortcuts nil)
    (setq dashboard-set-file-icons t)
    (setq dashboard-footer-icon (all-the-icons-octicon "dashboard"
                                                       :height 1.1
                                                       :v-adjust -0.05
                                                       :face 'font-lock-keyword-face))
    (setq dashboard-items '((recents  . 5)
                            (bookmarks . 5)
                            (projects . 5)
                            (agenda . 5))))
  :config
  (recentf-load-list)
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))) ; when open new frame, show dashboard

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
  :init
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-set-initial-state 'dashboard-mode 'insert) ; no normal mode in dashboard

  (define-key evil-normal-state-map (kbd "/") 'swiper)
  (define-key evil-insert-state-map (kbd "C-a") 'evil-beginning-of-visual-line)
  (define-key evil-insert-state-map (kbd "C-e") 'evil-end-of-visual-line)
  (define-key evil-insert-state-map (kbd "C-n") 'evil-next-line)
  (define-key evil-insert-state-map (kbd "C-p") 'evil-previous-line)
  (define-key evil-insert-state-map (kbd "C-y") 'evil-paste-after-cursor-after)
  (evil-mode 1))

(use-package evil-nerd-commenter
  :ensure t
  :bind
  (:map evil-normal-state-map
        ("M-/" . evilnc-comment-or-uncomment-lines)))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1)
  ;; this macro was copied from here: https://stackoverflow.com/a/22418983/4921402
  (defmacro define-and-bind-quoted-text-object (name key start-regex end-regex)
    (let ((inner-name (make-symbol (concat "evil-inner-" name)))
          (outer-name (make-symbol (concat "evil-a-" name))))
      `(progn
         (evil-define-text-object ,inner-name (count &optional beg end type)
           (evil-select-paren ,start-regex ,end-regex beg end type count nil))
         (evil-define-text-object ,outer-name (count &optional beg end type)
           (evil-select-paren ,start-regex ,end-regex beg end type count t))
         (define-key evil-inner-text-objects-map ,key #',inner-name)
         (define-key evil-outer-text-objects-map ,key #',outer-name))))

  (define-and-bind-quoted-text-object "pipe" "|" "|" "|")
  (define-and-bind-quoted-text-object "slash" "/" "/" "/")
  (define-and-bind-quoted-text-object "asterisk" "*" "*" "*")
  (define-and-bind-quoted-text-object "plus" "+" "+" "+")
  (define-and-bind-quoted-text-object "tilde" "~" "~" "~")
  (define-and-bind-quoted-text-object "dollar" "$" "\\$" "\\$")) ;; sometimes your have to escape the regex

(use-package general
  :ensure t
  :config
  (general-evil-setup t)

  (general-create-definer al/leader-key-def
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "M-SPC")

  (al/leader-key-def
    "o a" 'org-agenda :wk "Agenda")

  (al/leader-key-def
    "f f" 'counsel-find-file :wk "Find file")

  (al/leader-key-def
    "b b" 'counsel-switch-buffer
    "b h" 'previous-buffer
    "b l" 'next-buffer)

  (al/leader-key-def
    "r b" 'bookmark-jump
    "r m" 'bookmark-set)

  (al/leader-key-def
    "t n" 'centaur-tabs--create-new-tab
    "t j" 'centaur-tabs-ace-jump
    "t k" 'kill-this-buffer)

  (al/leader-key-def
    "n c" 'org-roam-capture
    "n t" 'org-roam-dailies-capture-today
    "n f" 'org-roam-node-find
    "n i" 'org-roam-node-insert))

(use-package ivy
  :diminish
  :ensure t
  :init
  (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-wrap t)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  ;; Use different regex strats per completion command
  (setq ivy-re-builders-alist '((swiper . ivy--regex-plus)
                                (counsel-find-file . ivy--regex-fuzzy)
                                (counsel-M-x . ivy--regex-ignore-order))))

(use-package ivy-prescient
  :ensure t
  :after counsel
  :config
  (ivy-prescient-mode 1)
  (prescient-persist-mode 1))

(use-package ivy-rich
  :ensure t
  :init
  (ivy-rich-mode 1)
  :after counsel
  :config
  (setq ivy-format-function #'ivy-format-function-line)
  (setq ivy-rich-display-transformers-list
        (plist-put ivy-rich-display-transformers-list
                   'ivy-switch-buffer
                   '(:columns
                     ((ivy-rich-candidate (:width 40))
                      (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right)); return the buffer indicators
                      (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))          ; return the major mode info
                      (ivy-rich-switch-buffer-project (:width 15 :face success))             ; return project name using `projectile'
                      (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))  ; return file path relative to project root or `default-directory' if project is nil
                     :predicate
                     (lambda (cand)
                       (if-let ((buffer (get-buffer cand)))
                           ;; Don't mess with EXWM buffers
                           (with-current-buffer buffer
                             (not (derived-mode-p 'exwm-mode)))))))))

;; LSP
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (lsp-mode-hook . corfu-mode)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t)
  (electric-pair-mode))
  ;; (c-mode . lsp-mode))

(use-package c-mode
  :mode "\\.c\\'"
  :hook (c-mode . lsp-deferred)
  :custom
  (c-default-style "linux")
  (c-basic-offset 4))

(use-package rustic
  :ensure t
  :custom (rustic-format-trigger 'on-save))

(use-package python-mode
  :ensure t
  :mode "\\.py\\'"
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred)))  ; or lsp-deferred
  (python-mode-hook . (lambda () 
                        (setq python-indent-guess-indent-offset nil)))
  :bind (("C-s" . python-indent-dedent-line)) ; Remove the keymap
  :custom
  (python-shell-interpreter "python3")
  (lsp-pyright-typechecking-mode "off") ; lsp-pyright default is "standard"
  :config
  (setq python-indent 4))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  ;; Need to install 'multimarkdown' with Linux package manager, e.g. dnf/pacman/apt
  ;; It will show preview in browser, not in Emacs itself
  :init (setq markdown-command "multimarkdown"))

(use-package org
  :ensure t
  :config
  (require 'org-tempo) ; A quicker way to start source code, quote, etc.
  (setq org-startup-folded 'overview))

(use-package org-appear
  :ensure t
  :hook (org-mode . org-appear-mode))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/Kasten"))
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   '(("d" "default" plain
      "* %?"
      :if-new (file+head "${slug}-%<%Y%m%d%H%M%S>.org" "#+TITLE: ${title}\n#+AUTHOR: Arfan Lee\n#+DATE: %U\n#+FILETAGS: %^{Tag}\n")
      :unarrowed t)))
  (org-roam-dailies-capture-templates
   '(("d" "default" plain "* Today's highlight(s)\n** %?"
      :target (file+head "Journal %<%Y-%m-%d>.org" "#+TITLE: Journal of %<%-d/%-m/%Y>\n#+AUTHOR: Arfan Lee\n#+FILETAGS: Journal\n"))))
  :bind (("C-c n c" . org-roam-capture)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("C" . org-roam-dailies-capture-today)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (org-roam-setup)
  (require 'org-roam-dailies) ;; Ensure the keymap is available
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode))

(use-package org-roam-ui
  :ensure t
  ;; normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;; a hookable mode anymore, you're advised to pick something yourself
  ;; if you don't care about startup time, use
  :hook (after-init . org-roam-ui-mode)
  :bind (("C-c n u" . org-roam-ui-open))
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start nil))

(use-package org-superstar
  :ensure t
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-leading-bullet ?\s))

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode +1))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package treemacs
  :ensure t
  :defer t
  :bind
  (:map evil-normal-state-map
        ("C-f"       . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag))
  :config
  (progn
    (setq treemacs-is-never-other-window t
          treemacs-follow-after-init t
          treemacs-show-cursor nil
          treemacs-tag-follow-cleanup t
          treemacs-tag-follow-delay 1.5)
    (treemacs-indent-guide-mode 'line)
    (treemacs-filewatch-mode t)
    (treemacs-follow-mode t)))

(use-package treemacs-evil
  :ensure t
  :after (treemacs evil)
  :config
  (evil-set-initial-state 'treemacs-mode 'normal))

(use-package vterm
  :ensure t
  :bind
  (:map evil-insert-state-map
        ("C-v" . vterm-yank)))

(use-package which-key
  :ensure t
  :config
  ;; Allow C-h to trigger which-key before it is done automatically
  (setq which-key-show-early-on-C-h t
        ;; make sure which-key doesn't show normally but refreshes quickly after it is
        ;; triggered.
        which-key-idle-delay 10000
        which-key-idle-secondary-delay 0.05)
  (which-key-mode))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode))
