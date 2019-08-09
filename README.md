# The Organization:

Voices of Consent is a nonprofit organization whose mission is to provide healing to victims, bring awareness to sexual assault, transform society’s response to victims, define what consent is. Based in Washington, DC, this nonprofit operates in 48 states to help survivors in the aftermath of a traumatic event by sending survivor boxes to anyone who requests one free of charge. Boxes are personalized and put together to let survivors know they are not alone after an event and can help provide support as they begin the recovery process including information about laws in their state, free health and counseling services in their area, and other tools and resources needed to start the healing journey. Voices of Consent gets the word out to survivors by talking at schools and churches. The boxes are sent to survivors who request them directly or can be picked up at hospitals or police stations.

Please check out https://www.voicesofconsent.org/what-we-do as well as the rest of the website to learn more about this organization.

# Setting Up Development

This is a Ruby on Rails 5.2 application with React + Webpack included.

To get started developing on your machine, you'll need the following tools installed:

* ruby 2.6
* node 10+
* yarn 1.16+
* bundler 2+

Some choices for how to run services in your development environment:
* [Heroku Command Line Interface](https://devcenter.heroku.com/categories/command-line)
* [Docker Desktop](https://www.docker.com/products/docker-desktop) to use the docker-compose steps or you will need to install these services individually on your development host:
    * Redis 4+
    * PostgreSQL 9.5+
    * Mailcatcher 0.7.1

## Running the App!

First, set up Local Services (see the **Starting Local Services** section below).

Then to run the app locally,

```
$ bundle install
$ yarn install
$ cp config/development.yml.example config/development.yml
$ rake db:setup
$ heroku local -f Procfile.dev
```

## Starting Local Services

Ensure Redis is running. `brew services start redis` on macOS or `redis-server` to run it as a one-off process.

Ensure Postgres is running. We recommend Postgres.app for macOS if you don't already have it installed.

Mailcatcher cannot be bundled, for that reason we must use:

```
$ gem install mailcatcher
```

To get the MailCatcher gem's mail server up run:

```
$ mailcatcher
Go to http://localhost:1080/
Send mail through smtp://localhost:1025
```

You only need this if you're interested in working on emails in the development environment.
