;; extends
; highlights.scm is query file for finding
; highlight captures.
;
; I'm in ~/.config/nvim/queries/angular/highlights.scm
;   This powers the angular syntax highlighting in neovim


(icu_category) @keyword.contitional
(icu_clause) @type
(icu_case ["{" "}"] @punctuation.bracket)
(icu_expression [","] @punctuation.delimiter)
(icu_expression ["{" "}"] @punctuation.special)
