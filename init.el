; Packages:
; evil
; evil-leader
; key-chord
; window-numbering

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(require 'evil)
(require 'evil-leader)
(require 'key-chord)
(require 'window-numbering)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

; initialize evil-leader before evil
(global-evil-leader-mode 1)
(evil-mode 1)
(key-chord-mode 1)
(window-numbering-mode 1)

(ido-mode 1)
(global-hl-line-mode 1)
(show-paren-mode 1)
(desktop-save-mode 1)

(setq-default indent-tabs-mode nil)
;(setq-default c-default-style "k&r")
(setq c-default-style
      '((java-mode . "java")
        (other . "k&r")))

(setq gdb-many-windows t)
(set-frame-parameter nil 'fullscreen 'maximized)

(defun minibuffer-clear-and-quit ()
  (interactive)
  (delete-minibuffer-contents)
  (keyboard-escape-quit))

(defun switch-to-last-active-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun run-last-command ()
  (interactive)
  (shell-command (cadr (assoc 'shell-command command-history))))

; set leader key
(evil-leader/set-leader "<SPC>")

; set leader keymap
(evil-leader/set-key
 "s" 'save-buffer
 "a" 'write-file
 "o" 'find-file

 "i" 'imenu
 ";" 'execute-extended-command
 
 "D" 'shell-command
 "d" 'run-last-command
 "v" 'recompile
 "c" 'compile
 "g" 'previous-error
 "h" 'next-error

 "b" 'switch-to-buffer
 "k" 'kill-buffer
 "l" 'switch-to-last-active-buffer

 "x" 'toggle-menu-bar-mode-from-frame
 
 "n" 'split-window-below
 "m" 'split-window-right
 "," 'delete-window

 "0" 'select-window-0
 "1" 'select-window-1
 "2" 'select-window-2
 "3" 'select-window-3
 "4" 'select-window-4
 "5" 'select-window-5
 "6" 'select-window-6
 "7" 'select-window-7
 "8" 'select-window-8
 "9" 'select-window-9)

; vim escape key-chord replacement
(key-chord-define evil-normal-state-map "fd" 'evil-force-normal-state)
(key-chord-define evil-visual-state-map "fd" 'evil-change-to-previous-state)
(key-chord-define evil-insert-state-map "fd" 'evil-normal-state)
(key-chord-define evil-replace-state-map "fd" 'evil-normal-state)

(key-chord-define evil-insert-state-map "kj" 'dabbrev-expand)

(key-chord-define minibuffer-local-map "fd" 'minibuffer-clear-and-quit)

(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

(set-face-background 'hl-line "lavender")

(defun setup-themes ()
  (set-face-attribute 'default nil :font "Inconsolata-14")
  (set-foreground-color "#403D36")
  (set-background-color "#FFEFC9")
  (set-face-background 'fringe "#FFEFC9")
  ; disable mode-line outline for flatter look
  (set-face-attribute 'mode-line nil :box nil)
  (set-face-background 'mode-line "#E5D09E")
  (set-face-foreground 'mode-line "#98865A")
  (set-face-attribute 'region nil :background "#9EB4E5")
  (set-face-attribute 'font-lock-builtin-face nil :foreground "#403D36")
  (set-face-attribute 'font-lock-comment-face nil :foreground "#4B6298")
  (set-face-attribute 'font-lock-constant-face nil :foreground "#69A5B2")
  (set-face-attribute 'font-lock-function-name-face nil :foreground "#403D36")
  (set-face-attribute 'font-lock-keyword-face nil :foreground "#022A98")
  ; #B38109
  (set-face-attribute 'font-lock-string-face nil :foreground "#7F7725")
  (set-face-attribute 'font-lock-type-face nil :foreground "#403D36")
  (set-face-attribute 'font-lock-variable-name-face nil :foreground "#403D36"))

(defun setup-window()
  (setup-themes)
  (split-window-below)
  (select-window-2)
  (rename-buffer "*compilation*"))

(add-hook 'window-setup-hook 'setup-themes t)

