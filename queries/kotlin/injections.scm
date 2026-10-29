(source_file
  (import_list
    (import_header
      (identifier) @_i (#eq? @_i "org.springframework.data.jdbc.repository.query.Query")))
  (class_declaration
    (class_body
      (function_declaration
        (modifiers
          (annotation
            (constructor_invocation
              (user_type) @_u (#eq? @_u "Query")
              (value_arguments
                (value_argument
                  (string_literal) @injection.content
                  (#offset! @injection.content 0 1 0 -1)
                  (#set! injection.language "sql")
                  (#set! injection.include-children))))))))))
