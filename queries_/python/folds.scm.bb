; Fold function bodies (def, async def)
 (function_definition
   body: (block) @fold)

 ;(async_function_definition
 ;  body: (block) @fold)

 ; Fold @property decorated methods
 (decorated_definition
   (decorator
     (call
       function: (identifier) @property-decorator
       arguments: (argument_list) ?))
   (function_definition
     body: (block) @fold)
   (#match? @property-decorator "^property$"))

 ; Fold enum bodies (class_definition with Enum base class)
 (class_definition
   (argument_list
     (keyword_argument
       name: (identifier) @enum-base
       value: (identifier) (#eq? @enum-base "Enum"))) @fold
   body: (
     (expression_statement) @fold.inner
     (assignment) @fold.inner
     (pass_statement) @fold.inner
   ))

 ; Fold dataclass bodies (decorated_definition with dataclass decorator)
 (decorated_definition
   (decorator
     (call
       function: (identifier) @dataclass-decorator
       arguments: (argument_list) ?))
   (class_definition
     body: (
       (expression_statement) @fold.inner
       (assignment) @fold.inner
       (pass_statement) @fold.inner
     ) @fold)
   (#match? @dataclass-decorator "^dataclass$"))

 ; Generic fold for class bodies that are not functions (e.g., attributes)
 ; This is a more general approach to catch attributes within classes
 (class_definition
   body: (block
     (expression_statement) @fold.inner
     (assignment) @fold.inner
     (pass_statement) @fold.inner
     (string) @fold.inner ; Docstrings
   ) @fold
   ; Exclude function definitions from this generic fold if they are already handled
    ; by the function_definition query
    (not
      (function_definition)
    )
    (not
      (async_function_definition)
    )
  )

  ; Generic fold for top-level code blocks that are not functions or classes
  ; This might catch top-level statements if they form a logical block
  (module
    (expression_statement) @fold.inner
    (assignment) @fold.inner
    (pass_statement) @fold.inner
    (string) @fold.inner ; Top-level docstrings
    (not
      (class_definition)
    )
    (not
      (function_definition)
    )
    ;(not (async_function_definition))
  )
