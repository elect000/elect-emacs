;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 初期表示位置、サイズ
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq initial-frame-alist
      '((left   . 100)			; 位置 (X)
	(top    .  50)			; 位置 (Y)
	(width  . 120)			; サイズ(幅)
	(height .  40)			; サイズ(高さ)
	))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; スクロール
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; スクロールした際のカーソルの移動行数
(setq scroll-conservatively 1)

;; スクロール開始のマージンの行数
(setq scroll-margin 10)


;; 1 画面スクロール時に重複させる行数
(setq next-screen-context-lines 10)

;; 1 画面スクロール時にカーソルの画面上の位置をなるべく変えない
(setq scroll-preserve-screen-position t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; 検索、置換時の大文字、小文字の区別
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; オプションの "Ignore Case for Search" で設定可
;;
;; ;; 検索(全般)
;; (setq case-fold-search t)
;;
;; ;; インクリメンタルサーチ
;; (setq isearch-case-fold-search nil)


;; バッファー名の検索
(setq read-buffer-completion-ignore-case t)

;; ファイル名の検索
(setq read-file-name-completion-ignore-case t)


;;;置換(全般)
;; (setq case-replace t)

;; dabbrev 時の置換
(setq dabbrev-case-replace nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; 自動作成ファイル
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; backup ファイルオープン時のバックアップ (xxx~)
;; ================================================================

;; 実行の有無
(setq make-backup-files t)

;; 格納ディレクトリーの変更
;;   (対象ディレクトリー . 格納ディレクトリー) のリスト
(setq backup-directory-alist '((".*" . "~/.ehist")))


;; 番号付けによる複数保存
(setq version-control     t)  ;; 実行の有無
(setq kept-new-versions   5)  ;; 最新の保持数
(setq kept-old-versions   1)  ;; 最古の保持数
(setq delete-old-versions t)  ;; 範囲外を削除



;; auto-save 自動保存ファイル (#xxx#)
;; ================================================================

;; ;; 実行の有無
;; (setq auto-save-default nil)

;; ;; 格納ディレクトリーの変更
;; ;;   (対象ファイルのパターン . 保存ファイルパス) のリスト
;; (setq auto-save-file-name-transforms
;;       (append auto-save-file-name-transforms
;; 	      '((".*" "~/tmp/" t))))


;; 保存の間隔
(setq auto-save-timeout 10)	 ;; 秒   (デフォルト : 30)
(setq auto-save-interval 100)	 ;; 打鍵 (デフォルト : 300)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; パッケージ
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (require 'package nil t)
  (setq package-archives
	(append package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
				   ("marmalade" . "http://marmalade-repo.org/packages/"))))
  (package-initialize))
;; because of el-get


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
    (set-background-color "Black")
    (set-foreground-color "LightGray")
    (set-cursor-color "Gray")
    (set-frame-parameter nil 'alpha 70) ;透明度
    ))



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

;; autopair
(autopair-global-mode t)

;; org-mode
(require 'ox-latex)
(add-to-list 'org-latex-classes
	     '("koma-article"
	       "\\documentclass{scrartcl}
		\\usepackage[dvipdfmx]{graphicx}
		\\usepackage{biblatex}
		\\usepackage{url}
		\\usepackage{indentfirst}
		[NO-DEFAULT-PACKAGES]
		[EXTRA]"
	       ("\\section{%s}"."\\section*{%s}")
	       ("\\subsection{%s}"."\\subsection*{%s}")
	       ("\\subsubsection{%s}"."\\subsubsection*{%s}")
	       ("\\paragraph{%s}"."\\paragraph*{%s}")
	       ("\\subparagraph{%s}"."\\subparagraph{%s}")))

(setq org-latex-with-hyperref nil)
(setq org-src-fontify-natively t)
