;;; lsp-apachecamel.el

;; Version: 0.1
;; Homepage: https://github.com/camel-tooling/camel-lsp-client-emacs
;; Package-Requires: ((emacs "25.1") (lsp-mode "5"))
;; Keywords: languages, lsp, camel, fuse, integration

;;; Code:

(defcustom lsp-apachecamel-executable
  "sourcekit"
  "Path of the lsp-apachecamel executable."
  :type 'file
  :group 'apachecamel)
  
(defcustom lsp-apachecamel-extra-args
  nil
  "Additional command line options passed to the lsp-apachecamel executable."
  :type '(repeat string)
  :group 'apachecamel)
  
(defun lsp-apachecamel--lsp-command ()
  "Generate the language server startup command."
  `(,lsp-apachecamel-executable
    ,@lsp-apachecamel-extra-args))

(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection 'lsp-apachecamel--lsp-command)
                  :activation-fn (lambda (file-name _mode)
                                   (string= (f-ext file-name) "xml"))
                  :server-id 'apachecamel-ls))

(provide 'lsp-apachecamel)
;;; lsp-apachecamel.el ends here