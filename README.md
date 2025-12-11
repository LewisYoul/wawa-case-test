# README

## Local Development

Prerequisites:

* Ruby 3.3.5
* Rails 8.1.1
* A local PostgreSQL service. If you are using a MAc this is installable using homebrew via `brew install postgresql@17` or whichever version you prefer. The service can then be started with `brew services start postgresql@15`.

Setting up:

1. Clone the repository and navigate into the directory.
2. Install dependencies with `bundle install`.
3. Create the database with `rails db:create db:migrate` - you may also need to do this in the test environment with `RAILS_ENV=test rails db:create db:migrate`.
4. Run `./bin/dev` (if you plan on making front end changes) or `rails s` if you're just looking around.
5. Visit `localhost:3000` and you will be greeted with the sign in screen. From here you can sign up and then log in.

## Running the tests

The test suite uses RSpec. There are unit tests for different models and the service class I have created. There are also some feature/smoke tests for controller actions.

Run the test suite with `rspec`.

## Functionality

- ✅ Users should be able to sign up and be authenticated
- ✅ Users should have a display name
- ✅ Users should be able to join and leave chat rooms
- ✅ Chat rooms can have many users at a time
- ✅ Users can send message to chat rooms
- ✅ Messages should be real time
- ✅ Messages should contain text
- ✅ Messages should be persisted in a database

Once a user has created an account and signed in they land on the "chat rooms" page which lists all chat rooms in the application. They are then able to create a new chat room or enter an existing one. Once in a chat room the user can send messages and they are immediately seen by other users in that chat room.

## Improvements

* At the moment failed requests (such as trying to create a message in a room that doesn't exist) are handled but errors are not surfaced to the user. I'd like to wrap the flash messages in a stimulus controller that displays a toast message that disappears after a certain timeout.

* On the chat page I've added a stimulus controller that scrolls to the bottom of the chat if a new message is added. This is good for when you are at the bottom of the chat but doesn't account for if you are half way up the thread as it scrolls you back down. We should be able to detect whether the user is at the bottom of the chat or not, ond only then should we scroll down so the new message is visible.

* I'd like to add some full end to end tests that verify what happens when a user performs a specific action in the UI. It has been bit a bit of time since I have written this type of test so I would need to research how best to execute them. Previousl tools I've used include Capybara and Selenium Web Driver.

* When there are no chat rooms an empty list is displayed. It would be much better UX to display an empty state message that prompts the user to create a new chat room.

* Another UX Improvement I'd like to make is to identify the user's own messages, probably by placing them on the right of the screen. This is a common patten in chats.

* For simplicity when developing locally I would consider using Docker. However previous experience with Docker and Rails resulted in ir running very slowly on Mac.

* I have not deployed this application. I'd like to deploy using Kamal, I have a Hetzner VPS that's currently running a node app so I would most likely use that.

* If I was to do this again I would configure the app to use a `structure.sql` file rather than a `schema.rb` file as I find it easier to understand. There is no ambiguity in what is happening at the database level when you are looking at the SQL directly, rather than a DSL that appoximates SQL.
