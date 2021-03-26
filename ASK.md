#### Question
After archive/unarchive we want to inform other users via email, webhooks and push-notifications. provide an approach how this can be implemented


#### Answer
- Sending email: Rails ships with ActionMailer that can be used to send emails. This mail should be sent using a worker like ActiveJob (or Sidekiq) so that a delay or email sending failure does not after the application flow. The worker triggering the mail would be called after the user has been archived (@user.soft_delete) or unarchived (@user.recover)

<br />

- Webhooks: If we need to call a webhook, just like in the case of sending emails, we should call it after the user has been archived or unarchived and also within a worker. Having the webhook call within a worker once again is to allow the application not to take a long time to finish the request as webhooks are usually POST requests to another server/service.

<br />

- Sending push-notifications: ActionCable comes in handy in adding a push notification to the application. Action cable would be setup both on the rails API-only server and the frontend consuming it. When the user as been archived or unarchived, ActionCable broadcasts the message to be displayed. The consuming clients then recieve this message and using the browser Notification API, the push notification is displayed to users. Also there are gems like rpush and webpush for this as well which would require a push server like google.
