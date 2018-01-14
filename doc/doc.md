# Start server

    # export keys
    export ACCESS_TOKEN='XXXX'
    export VERIFY_TOKEN='XXXXX'
    # start server
    PORT=5000 mix run --no-halt

## route to localhost through ngrok

    ngrok http 5000 


```
curl -X POST -H "Content-Type: application/json" -d '{
  "messaging_type": "NON_PROMOTIONAL_SUBSCRIPTION",
  "recipient": {
    "id": "1629070620483444"
  },
  "message": {
    "text": "hello, world!"
  }
}' "https://graph.facebook.com/v2.6/me/messages?access_token=EAACQMQJnCPABACmPpQevHh6GhZBhBl8kNHgU4ImMogE4a9ejFApnpLkx9WS2os6ZBOZBbB2D5JuxtSfupoOyb3rd9PGhZCu95Bu0Vc8sZBZBcZCcWZA7Vjkf0g4cZCWAsJ4qheFWGJlEZBhbYYm8yt2YHAK8Ia3PMfGFpZBWZAalAwDLhAZDZD"
```


### Create a message creative   
```
curl -X POST -H "Content-Type: application/json" -d '{    
  "messages": [
    {
      "text": "Furt ist zu"
    }
  ]
}' "https://graph.facebook.com/v2.11/me/message_creatives?access_token=EAACQMQJnCPABACmPpQevHh6GhZBhBl8kNHgU4ImMogE4a9ejFApnpLkx9WS2os6ZBOZBbB2D5JuxtSfupoOyb3rd9PGhZCu95Bu0Vc8sZBZBcZCcWZA7Vjkf0g4cZCWAsJ4qheFWGJlEZBhbYYm8yt2YHAK8Ia3PMfGFpZBWZAalAwDLhAZDZD"

```
### Send broadcast of creative
```
curl -X POST -H "Content-Type: application/json" -d '{    
  "message_creative_id": 412829792507251,
  "notification_type": "REGULAR",
  "tag": "TRANSPORTATION_UPDATE"
}' "https://graph.facebook.com/v2.11/me/broadcast_messages?access_token=EAACQMQJnCPABACmPpQevHh6GhZBhBl8kNHgU4ImMogE4a9ejFApnpLkx9WS2os6ZBOZBbB2D5JuxtSfupoOyb3rd9PGhZCu95Bu0Vc8sZBZBcZCcWZA7Vjkf0g4cZCWAsJ4qheFWGJlEZBhbYYm8yt2YHAK8Ia3PMfGFpZBWZAalAwDLhAZDZD"

```
