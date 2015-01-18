(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("elpa" . "http://tromey.com/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; General
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Indenting
(setq c-default-style "k&r")
(setq default-tab-width 2)
(setq tab-width 2)
(setq-default indent-tabs-mode nil)

; Keybindings
;   VIM-style % to show matching paren/brace/bracket
(global-set-key "%"
        (lambda
                (arg)
                (interactive "p")
                (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
                                        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
                                        (t (self-insert-command (or arg 1))))))
;   Make find-and-replace work on the whole buffer
(global-set-key (kbd "M-%")
  (lambda
    ()
    (interactive)
    (save-excursion
      (beginning-of-buffer)
      (call-interactively 'replace-string))))
(global-set-key (kbd "C-?") 'comment-or-uncomment-region)
;   Window movement
(windmove-default-keybindings)
(global-set-key (kbd "C-x C-o") 'find-file-other-window)

; Interface
(global-linum-mode t)
(blink-cursor-mode 0)
(global-hl-line-mode t)
(setq-default cursor-type 'box)
(setq compilation-scroll-output t)

; Minor keybind behavior tweaks
(global-set-key (kbd "RET") 'newline-and-indent)
(setq compilation-ask-about-save nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Package configurations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-initialize)
(dolist
  (pkg '(
    ; Interface
    column-marker
    dired-details
    dedicated
    sr-speedbar
    workgroups2

    ; Autocomplete
    company-ycmd

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

    ; Web
    emmet-mode
    jade-mode
    js2-mode
 ))
  (when (not (package-installed-p pkg))
  (package-refresh-contents)
    (package-install pkg)))

; Dired config
(require 'dired-details)
(setq dired-details-hidden-string "")
(dired-details-install)

(require 'dired-x)
(setq-default dired-omit-files-p t)
(setq dired-listing-switches "-Bhl --group-directories-first")

(require 'sr-speedbar)
(global-set-key (kbd "C-c ]") 'sr-speedbar-open)

; Color theme
(require 'color-theme)
(require 'monokai-theme)
(load-theme 'monokai t)

; Smart-tab languages
(smart-tabs-insinuate 'c 'javascript 'java 'c++)
(add-hook 'html-mode-hook 'smart-tabs-mode)
(smart-tabs-advice js2-indent-line js2-basic-offset)

; YCM
;; Time from the last edit until emacs-ycm starts reparsing the buffer.
(set-variable 'ycmd-idle-change-delay 2)
(set-variable 'ycmd-parse-conditions '(save new-line mode-enabled))

; Company Mode
(require 'company-ycmd)
(company-ycmd-setup)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'prog-mode-hook 'ycmd-mode)

(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)

;; rainbow delimiters
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode t)

;; workgroups
(require 'workgroups2)
(workgroups-mode 1)
(setq wg-emacs-exit-save-behavior nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("60f04e478dedc16397353fb9f33f0d895ea3dab4f581307fbf0aa2f07e658a40" default)))
 '(initial-buffer-choice "~")
 '(js2-mode-indent-ignore-first-tab t)
 '(js2-strict-missing-semi-warning nil)
 '(markdown-command "multimarkdown")
 '(speedbar-show-unknown-files t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
