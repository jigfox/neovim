; extends
; (block_mapping_pair
;   key: (scalar) @key (#eq? @key "patches")
;   value: (block_node (block_scalar) @content (#set! injection.language "yaml")))
; (block_sequence_item
;   (block_node
;     (block_scalar
;       (string_scalar) @injection.content)))
;   (#set! injection.language "yaml")
; ((block_scalar) @injection.content
;  (#set! injection.language "yaml"))
; (block_mapping_pair
;   key: (_) @_key (#eq? @_key "patches")
;   value: (block_node
;            (block_sequence
;              (block_sequence_item
;                (block_node
;                  (block_scalar) @injection.content)))))
; (#set! injection.language "yaml")
(
  (block_mapping_pair
    key: (flow_node
      (plain_scalar
        (string_scalar) @_key
      )
    )
    value: (block_node
      (block_sequence
        (block_sequence_item
          (block_node
            (block_scalar) @injection.content
          )
        )
      )
    )
  )
  (#eq? @_key "patches")
  (#offset! @injection.content 1 0 0 0)
  (#set! injection.language "yaml")
)
