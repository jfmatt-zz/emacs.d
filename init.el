(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("elpa" . "http://tromey.com/elpa/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'load-path "~/.emacs.d/slime/")
(require 'slime-autoloads)

; ASM
(autoload 'nasm-mode "~/.emacs.d/plugins/nasm-mode.el" "" t)
(add-to-list 'auto-mode-alist '("\\.\\(asm\\|s\\)$" . nasm-mode))
(setq nasm-basic-offset 2)

; Indenting
(setq c-default-style "k&r")
(setq default-tab-width 2)
(setq tab-width 2)

; VIM-style % to show matching paren/brace/bracket
(global-set-key "%"
	(lambda
		(arg)
		(interactive "p")
		(cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
					((looking-at "\\s\)") (forward-char 1) (backward-list 1))
					(t (self-insert-command (or arg 1))))))

; Compilation
(setq compilation-ask-about-save nil)
(defun make-make (cmd)
	(interactive
	 (list (read-shell-command "Compile command: " "make -k")))
	(compile cmd))
(defun make-run ()
	(interactive)
	(compile "make run"))
(defun make-clean ()
	(interactive)
	(compile "make clean"))
(defun bind-make ()
	"Bind make, recompile, run, and clean to f4-f7"
	(local-set-key [f4] 'make-make)
	(local-set-key [f5] 'recompile)
	(local-set-key [f6] 'make-run)
	(local-set-key [f7] 'make-clean))
(add-hook 'c-mode-common-hook 'bind-make)
								
; Interface
(global-linum-mode t)
(blink-cursor-mode 0)
(global-hl-line-mode t)
(setq-default cursor-type 'box)
(global-set-key (kbd "RET") 'newline-and-indent)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Everything below this line requires that packages be loaded
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-initialize)
(defvar my-packages '(
	; Interface
	dired-details
	dedicated

	;Autocomplete										
	auto-complete
	ac-js2
	ac-nrepl

	; Indentation
	smart-tabs-mode
	sws-mode

	; Colors
	color-theme
	monokai-theme
	rainbow-delimiters

	; Language modes
	haskell-mode
	markdown-mode
	
	; Clojure
	clojure-mode
	clojure-test-mode
	nrepl
	paredit

  ; Web
	emmet-mode
	jade-mode
	js2-mode
	skewer-mode
	
))

(dolist (p my-packages)
  (when (not (package-installed-p p))
  (package-refresh-contents)
    (package-install p)))

; Dired customization
(require 'dired-details)
(setq dired-details-hidden-string "")
(dired-details-install)

(require 'dired-x)
(setq-default dired-omit-files-p t)
(setq dired-listing-switches "-aBhl  --group-directories-first")

; Color theme
(require 'color-theme)
(require 'monokai-theme)
(load-theme 'monokai t)

; Smart-tab languages
(smart-tabs-insinuate 'c 'javascript 'java)
(add-hook 'html-mode-hook 'smart-tabs-mode)
(smart-tabs-advice js2-indent-line js2-basic-offset)

; autocomplete
(require 'auto-complete)
(add-to-list 'ac-modes 'js2-mode)
(add-to-list 'ac-modes 'js-mode)

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(eval-after-load 'js2-mode
  '(progn
    (setq js2-auto-indent-p t)
    (setq js2-enter-indents-newline t)
    (setq js2-indent-on-enter-key t)))

(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)

;; rainbow delimiters
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

;; paredit
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)

;; nrepl
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(setq nrepl-popup-stacktraces nil)
(add-to-list 'same-window-buffer-names "*nrepl*")
(add-hook 'nrepl-mode-hook 'paredit-mode)

;; ac-nrepl
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'nrepl-mode))

;(defun movement-keys ()
;	(global-set-key [M-left] 'windmove-left)
;	(global-set-key [M-right] 'windmove-right)
;	(global-set-key [M-up] 'windmove-up)
;	(global-set-key [M-down] 'windmove-down))
;(add-hook 'paredit-mode-hook 'movement-keys)
(windmove-default-keybindings)
	

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-buffer-choice "~/Projects")
 '(js2-mode-indent-ignore-first-tab t)
 '(js2-strict-missing-semi-warning nil)
 '(markdown-command "multimarkdown"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
