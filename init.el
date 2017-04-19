
(setq initial-frame-alist
      '((left   . 100)		
	(top    .  50)		
	(width  . 120)		
	(height .  40)		
	))


(setq scroll-conservatively 1)

(setq scroll-margin 10)

(setq next-screen-context-lines 10)

(setq scroll-preserve-screen-position t)

(setq read-buffer-completion-ignore-case t)

(setq read-file-name-completion-ignore-case t)

(setq dabbrev-case-replace nil)

(setq make-backup-files t)

(setq version-control     t) 
(setq kept-new-versions   5) 
(setq kept-old-versions   1) 
(setq delete-old-versions t) 

(setq auto-save-timeout 10)	
(setq auto-save-interval 100)	


;; package

(when (require 'package nil t)
  (setq package-archives
	(append package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
				   ("marmalade" . "http://marmalade-repo.org/packages/"))))
  (package-initialize))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; auto-complete
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (require 'auto-complete-config nil t)
  (ac-config-default))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; ロードパスの設定
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path 
	     "~/.emacs.d/site-lisp")
(add-to-list 'load-path 
	     "~/.emacs.d/elpa")
;; ;; load-path に登録されたディレクトリーを subdir 扱い
;; ;;   注:アクセス件でエラーになりやすい
;; (normal-top-level-add-subdirs-to-load-path)


;; ;; キー設定ファイルのロード
;; (load "my-keyset-light")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; プログラミング
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 共通
;; ================================================================

;; 左端(文字の前)ではインデント、それ以外はタブの挿入
(setq tab-always-indent nil)
(setq c-tab-always-indent nil)

;; 空白を一度に削除
(if (fboundp 'global-hungry-delete-mode)
    (global-hungry-delete-mode 1))

;; 改行時などに自動でインデント 
;;   (C-j と C-m の入れ替え)
(if (fboundp 'electric-indent-mode)
    (electric-indent-mode 0))

;; 特定の文字を入力すると自動で改行、インデント
;; (electric-layout-mode 1)


;; C 系共通
;; ================================================================

(defun my-all-cc-mode-init ()
  ;; C 系(cc-mode を継承した)モード共通の設定を記述

  ;; 空白などを一度に削除
  (c-toggle-hungry-state 1)

  ;; 改行時などで自動インデント
  ;; (c-toggle-electric-state 1)
  ;; 
  ;; ";", "}" などを入力したときに自動改行
  ;; 自動インデントも一緒に ON になる
  ;; (c-toggle-auto-newline 1)

  )
(add-hook 'c-mode-common-hook 'my-all-cc-mode-init)
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)


;; C, C++
;; ================================================================

(autoload 'vs-set-c-style "vs-set-c-style"
  "Set the current buffer's c-style to Visual Studio like style. ")

(defun my-c-c++-mode-init ()
  ;; C, C++ 用の設定を記述
  

  ;; Visual Studio 風の設定
  ;; (vs-set-c-style)
  )
(add-hook 'c-mode-hook 'my-c-c++-mode-init)
(add-hook 'c++-mode-hook 'my-c-c++-mode-init)


;; .h でも C++
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; compile ;; 

(require 'compile)

(defvar yel-compile-auto-close t
  "* If non-nil, a window is automatically closed after (\\[compile]).")

(defadvice compile (after compile-aftercheck
                          activate compile)
  "Adds a funcion of windows auto-close."
  (let ((proc (get-buffer-process "*compilation*")))
    (if (and proc yel-compile-auto-close)
        (set-process-sentinel proc 'yel-compile-teardown))))

(defun yel-compile-teardown (proc status)
  "Closes window automatically, if compile succeed."
  (let ((ps (process-status proc)))
    (if (eq ps 'exit)
        (if (eq 0 (process-exit-status proc))
            (progn
              (delete-other-windows)
              (kill-buffer "*compilation*")
              (message "---- Compile Success ----")
              )
          (message "Compile Failer")))
    (if (eq ps 'signal)
        (message "Compile Abnormal end"))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; Tips
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ビープ音禁止
(setq ring-bell-function 'ignore)


;; スタート画面(メッセージ)を表示しない
(setq inhibit-startup-screen t)


;; 選択領域を削除キーで一括削除
(delete-selection-mode t)

;; shift + 矢印キーで領域選択
(if (fboundp 'pc-selection-mode)
    (pc-selection-mode))


;; 行頭で kill-line (C-k) で行全体でカット
(setq kill-whole-line t)

;; 読み取り専用バッファーでもカット系でコピー可能
(setq kill-read-only-ok t)


;; ediff 時にフレームを使わない
(setq ediff-window-setup-function 'ediff-setup-windows-plain)


;; png, jpg などのファイルを画像として表示
(setq auto-image-file-mode t)



;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; others
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; load path
(add-to-list 'load-path
	     (expand-file-name "~/.emacs.c/elpa/yasnippet"))

;; Color
(if window-system (progn
;;    (set-background-color "Black")
;;   (set-foreground-color "LightGray")
;;   (set-cursor-color "Gray")
    (set-frame-parameter nil 'alpha 100) ;透明度
    ))

;;(load-theme 'cherry-blossom nil)
(load-theme 'wombat t)
;; yasnippet
(require 'yasnippet)
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20170108.1830")
(yas-global-mode 1)

;; egg
(require 'egg)

;; twitting mode
(require 'twittering-mode)
(setq twittering-use-master-password t)
(setq twittering-initial-timeline-spec-string
      '(":home"
        ":replies"
        ":favorites"
        ":direct_messages"
        ":search/emacs/"
        "user_name/list_name"))

(setq twittering-icon-mode t)                ; Show icons
(setq twittering-timer-interval 15)         ; Update your timeline each 300 seconds (5 minutes) ->15
(setq twittering-url-show-status nil)        ; Keeps the echo area from showing all the http processes


;; line
(global-linum-mode t)

;; org-mode
(require 'ox-latex)
(add-to-list 'org-latex-classes
	     '("koma-article"
	       "\\documentclass{scrartcl}
		\\usepackage[utf8]{inputenc}
		\\usepackage[dvipdfmx]{graphicx}
		\\usepackage[backend=biber,bibencoding=utf8]{biblatex}
		\\usepackage{url}
		\\usepackage{indentfirst}
		\\usepackage[normalem]{ulem}
		\\usepackage[dvipdfmx]{hyperref}
		[NO-DEFAULT-PACKAGES]
		[EXTRA]"
	       ("\\section{%s}"."\\section*{%s}")
	       ("\\subsection{%s}"."\\subsection*{%s}")
	       ("\\subsubsection{%s}"."\\subsubsection*{%s}")
	       ("\\paragraph{%s}"."\\paragraph*{%s}")
	       ("\\subparagraph{%s}"."\\subparagraph{%s}")))


(setq org-latex-hyperref-template nil)
(setq org-src-fontify-natively t)

;; smartparens
(require 'smartparens-config)
(smartparens-global-mode t)
(sp-pair "*" "*")

;; rainbow-delimiters-mode
;; rainbow-delimiters を使うための設定
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; 括弧の色を強調する設定
(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
    (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)

;; helm mode
(require 'helm-config)
(helm-mode 1)

;; tabbar mode
(require 'tabbar)
(tabbar-mode t)
;; タブ上でマウスホイール操作無効
(tabbar-mwheel-mode -1)
;; グループ化しない
(setq tabbar-buffer-groups-function nil)
;; 画像を使わないことで軽量化する
(setq tabbar-use-images nil)
;; キーに割り当てる
(global-set-key (kbd "M-<right>") 'tabbar-forward-tab)
(global-set-key (kbd "M-<left>") 'tabbar-backward-tab)

;; toggle-trunslate-line
(toggle-truncate-lines t)

;; slime
;;(setq inferior-lisp-program "/usr/bin/clisp") 		;; !!! you must change it !!!
;;(setq inferior-lisp-program "/usr/bin/sbcl") 		;; !!! you must change it !!!

;; SBCLをデフォルトのCommon Lisp処理系に設定
;;(setq inferior-lisp-program "clisp")
;;(setq inferior-lisp-program "sbcl")


;; SLIMEのロード
;;(require 'slime)
;;(slime-setup '(slime-repl slime-fancy slime-banner)) 

;; ctable
(require 'ctable)


;; path
;;(exec-path-from-shell-initialize)

;; stylus 
;;(require 'stylus-mode)


;; image+
(imagex-auto-adjust-mode t)

;; reload file
(auto-revert-mode t)
(auto-image-file-mode t)

;; sr-
(require 'sr-speedbar) 
(setq sr-speedbar-right-side nil) 
(setq sr-speedbar-width-x 15)
(global-set-key (kbd "<f5>") 'sr-speedbar-toggle)

;; imenu-list
(require 'imenu)
(setq imenu-auto-rescan t)


;; clojure ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(require 'clojure-mode)
;;(add-hook 'clojure-mode-hook #'subword-mode)
;;(add-hook 'clojure-mode-hook #'cider-mode)


;;(require 'cider)
;;(add-hook 'cider-mode-hook #'clj-refactor-mode)
;;(add-hook 'cider-mode-hook #'company-mode)
;;(add-hook 'cider-mode-hook #'eldoc-mode)
;;(add-hook 'cider-repl-mode-hook #'company-mode)
;;(add-hook 'cider-repl-mode-hook #'eldoc-mode)
;;(add-hook 'cider-mode-hook #'clj-refactor-mode)

;;(require 'ac-cider)
;;(add-hook 'cider-mode-hook 'ac-cider-setup)
;;(add-hook 'cider-repl-mode-hook 'ac-cider-setup)


;; flycheck ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'flycheck)
(global-flycheck-mode)
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))


;; file make

;;; ;;; find-fileでディレクトリが無ければ作る
(defun make-directory-unless-directory-exists ()
  (let (
         (d (file-name-directory buffer-file-name))
       )
    (unless (file-directory-p d)
      (when (y-or-n-p "No such directory: make directory?")
        (make-directory d t))
      )
    )
  nil
)
(add-hook 'find-file-not-found-hooks
          'make-directory-unless-directory-exists)


;; octave
;;(autoload 'octave-mode "octave-mod" nil t)
;;(setq auto-mode-alist
;;           (cons '("\\.m$" . octave-mode) auto-mode-alist))
;;(add-hook 'octave-mode-hook
;;               (lambda ()
;;                 (abbrev-mode 1)
;;                (auto-fill-mode 1)
;;                 (if (eq window-system 'x)
;;                     (font-lock-mode t))))


;; font
(font-spec :family "MeiryoKe_Console" :size 24)
(font-spec :family "ヒラギノ角ゴ ProN W3" :size 24 :weight 'bold :slant 'italic);;

;; web-mode 

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))



(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-style-padding 1)
  (setq web-mode-script-padding 1)
  (setq web-mode-block-padding 0)
  (setq web-mode-comment-style 2)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-css-colorization t)
  (setq web-mode-enable-current-column-highlight t)
  (setq web-mode-enable-current-element-highlight t)

)
(add-hook 'web-mode-hook  'my-web-mode-hook)

