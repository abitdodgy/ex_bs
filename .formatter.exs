# Used by "mix format"
[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  import_deps: [:ex_component],
  locals_without_parens: [deftag: 1, defcontenttag: 2],
  line_length: 120
]
