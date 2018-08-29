;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;  package management with el-get start  ;;;;;;;;;;

;; el-get setting
(add-to-list 'load-path (locate-user-emacs-file "~/.emacs.d/el-get/el-get"))
(require 'el-get)

;; put packages downloaded by el-get on ~/.emacs.d/el-get/
(setq el-get-dir (locate-user-emacs-file "~/.emacs.d/el-get"))

;;; packages
(el-get-bundle go-mode)
(el-get-bundle php-mode)

;;;;;;;;;;  package management with el-get  end   ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;  common setttings start ;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Backup file ;;;;;

; Do not create backup file
(setq backup-inhibited t)
; Delete auto save file when emacs exits.
(setq delete-auto-save-files t)

;;;;;;;;;;;;;;;;;;;;;
;;;;; Highlight ;;;;;

;; Highlight corresponding bracket
(show-paren-mode t)

;; Highlight selected region
(transient-mark-mode t)

;; Highlight current line
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "dark slate gray"))
    (((class color)
      (background light))
     (:background "ForestGreen"))
    (t
     ()))
  "*Face used by hl-line.")
; (setq hl-line-face 'hlline-face) ; Change color
(setq hl-line-face 'underline) ; Underline
(global-hl-line-mode)

;;;;;;;;;;;;;;;;;;
;;;;; Others ;;;;;

;; Display line number
(line-number-mode t)

;; Display column number
(column-number-mode t)

;;;;;;;;;;  common setttings  end  ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;  programming settings start ;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
;;;;; golang ;;;;;

(add-hook 'go-mode-hook
          '(lambda()
            (setq c-basic-offset 4)
            (setq indent-tabs-mode t)
            (local-set-key (kbd "M-.") 'godef-jump)
            (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
            (local-set-key (kbd "C-c i") 'go-goto-imports)
            (local-set-key (kbd "C-c d") 'godoc)))

(add-hook 'before-save-hook 'gofmt-before-save)

;;;;;;;;;;  programming settings  end  ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
