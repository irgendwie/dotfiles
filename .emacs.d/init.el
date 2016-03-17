(menu-bar-mode -1)
(global-set-key "\C-xc" 'compile)

;; https://stackoverflow.com/questions/3586089/prevent-emacs-from-mixing-tabs-and-spaces
(add-hook 'js-mode-hook
	  '(lambda()
	     (setq indent-tabs-mode 't
		   tab-width '4)))
