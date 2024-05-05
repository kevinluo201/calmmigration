# Calmmigration

It collects the Canada IRCC's Express Entry rounds automatically. Users can subscribe to the notifications for the newer rounds. Whenever it has a newer round, it will use HTTP/2 Server Push to push the message. The user's browser's service worker will listen to the push messages and show the notification on their devices.

## Development Environment setup (on Mac)
1. install Homebrew https://brew.sh/
2. install rbenv https://github.com/rbenv/rbenv?tab=readme-ov-file#homebrew with homebrew
3. after install rbenv, execute `rbenv install 3.1.2` to install ruby 3.1.2
4. go to the project directory
5. execute `rm config/credentials.yml.enc`
6. execute `EDITOR=vim rails credentials:edit` and then save and quit
7. execute `bundle install`
8. execute `bundle exec rails db:create db:migrate db:seed`
9. execute `rails s`
10. open a new tab in terminal and execute `bin/vite dev`
11. open 'localhost:3000' in the browser
