use Mix.Config

if Mix.env == :dev do
  config :facebook_messenger,
    facebook_page_token: System.get_env("ACCESS_TOKEN"),
    challenge_verification_token: System.get_env("VERIFY_TOKEN")
else
  config :facebook_messenger,
    facebook_page_token: System.get_env("ACCESS_TOKEN"),
    challenge_verification_token: System.get_env("VERIFY_TOKEN")
end
