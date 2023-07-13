[
  plugins: [Phoenix.LiveView.HTMLFormatter],
  inputs: [
    # <- include heex here
    "*.{heex,ex,exs}",
    "priv/*/seeds.exs",
    # <- include heex here
    "{config,lib,test}/**/*.{heex,ex,exs}"
  ]
]
