;;; caskxy-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "caskxy" "caskxy.el" (22663 35589 493723 0))
;;; Generated autoloads from caskxy.el

(autoload 'caskxy/add-tester-backend "caskxy" "\
Add a test function.

BACKEND is the feature of the function.
BUILDER is the function to make a command string for test.
  The function receives one argument that is the list of test file path.
FILTER is the function to do something for the buffer of the test result.
  The function receives one argument that is the buffer object of the test result.
  If nothing to do, this value is no need.

\(fn BACKEND &key BUILDER FILTER)" nil nil)

(autoload 'caskxy/set-emacs-runtime "caskxy" "\
Set the condition of emacs runtime.

EMACS is the executable path of the emacs runtime used for test.

\(fn &optional EMACS)" t nil)

(autoload 'caskxy/set-cask-file "caskxy" "\
Set the condition of project path.

CASK-FILE is the path of 'Cask' file in the tested project.

\(fn CASK-FILE)" t nil)

(autoload 'caskxy/set-tester-backend "caskxy" "\
Set BACKEND to `caskxy/tester-backend'.

\(fn BACKEND)" t nil)

(autoload 'caskxy/show-condition "caskxy" "\
Show current condition.

\(fn)" t nil)

(autoload 'caskxy/do-cask-command "caskxy" "\
Execute the command of Cask.

COMMAND is the string equals the sub command of 'cask' command on shell.
RESULT-AS-STRING is boolean. If non-nil, return the string of the result of 'cask' command.

\(fn COMMAND &optional RESULT-AS-STRING)" t nil)

(autoload 'caskxy/run-test "caskxy" "\
Run test of TEST-FILE.

TEST-FILE is the path of test file.
But if TEST-FILE is 'all, do the tests of all test files in the project.

\(fn TEST-FILE)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; caskxy-autoloads.el ends here
