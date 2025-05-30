(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-p") 'preview-document)
(global-set-key (kbd "C->") 'tab-next)
(global-set-key (kbd "C-<") 'tab-previous)

(setq inhibit-startup-screen t)

(setq warning-minimum-level :error)

(require 'prettify-utils "~/.emacs.d/prettify-utils.el")

(add-hook 'vterm-mode-hook (lambda () (text-scale-decrease 2)))
(set-face-attribute 'mode-line nil :height 60)
(require 'ef-themes)
(load-theme 'ef-cherie t)
(show-paren-mode t)
(setq show-paren-style 'expression)
; personal config
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(setq mount-wheel-progressive-speed nil)
(setq mount-wheel-follow-mouse 't)
(setq auto-save-default nil)
;; scroll one line at a time (less "jumpy" than defaults)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 1) ;; keyboard scroll one line at a time

;; coq is a pain otherwise
(setq abbrev-expand-function #'ignore)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 170 :family "Fantasque Sans Mono"))))
 '(org-document-title ((t (:height 2.0))))
 '(org-level-1 ((t (:height 1.4))))
 '(org-level-2 ((t (:height 1.2))))
 '(org-level-3 ((t (:height 1.15))))
 '(org-level-4 ((t (:height 1.1))))
 '(org-level-5 ((t (:height 1.0)))))

(set-fontset-font "fontset-default" 'unicode "JuliaMono")

;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default nil)



(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
;;(use-package lsp-ui
;;  :custom
;;  (lsp-ui-sideline-enable t)
;;  (lsp-ui-sideline-show-diagnostics t)
;;  (lsp-ui-sideline-show-hover t)
;;  (lsp-ui-sideline-delay 0.2))

;; (use-package lsp-mode
;;  :hook (c-mode . lsp))

(setq-default abbrev-mode t)
(add-hook 'after-init-hook 'global-color-identifiers-mode)
(require 'rust-mode)
(add-hook 'rust-mode-hook #'lsp)
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(defun my-symbols-alist ()
  (setq prettify-symbols-alist
	(append prettify-symbols-alist
		(prettify-utils-generate
		 ("lambda" "λ")
		 ("forall" "∀")
		 ("exists" "∃")
		 ("fun" "λ")
		 ("function" "\\λ")
		 ("->" "→")
		 ("=>" "⇒")
		 ("~>" "⊸")
		 (">=" "≥")
		 ("<=" "≤")
		 ("tfun" "Λ")
		 ("::" "∷")
     ("Proof." "∵ ")
     ("Abort." "trust me bro.")
     ("Qed." "□")))))
(setq global-prettify-symbols-mode t)
(add-hook 'prog-mode-hook #'(lambda () (progn (my-symbols-alist) (prettify-symbols-mode t))))
(require 'org)

(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(with-eval-after-load 'org-superstar
  (set-face-attribute 'org-superstar-item nil :height 1.2)
  (set-face-attribute 'org-superstar-header-bullet nil :height 1.2)
  (set-face-attribute 'org-superstar-leading nil :height 1.3))
;; Set different bullets, with one getting a terminal fallback.
(setq org-superstar-headline-bullets-list
      '("✯" "◇" "◈" "▷" "▶" "⇥" "⌲"))

;; Stop cycling bullets to emphasize hierarchy of headlines.
(setq org-superstar-cycle-headline-bullets nil)
;; Hide away leading stars on terminal.
(setq org-superstar-leading-bullet ?\s)

;; set the ... thing on collapse
(setq org-ellipsis " ↴")

(setq org-n-level-faces 4)

;; hide the #+title:
(setq org-hidden-keywords '(title))
;; make latex preview bigger

(setq org-preview-latex-default-process 'dvisvgm)

(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.5))

(keymap-global-set "C-x C-p" 'org-latex-preview)

(require 'org-fragtog)
(add-hook 'org-mode-hook 'org-fragtog-mode)

(require 'org-appear)
(add-hook 'org-mode-hook 'org-appear-mode)

(require 'org-roam)
(setq org-roam-v2-ack t)
(setq org-roam-directory (file-truename "~/.emacs.d/org-roam"))
(keymap-global-set "C-c n l" 'org-roam-buffer-toggle)
(keymap-global-set "C-c n f" 'org-roam-node-find)

(defun org-roam-node-insert-commaless ()
  (interactive)
  (progn
    (org-roam-node-insert)
    (let ((pos (search-backward "," nil t)))  ; Find the previous comma
      (if pos
          (delete-region (1+ pos) (point))))
    (insert "]]")
    (kill-line)
    )
  )


(keymap-global-set "C-c n i" 'org-roam-node-insert-commaless)
(keymap-global-set "C-c n o" 'org-roam-node-insert)
    
(setq org-roam-completion-everywhere t)
(org-roam-db-autosync-mode)
(defun case-insensitive-org-roam-node-read (orig-fn &rest args)
  (let ((completion-ignore-case t))
    (apply orig-fn args)))
    
(advice-add 'org-roam-node-read :around #'case-insensitive-org-roam-node-read)

(setq org-roam-capture-templates
      '(
	("d" "default" plain
	 "%?"
	 :if-new
	 (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title:${title}\n")
	 :unnarrowed t)
	)
      )

(setq org-roam-mode-sections
      (list #'org-roam-backlinks-section
            #'org-roam-reflinks-section
            ;; #'org-roam-unlinked-references-section
            ))

;; extra latex

(setq org-latex-packages-alist '())
(add-to-list 'org-latex-packages-alist '("" "physics" t))


(tab-bar-mode)

(require 'tuareg)
(require 'merlin)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(isearch-mb corfu nix-mode company-coq proof-general vertico org-roam color-identifiers-mode tuareg rust-mode rainbow-delimiters org-superstar org-fragtog org-appear merlin lsp-ui ef-themes)))

(autoload 'merlin-mode "merlin" "Merlin mode" t)
(add-hook 'tuareg-mode-hook #'merlin-mode)
(add-hook 'caml-mode-hook #'merlin-mode)

(vertico-mode)

(global-corfu-mode)

(setq corfu-auto t
      corfu-quit-no-match 'separator) ;; or t
(setq corfu-auto-delay 0.2)
(setq corfu-auto-prefix 3)

(if (equal system-type 'darwin)
    (progn (setenv "PATH"
	    (concat (getenv "PATH")
		    ":/run/current-system/sw/bin/:/Users/jake/.nix-profile/bin:/nix/var/nix/profiles/default/bin"))
	   (dolist (dir '("/run/current-system/sw/bin/" "/Users/jake/.nix-profile/bin" "/nix/var/nix/profiles/default/bin"))
	     (add-to-list 'exec-path dir))
	   (setq-default tab-width 4)
       (setq-default c-basic-offset 4)
	   ))

(setq-default indent-tabs-mode nil)
(setq indent-line-function 'insert-tab)

(require 'vertico)
(vertico-mode)

(add-hook 'org-mode-hook #'visual-line-mode)


(setq-default indent-tabs-mode nil)

(add-hook 'prog-mode-hook 'electric-pair-mode)
    
;; (add-hook 'c-mode-hook 'lsp)
;; (add-hook 'c++-mode-hook 'lsp)

;; (add-hook 'c-mode-hook (lambda () lsp-ui-mode -1))

;; (setq lsp-ui-doc-show-with-cursor nil)

;; (setq lsp-ui-sideline-enable nil)
;; (setq lsp-ui-sideline-show-hover nil)

(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-overrides '((file (styles basic partial-completion))))

(isearch-mb-mode)

(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))


(require 'agda-input)

(add-hook 'org-mode-hook (lambda () (set-input-method "Agda")))
(setq default-input-method "Agda")

    

