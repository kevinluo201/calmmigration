# Calmmigration

It collects the Canada IRCC's Express Entry rounds automatically. Users can subscribe to the notifications for the newer rounds. Whenever it has a newer round, it will use HTTP/2 Server Push to push the message. The user's browser's service worker will listen to the push messages and show the notification on their devices.

## Development Environment setup (on Mac)
### Install Ruby
1. install Homebrew https://brew.sh/
2. install rbenv https://github.com/rbenv/rbenv?tab=readme-ov-file#homebrew with homebrew
3. after install rbenv, execute `rbenv install 3.1.2` to install ruby 3.1.2

### Setup the project
1. go to the project directory
2. execute `bundle install`
3. execute `rm config/credentials.yml.enc`
4. execute `EDITOR=vim rails credentials:edit` and then save and quit
5. run `bundle exec rails c` to open the Rails Console
  1. In the Rails Console, run `vapid_key = WebPush.generate_key`
  2. check the values of `vapid_key.public_key` and `vapid_key.private_key`
6. execute `EDITOR=vim rails credentials:edit` again, edit it like below then save
```yaml
secret_key_base: a secret
webpush:
  public_key: vapid_key.public_key you saw in the previous step
  private_key: vapid_key.private_key you saw in the previous step
```
7. initialize database byt running `bundle exec rails db:create db:migrate db:seed`

### Start dev server
1. execute `rails s`
2. open a new tab in terminal and execute `bin/vite dev`
3. open 'localhost:3000' in the browser
