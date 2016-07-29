(menu-bar-mode -1)
(global-set-key "\C-xc" 'compile)

;; https://stackoverflow.com/questions/3586089/prevent-emacs-from-mixing-tabs-and-spaces
(add-hook 'js-mode-hook
	  '(lambda()
	     (setq indent-tabs-mode 't
		   tab-width '4)))

;; Markdown stuff
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md\\'" . markdown-mode) auto-mode-alist))

;; Haskell stuff
(autoload 'haskell-mode "haskell-mode.el"
  "Haskell mode for editing Haskell files" t)
(setq auto-mode-alist
      (cons '("\\.hs\\'" . haskell-mode) auto-mode-alist))

;; Theme
(load-theme 'tango-dark)
