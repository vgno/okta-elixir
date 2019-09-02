defmodule OktaElixir do
  @okta_domain_url "https://#{Application.get_env(:okta_auth, :domain)}"
  @okta_post_url "#{@okta_domain_url}/ouath/v1/token"
  @okta_keys_url "#{@okta_domain_url}/v1/keys"

  alias OktaElixir.Randomizer

  def short_token_url do
    redirect_uri = URI.encode(Application.get_env(:okta_auth, :redirect_uri))
    client_id = Application.get_env(:okta_auth, :client_id)

    "#{@okta_domain_url}/oauth2/v1/authorize?client_id=#{client_id}&response_type=code&state=#{
      Randomizer.randomizer(10)
    }&scope=openid&redirect_uri=#{redirect_uri}"
  end

  def exchange_short_token(code) do
    headers = [
      Accept: "application/json",
      Authorization: "Basic #{get_basic_header()}",
      "Content-Type": "application/x-www-form-urlencoded"
    ]

    HTTPoison.post(@okta_post_url, generate_post_body(code), headers)
    |> handle_response
  end

  defp get_public_keys do
    HTTPoison.get(@okta_keys_url)
    |> handle_response
  end

  defp generate_post_body(code) do
    redirect_uri = Application.get_env(:okta_auth, :redirect_uri)

    "grant_type=authorization_code&redirect_uri=#{redirect_uri}&code=#{code}"
  end

  defp get_basic_header do
    client_id = Application.get_env(:okta_auth, :client_id)
    client_secret = Application.get_env(:okta_auth, :client_secret)

    Base.encode64("#{client_id}:#{client_secret}")
  end

  defp handle_response(response) do
    case response do
      {:ok, %HTTPoison.Response{body: body}} ->
        {:ok, Jason.decode!(body)}

      {:error, error} ->
        {:error, error}
    end
  end
end
