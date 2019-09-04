# OktaElixir

Okta interface written in Elixir. Currently only supporting authentication (OpenID/OAuth V2).

## Methods

### short_token_url/0 -> String

Generates URL from which you receive a short-lived access token.

### exchange_short_token/1 (token: String) -> %{}

Returns a struct containing tokens, expires_in, and metadata.

```elixir
%{
  "access_token" => String,
  "expires_in" => Integer,
  "id_token" => String,
  "scope" => String,
  "token_type" => String
}
```

### verify_token/1 (token: String) -> Boolean

Checks if the token provided is valid.

## Installation

Add `okta_elixir` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:okta_elixir, "~> 0.1.0"}
  ]
end
```

Add the required configuration to config/config.exs.

```elixir
config :okta_auth,
  domain: "",
  redirect_uri: "",
  client_id: "",
  client_secret: ""
```
