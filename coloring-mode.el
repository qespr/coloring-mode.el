;;; coloring-mode.el --- Major mode for coloring ASCII art  -*- lexical-binding: t; -*-

;; Copyright (C) 2022  qespr

;; Author: qespr
;; Keywords: multimedia, games, tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Allows for coloring of ASCII images and their export to ANSI colored files

;;; Code:

(defun coloring-mode-toggle-insert-mode ()
  "Toggles between insert and color mode."
  (interactive)
  (setq coloring-mode-insert-mode (not coloring-mode-insert-mode))
  (message (concat "Inser mode " (if coloring-mode-insert-mode
				     "enabled."
				   "disabled."))))

(defun coloring-mode-RET ()
  "Depending on the insert mode state, color char or insert newline."
  (interactive)
  (if coloring-mode-insert-mode
      (newline)
    (put-text-property
     (point)
     (+ (point) 1)
     'font-lock-face '(:foreground "red"))))

;;C-c C-c - switch between insert and coloring mode
;;C-c C-e - Export
;;right mouse click and RET on char will change color to currently selected color
;;
(defvar coloring-mode-map nil "Keymap for `coloring-mode'")
(defvar coloring-mode-insert-mode nil "Whether we insert or color")

(progn
  (setq coloring-mode-map (make-sparse-keymap))
  (define-key coloring-mode-map (kbd "C-c C-c") 'coloring-mode-toggle-insert-mode)
  (define-key coloring-mode-map (kbd "RET") '-coloring-mode-RET)
  ;; by convention, major mode's keys should begin with the form C-c C-‹key›
  )

;;(get-char-property position prop &optional object)
;;(get-pos-property position prop &optional object)
;;(text-properties-at position &optional object)
;;(put-text-property start end property value &optional object)
;;(add-text-properties start end properties &optional object)
;; http://xahlee.info/emacs/emacs/elisp_text_properties.html

(define-derived-mode coloring-mode fundamental-mode "coloring-mode"
  "Major mode coloring ASCII art.

  \\{my-mode-map}"

  (use-local-map coloring-mode-map)
  )

;; (provide 'coloring-mode)
;;; coloring-mode.el ends here
