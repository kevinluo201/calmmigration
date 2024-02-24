# Calmmigration

It collects the Canada IRCC's Express Entry rounds automatically. Users can subscribe to the notifications for the newer rounds. Whenever it has a newer round, it will use HTTP/2 Server Push to push the message. The user's browser's service worker will listen to the push messages and show the notification on their devices.
