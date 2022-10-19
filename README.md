# Id Notify Me API
This is a simple API for alerting users on when an ID is about to expire  the sample application for
by [Albert Lawer](https://www.albertlawer.com/).

* Ruby version: 3.1.2
* Rails version: 7.0.4

## Getting started
To get started with the app, clone the repo and then install the needed gems:
```
$ bundle install 
```
Now create a .env file and add your database credentials 
```
Edit the database.yml file in the config folder
```
Next, migrate the database:
```
$ rails db:migrate
```
Now install rspec
```
$ rails generate rspec:install
```
Finally, run the test suite to verify that everything is working correctly:
```
$ rspec
```
If the test suite passes, you'll be ready to run the app in a local server:
```
$ rails server
```