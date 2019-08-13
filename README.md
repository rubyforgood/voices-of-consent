# The Organization:

Voices of Consent is a nonprofit organization whose mission is to provide healing to victims, bring awareness to sexual assault, transform society’s response to victims, define what consent is. Based in Washington, DC, this nonprofit operates in 48 states to help survivors in the aftermath of a traumatic event by sending survivor boxes to anyone who requests one free of charge. Boxes are personalized and put together to let survivors know they are not alone after an event and can help provide support as they begin the recovery process including information about laws in their state, free health and counseling services in their area, and other tools and resources needed to start the healing journey. Voices of Consent gets the word out to survivors by talking at schools and churches. The boxes are sent to survivors who request them directly or can be picked up at hospitals or police stations.

Please check out https://www.voicesofconsent.org/what-we-do as well as the rest of the website to learn more about this organization.



## Starting Development

This is a Ruby on Rails 5.2 application with React + Webpack included.

To get started developing on your machine, you'll need the following tools installed (version numbers are from @abachman's computer at or around July 2019):

* ruby 2.6.3
* node 10.14
* yarn 1.16
* bundler 2.0.2
* heroku 7.26.2
* redis 4.0
* postgres 9.5
* mailcatcher 0.7.1

To run the app locally after setting up services (see below):

```
$ bundle install
$ yarn install
$ rake dev:setup
$ heroku local -f Procfile.dev
```

### Starting local services

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
