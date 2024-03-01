# Calmmigration

It collects the Canada IRCC's Express Entry rounds automatically. Users can subscribe to the notifications for the newer rounds. Whenever it has a newer round, it will use HTTP/2 Server Push to push the message. The user's browser's service worker will listen to the push messages and show the notification on their devices.

## Development Environment setup (on Mac)
1. install Homebrew https://brew.sh/
2. install rbenv https://github.com/rbenv/rbenv?tab=readme-ov-file#homebrew
3. install Postgres https://www.postgresql.org/download/macosx/
4. install libpq `brew install libpq`
5. go to the project directory
6. execute `bundle install`
7. execute `rails db:migrate`
8. execute `rails s`
