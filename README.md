# Todo

This is a simple task tracking tool. You can create lists of items and viewing a list gives you views of items completed yesterday, items due today, items due tomorrow, and items you hope to complete someday. Any items that are incomplete and past their due date are automatically moved to today.

The idea is to have one place to look and see what you accomplished yesterday, what you need to get done today, and plan for the future.

This isn't a smart application. Since I'm in the Mountain Time time zone, that is hard coded into the app. Since I intend to use this mostly for work, there is some special logic to exclude weekends.

# Getting running

This is a pretty standard Elixir Phoenix app.

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `cd assets && npm install`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
