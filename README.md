# README

## Running the application

In order to run this project you need to have ruby 2.7.2 installed, we recommend that you install it using [rbenv](https://github.com/rbenv/rbenv).

To clone the repository run:
```
git clone git@github.com:gulazaro94/healios.git
```

From the application run the following commands:

```
bundle install # To install the dependencies
bundle exec rails db:migrate # To run the migrations
bundle exec rails server # To start the server
```

Go to: http://localhost:3000

## Considerations

- The shortened URLs are saved in the urls table with the coloumns (url, token and access_count).
- A random token (length of 10) is generated when you shorten a URL, if the token conflicts, it tries up to 5 times to generate another.
- The token column has a unique index for fast lookups and uniqueness.
- It counts every time a shortened URL is accessed in the access_count column.
- To prevent data races, the ActiveRecord `increment_counter` was used. It performs something like `... access_count = access_count + 1` in the database.
- To manage the application logic, it was used [Interactions](https://github.com/AaronLasseigne/active_interaction)\
- RSpec and Factory Bot were used for testing
- Tests were added for the model, controller and interactions.
- There wasn't any effort in making the application beautiful, so please don't mind how it looks.
