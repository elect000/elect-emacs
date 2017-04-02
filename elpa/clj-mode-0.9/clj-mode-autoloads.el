;;; clj-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "clj-mode" "clj-mode.el" (22717 32954 524009
;;;;;;  999000))
;;; Generated autoloads from clj-mode.el

(autoload 'clj-mode "clj-mode" "\
Major mode for editing Clojure code - similar to Lisp mode.
Commands:
Delete converts tabs to spaces as it moves back.
Blank lines separate paragraphs.  Semicolons start comments.
\\{clj-mode-map}
Note that `run-lisp' may be used either to start an inferior Lisp process
or to switch back to an existing one.

Entry to this mode calls the value of `clj-mode-hook'
if that value is non-nil.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.clj$" . clj-mode))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; clj-mode-autoloads.el ends here
