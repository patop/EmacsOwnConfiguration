(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Instalación de LSP (Language Server Protocol) y Company Mode
(unless (package-installed-p 'lsp-mode)
  (package-install 'lsp-mode))

(unless (package-installed-p 'company)
  (package-install 'company))

;; Configuración de LSP para un lenguaje específico
(require 'lsp-mode)
(add-hook 'python-mode-hook #'lsp)
(add-hook 'js2-mode-hook #'lsp)

;; Configuración de Company Mode para trabajar con LSP
(require 'company)

;; Usar 'company-capf' como backend para completar con LSP
(add-to-list 'company-backends 'company-capf)

;; Asignar una tecla para la finalización de Company
(global-set-key (kbd "C-c c") 'company-complete)

(global-company-mode) ; Activa company-mode globalmente
(add-hook 'after-init-hook 'global-company-mode) ; Habilita company-mode en todos los buffers
(setq company-idle-delay 0.2)                    ; Retraso antes de mostrar sugerencias
(setq company-minimum-prefix-length 1)            ; Mínimo de caracteres para mostrar sugerencias

;; Agregar Company LSP al backend de Company Mode
(add-to-list 'company-backends 'company-lsp)

;; Asignar una tecla para la finalización de Company
(global-set-key (kbd "C-c c") 'company-complete)

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

;; Iniciar Emacs en pantalla completa
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Función para abrir un archivo reciente
(defun open-recent ()
  "Abre un archivo reciente"
  (interactive)
  (recentf-open-files))

;; Asigna la función a una combinación de teclas
(global-set-key (kbd "C-c r") 'open-recent)





