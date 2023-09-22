(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Instalación de LSP (Language Server Protocol) 
(unless (package-installed-p 'lsp-mode)
  (package-refresh-contents)
  (package-install 'lsp-mode))

;; Configuración para usar Conda en Emacs
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Establece la ruta del ejecutable de Python de Conda
(setq python-shell-interpreter "C:/Users/liuka/miniconda3/envs/spyder-env/python.exe")
;; Establece la ruta de activate script de Conda
(setq python-shell-args '("--init-file" "c:/Users/liuka/miniconda3/Scripts/activate" "C:/Users/liuka/miniconda3/envs/spyder-env/python.exe"))
;;configuracion de python
(setenv "PATH" (concat "C:/Users/liuka/miniconda3/envs/spyder-env/python.exe" (getenv "PATH")))
(setq exec-path (append '("C:/Users/liuka/miniconda3/envs/spyder-env/python.exe") exec-path))
;; Establecer la ruta al intérprete de Python de Miniconda
(setq python-shell-interpreter "C:/Users/liuka/miniconda3/envs/spyder-env/python.exe")
;; Agregar la ruta de los scripts de Miniconda al PATH de Emacs
(setq exec-path (append '("C:/Users/liuka/miniconda3/Scripts") exec-path))
;; Configurar el shell interactivo de Python
(setq python-shell-interpreter-args "-i")

(defun run-python-file ()
  "Ejecutar el archivo Python activo."
  (interactive)
  (let ((python-script (buffer-file-name)))
    (shell-command (concat "python " python-script))))

;; Asignar un atajo (por ejemplo, F5) para ejecutar el archivo Python
(global-set-key (kbd "<f5>") 'run-python-file)

;;tema del completado
(defun lsp--sort-completions (completions)
  (lsp-completion--sort-completions completions))

(defun lsp--annotate (item)
 (lsp-completion--annotate item))

(defun lsp--resolve-completion (item)
 (lsp-completion--resolve item))

;; Definir una función para determinar el identificador de lenguaje para emacs-lisp-mode
(defun my-lsp-emacs-lisp-language-id (_workspace _params)
  "Return the language ID for emacs-lisp-mode."
  "emacs-lisp")

;; Configurar lsp-language-id-configuration para emacs-lisp-mode
(setq lsp-language-id-configuration
      '((emacs-lisp-mode . "emacs-lisp")))

;; Configurar la función para el modo emacs-lisp
(setq lsp-language-id-configuration
      (append lsp-language-id-configuration
              '((emacs-lisp-mode . my-lsp-emacs-lisp-language-id))))

;; Definir una función para determinar el identificador de lenguaje para python-mode
(defun my-lsp-python-language-id (_workspace _params)
  "Return the language ID for python-mode."
  "python")

;; Configurar lsp-language-id-configuration para python-mode
(setq lsp-language-id-configuration
      '((python-mode . "python")))

;; Configurar la función para el modo python
(setq lsp-language-id-configuration
      (append lsp-language-id-configuration
              '((python-mode . my-lsp-python-language-id))))

;;Configuracion de ruff-lsp
;(require 'lsp)
;(setq lsp-ruff-command "C:/Users/liuka/miniconda3/envs/spyder-env/Scripts/ruff.exe")
;(add-hook 'python-mode-hook #'lsp)

;;Configuración de pylsp
(require 'lsp)
(add-hook 'python-mode-hook #'lsp)


;; Establece una fuente personalizada (opcional)
(set-frame-font "Fira Code Retina-14" nil t)

;; Configura el cursor (opcional)
(setq-default cursor-type 'bar)

;; Configura el tamaño de la ventana (opcional)
(add-to-list 'default-frame-alist '(width . 100))
(add-to-list 'default-frame-alist '(height . 30))

;; Configuración de colores para js2-mode
(custom-set-faces
  ;; Cambia el color de fondo del fondo de los números
  '(js2-external-variable ((t (:foreground "purple")))) ; Variables externas
  '(js2-function-param ((t (:foreground "blue"))))       ; Parámetros de función
  '(js2-function-call ((t (:foreground "green"))))       ; Llamadas de función
  '(js2-object-property ((t (:foreground "cyan"))))      ; Propiedades de objeto
  '(js2-jsdoc-tag ((t (:foreground "dark orange"))))     ; Etiquetas de JSDoc
  '(js2-error ((t (:foreground "red"))))                 ; Errores
  '(js2-warning ((t (:underline "yellow"))))             ; Advertencias
  '(js2-external-variable ((t (:foreground "purple"))))   ; Variables externas
  '(js2-private-function-call ((t (:foreground "blue")))) ; Llamadas a funciones privadas
  '(js2-private-member ((t (:foreground "purple")))))    ; Miembros privados

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

(set-face-attribute 'default nil
                    :font "Fira Code Retina"
                    :height 120)

(set-face-attribute 'mode-line nil
                    :box nil) ;; Eliminar la caja alrededor de la barra de modo
(setq inverse-video nil) ;; Dar vuekta numero de lineas

;;Tema y Fuente

(tool-bar-mode -1)  ;; Ocultar la barra de herramientas
(menu-bar-mode -1)  ;; Ocultar la barra de menú
(scroll-bar-mode -1) ;; Ocultar la barra de desplazamiento

;;Cambios de Color y Estilo

(set-cursor-color "#ffffff")    ;; Cambiar el color del cursor a blanco
(set-background-color "#282c34") ;; Cambiar el color de fondo
(set-foreground-color "#abb2bf") ;; Cambiar el color del texto

;;Márgenes y Espaciado
(setq-default left-margin-width 1 right-margin-width 1) ; Ajustar márgenes
(setq-default line-spacing 0.1)                        ; Espaciado entre líneas

;;Modificar el Cursor
(setq-default cursor-type 'bar)  ;; Cambiar el tipo de cursor a una barra

;;Resaltar la Línea Actual
(global-hl-line-mode +1) ;; Resaltar la línea actual

;;Configuración de Números de Línea
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative) ;; Muestra números relativos

;;Configuración de Modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;;Instalar Treemacs
(use-package treemacs
  :ensure t
  :bind ("<f8>" . treemacs))
;; Opcional: Configura el ancho inicial de la ventana de Treemacs
(setq treemacs-width 20)

;; Opcional: Configura el tema del icono
(setq treemacs-theme 'all-the-icons)

;; Instala el paquete page-break-lines si aún no está instalado
(unless (package-installed-p 'page-break-lines)
  (package-refresh-contents)
  (package-install 'page-break-lines))

;; Configuración de la página de inicio minimalista
(setq inhibit-startup-screen t)  ; Deshabilita la pantalla de inicio estándar

;; Configura el estilo de línea de separación
(require 'page-break-lines)
(global-page-break-lines-mode)

;; Cargar el paquete recentf
(require 'recentf)

;; Habilitar el modo recentf, que mantiene un historial de archivos recientes
(recentf-mode 1)

;; Mensaje de bienvenida con una cita de Charles Bukowski
(setq initial-scratch-message
      (concat
       "               \n"
       "  \n\n\n\n\n\n"
       "\n\t\t\t\t\t""\"La vida es como un caballo jodido. A veces te subes a él "
              "y a veces te arrastra por la mierda.\"\n\n"
              "\t\t\t\t\t\t\t\t\t\t— Charles Bukowski\n\n"
	      "Archivos Recientes:\n"  ;; Título para la lista de archivos recientes
	      "--------------------\n"
	      (mapconcat 'identity recentf-list "\n")  ;; Concatenar la lista de archivos recientes
	      "\n\n"))

;; Configurar la cantidad de archivos a mostrar en la lista de recientes
(setq recentf-max-menu-items 5)  ;; Mostrar los 5 archivos más recientes

;; Atajo para guardar
(global-set-key (kbd "C-s") 'save-buffer)

;; Atajo para deshacer
(global-set-key (kbd "C-z") 'undo)

;; Atajo para rehacer
(global-set-key (kbd "C-S-z") 'redo)

;; Atajo para buscar
(global-set-key (kbd "C-f") 'isearch-forward)

;; Atajo para buscar y reemplazar
(global-set-key (kbd "C-r") 'query-replace)

;; Atajo para seleccionar toda la buffer
(global-set-key (kbd "C-h") 'mark-whole-buffer)

;; Atajo para abrir un nuevo buffer
(global-set-key (kbd "C-n") 'new-buffer)

;; Atajo para cerrar Emacs
(global-set-key (kbd "C-x C-c") 'save-buffers-kill-terminal)


;; Atajo para ingresar a ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Iniciar Emacs en pantalla completa
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Función para abrir un archivo reciente
(defun open-recent ()
  "Abre un archivo reciente"
  (interactive)
  (recentf-open-files))

;; Asigna la función a una combinación de teclas
(global-set-key (kbd "C-c r") 'open-recent)

;; Ajusta la ruta del binario de Cygwin
(setq exec-path (append exec-path '("c:/cygwin64/bin")))

;; Establece la shell para Cygwin
(setq shell-file-name "bash")
(setq explicit-shell-file-name shell-file-name)
(setq explicit-bash.exe-args '("--noediting" "--login" "-i"))

(add-hook 'c-mode-hook
         (lambda ()
           (setq compile-command (concat "gcc -mwindows -Wall -o " (file-name-sans-extension (buffer-file-name)) " " (buffer-file-name)))
            (define-key c-mode-map (kbd "C-c C-c") 'compile)))

(add-hook 'c++-mode-hook
          (lambda ()
           (setq compile-command (concat "g++ -mwindows -Wall -o " (file-name-sans-extension (buffer-file-name)) " " (buffer-file-name)))
            (define-key c++-mode-map (kbd "C-c C-c") 'compile)))

;; Instala y configura corfu
(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.0)
  (corfu-quit-at-bundary 'separator)
  (corfu-echo-documentation 0.1)
  (corfu-preview-current 'insert)
  (corfu-preselect-first t)
  :init
  (global-corfu-mode)
  (corfu-history-mode)
  :config
  ;; Configuración adicional si es necesaria
  )

;; Establece la posición de la ventana de selección de Corfu
(setq corfu-cycle t)

;; Establece la ubicación de la ventana de selección de Corfu
(setq corfu-echo-documentation t)

;; Teclas para seleccionar candidatos
(define-key corfu-map (kbd "<tab>") 'corfu-next)
(define-key corfu-map (kbd "<backtab>") 'corfu-previous)


;;Codificación predeterminada
;; Establece Latin-1 como codificación predeterminada para los buffers
(prefer-coding-system 'latin-1)
(set-default-coding-systems 'latin-1)
(set-terminal-coding-system 'latin-1)
(set-keyboard-coding-system 'latin-1)
