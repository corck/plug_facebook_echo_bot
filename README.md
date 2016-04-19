# Ex Plug Echo Bot [![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)
Ex Echo Bot is an example of a facebook messenger bot that echos whats sent to it.

# Usage
The easist way is using Heroku deploy button (from above).

Or manually, to start your plug app:

```
mix deps.get
PORT=8080 PAGE_TOKEN="FB_PAGE_TOKEN" VERIFY_TOKEN="FB_VERIFY_TOKEN" mix run --no-halt
```

Now you can visit [`localhost:8080`](http://localhost:8080) from your browser.

The webhook api endpoint is at:
`https://your_url/messenger/webhook`

# Configurations
When starting it in production, you need to set the following environment varibles

`VERIFY_TOKEN` the facebook verification token that will be sent in the facebook challenge.
`PAGE_TOKEN` the facebook page token you will use with your app.
`PORT` the port to start it on

To get the `VERIFY_TOKEN` and `PAGE_TOKEN` follow the instructions [here ](https://developers.facebook.com/docs/messenger-platform/quickstart)

This project uses [EXFacebook-Messenger](https://github.com/oarrabi/EXFacebook-Messenger) as a dependency to create the chat bot.
