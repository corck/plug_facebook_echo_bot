use Mix.Config

if Mix.env == :dev do
  config :facebook_messenger,
    facebook_page_token: "123123",
    challenge_verification_token: "333333"
else
  config :facebook_messenger,
    facebook_page_token: System.get_env("PAGE_TOKEN"),
    challenge_verification_token: System.get_env("VERIFY_TOKEN")
end
