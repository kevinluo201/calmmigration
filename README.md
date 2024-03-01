# Calmmigration

It collects the Canada IRCC's Express Entry rounds automatically. Users can subscribe to the notifications for the newer rounds. Whenever it has a newer round, it will use HTTP/2 Server Push to push the message. The user's browser's service worker will listen to the push messages and show the notification on their devices.

## Development Environment setup (on Mac)
1. install Homebrew https://brew.sh/
2. install rbenv https://github.com/rbenv/rbenv?tab=readme-ov-file#homebrew
3. after install rbenv, execute `rbenv install 3.1.2` to install ruby 3.1.2
4. install Postgres https://www.postgresql.org/download/macosx/
5. install libpq `brew install libpq`
6. go to the project directory
7. put `master.key` under `/config`
8. execute `bundle install`
9. execute `bundle exec rails db:create db:migrate db:seeds`
10. execute `rails s`
