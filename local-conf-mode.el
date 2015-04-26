;;
;; A minor mode that loads skeletons defined in a version controlled project
;; in parent directories of the cwd.
;; The default name used for the custom skeleton definition file can be changed.
;; The skeleton definition file is loaded by emacs as soon as it is discovered.
;;
;; Author: Alfredo Mazzinghi (qwattash)
;; 
;; License: GPLv3
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;;     along with this program.  If not, see <http://www.gnu.org/licenses/>.
;; 

(defcustom local-conf-mode-file
  "emacs-local.el"
  "File loaded from version control root if possible"
  :group 'local-conf-mode)

(defun local-conf-load ()
  "Load local emacs file if any"
  (let ((vc-root (local-conf-get-vc-root)))
    (if (null vc-root)
	nil
      (let ((local-file (concat (file-name-as-directory vc-root) local-conf-mode-file)))
	(if (file-exists-p local-file)
	    (progn
	      (message (concat "Loading " local-file))
	      (load local-file))
	  nil)))))

;; currently only support git
(defun local-conf-get-vc-root ()
  "Get the version control root in which the pwd is contained.
If the cwd is not under version control return nil"
  (condition-case err
      (let ((vc-root-list (process-lines "git" "rev-parse" "--show-toplevel")))
	(car vc-root-list))
    (error
     nil)))

(define-minor-mode local-conf-mode
  "A minor mode that loads project-local emacs files"
  :lighter " local-conf"
  :group 'local-conf-mode
  (local-conf-load))
  
(provide 'local-conf-mode)
