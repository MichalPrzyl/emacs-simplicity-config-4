(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(misterioso))
 '(package-selected-packages '(multiple-cursors magit gruber-darker-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker t))

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(setq visible-bell t)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

(use-package multiple-cursors
  :ensure t
  :bind
  (("C-S-c C-S-c" . mc/edit-lines)
   ("C->"         . mc/mark-next-like-this)
   ("C-<"         . mc/mark-previous-like-this)
   ("C-c C-<"     . mc/mark-all-like-this)))

(defun smart-move-beginning-of-line ()
  "Przełącz między początkiem linii a początkiem tekstu (z pominięciem spacji)."
  (interactive)
  (let ((point-was (point)))
    (back-to-indentation)
    (when (= point-was (point))
      (move-beginning-of-line 1))))

(global-set-key (kbd "C-a") #'smart-move-beginning-of-line)

(global-set-key (kbd "C-c d") #'duplicate-dwim)

; hook dla pythona
(add-hook 'python-mode-hook
	  (lambda ()
	    (setq tab-width 4)
	    (setq indent-tabs-mode nil)))

(setq tab-width 4)

;; Move line or whole region up and down

(defun move-region-up (start end)
  "Move region up by one line."
  (interactive "r")
  (let ((text (delete-and-extract-region start end)))
    (forward-line -1)
    (let ((new-start (point)))
      (insert text)
      (set-mark new-start)
      (setq deactivate-mark nil))))

(defun move-region-down (start end)
  "Move region down by one line."
  (interactive "r")
  (let ((text (delete-and-extract-region start end)))
    (forward-line 1)
    (let ((new-start (point)))
      (insert text)
      (set-mark new-start)
      (setq deactivate-mark nil))))

(defun move-line-up ()
  "Move current line up."
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  "Move current line down."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(defun move-line-or-region-up ()
  (interactive)
  (if (use-region-p)
      (move-region-up (region-beginning) (region-end))
    (move-line-up)))

(defun move-line-or-region-down ()
  (interactive)
  (if (use-region-p)
      (move-region-down (region-beginning) (region-end))
    (move-line-down)))

(global-set-key (kbd "M-<up>") #'move-line-or-region-up)
(global-set-key (kbd "M-<down>") #'move-line-or-region-down)

(set-face-attribute 'default nil
                    :font "Iosevka Term Extended"
                    :height 120)

;; Better scrolling
(setq scroll-step 1
      scroll-conservatively 10000
      scroll-margin 25
      scroll-preserve-screen-position t)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse t)

(pixel-scroll-precision-mode 1)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(delete-selection-mode 1)
