use Mix.Config

if Mix.env == :dev do
  config :facebook_messenger,
    facebook_page_token: "123123",
    challenge_verification_token: "333333"
end
