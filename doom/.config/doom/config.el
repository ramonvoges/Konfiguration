;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Ramon Voges"
      user-mail-address "ramon.voges@googlemail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font Propo" :size 17)
      doom-big-font (font-spec :family "FiraCode Nerd Font Mono" :size 24))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-nord)
(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)  ;; 'latte, 'frappe, 'macchiato, 'mocha


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(setq python-shell-interpreter "python3")
(setq org-babel-python-command "python3")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Nextcloud/Documents/org/")
(setq org-roam-directory "~/Nextcloud/Documents/org/Zettelkasten")

(after! org
  (setq org-startup-with-inline-images t
        org-image-actual-width nil))  ;; nil = echte Bildbreite verwenden

(use-package! org-roam
  :config
  (org-roam-db-autosync-mode))

(after! org-roam
  (setq org-roam-completion-everywhere t)
  (setq org-roam-capture-templates
        '(;; Standard-Template beibehalten
          ("d" "default" plain "%?"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t)

          ;; === SCHREIBPROJEKTE ===

          ;; Projekt (Übersicht)
          ("p" "Projekt" plain
           "%?\n\n* Chronologie\n\n* Szenen\n\n* Charaktere\n\n* Orte\n"
           :target (file+head "Projekte/${slug}.org"
                              "#+title: ${title}\n#+filetags: :projekt:\n#+created: %<%Y-%m-%d>\n\n")
           :unnarrowed t)

          ;; Charakter
          ("c" "Charakter" plain
           "* Eigenschaften\n\n%?\n\n* Aussehen\n\n* Vorgeschichte\n\n* Entwicklung\n"
           :target (file+head "Charaktere/${slug}.org"
                              "#+title: ${title}\n#+filetags: :charakter:\n#+created: %<%Y-%m-%d>\n")
           :unnarrowed t)

          ;; Ort
          ("o" "Ort" plain
           "* Beschreibung\n\n%?\n\n* Atmosphäre\n\n* Geschichte\n\n* Szenen\n"
           :target (file+head "Orte/${slug}.org"
                              "#+title: ${title}\n#+filetags: :ort:\n#+created: %<%Y-%m-%d>\n\n")
           :unnarrowed t)

          ;; Szene
          ("s" "Szene" plain
           "* Ort\n\n%?\n\n* Beteiligte Charaktere\n\n* Handlung\n\n* Notizen\n"
           :target (file+head "Szenen/${slug}.org"
                              "#+title: ${title}\n#+filetags: :szene:\n#+created: %<%Y-%m-%d>\n\n")
           :unnarrowed t)

          ;; Thema
          ("t" "Thema" plain
           "%?"
           :target (file+head "Themen/${slug}.org"
                              "#+title: ${title}\n#+filetags: :thema:\n#+created: %<%Y-%m-%d>\n\n")
           :unnarrowed t)

          ;; Blog
          ("b" "Blog-Beitrag" plain "%?"
           :target (file+head "Blog/${slug}.org"
                              "#+title: ${title}\n#+filetags: :blog:idee:\n#+created: %<%Y-%m-%d>\n\n")

           :unnarrowed t)
          )))

;; (after! ispell
;;   (setenv "LANG" "de_DE.UTF-8")
;;   (setq ispell-program-name "hunspell")
;;   (ispell-set-spellchecker-params)   ;; wichtig, bevor multi-dic
;;   (ispell-hunspell-add-multi-dic "de_DE,en_GB,fr_FR")
;;   (setq ispell-dictionary "de_DE,en_GB,fr_FR"))

(use-package! jinx
  :hook (doom-first-buffer . global-jinx-mode)
  :config
  ;; Deutsch und Englisch gleichzeitig prüfen
  (setq jinx-languages "de_DE en_GB fr_FR")
  :bind
  ([remap ispell-word] . jinx-correct)
  ("C-M-$" . jinx-languages))

;; ispell-dictionary "de_DE"))   ;; oder "en_US", "de_DE_frami", etc.
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;

(use-package! typst-ts-mode
  :custom
  (typst-ts-mode-watch-options "--open")
  (typst-ts-mode-enable-raw-blocks-highlight t)
  :config
  (add-to-list 'treesit-language-source-alist
               '(typst "https://github.com/uben0/tree-sitter-typst"))
  (add-hook 'typst-ts-mode-hook #'eglot-ensure)
  (setq typst-ts-mode-preview-open-cmd "open -a Skim"))

(after! eglot
  (set-eglot-client! 'typst-ts-mode '("tinymist")))

;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(pushnew! initial-frame-alist
          '(width  . 100)
          '(height . 49))

;; (add-hook 'window-setup-hook #'toggle-frame-maximized)

(setq projectile-project-search-path
      '("~/Skripte/" "~/Nextcloud/Documents/org/" "~/Nextcloud/Documents/Briefe/"))
