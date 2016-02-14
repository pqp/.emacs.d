(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(setq package-list
      '(evil evil-leader key-chord window-numbering))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
