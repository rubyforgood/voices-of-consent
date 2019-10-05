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

First, set up Local Services (Via Docker or individually installed services as described in the **Starting Local Services** section below.).

Then to run the app locally,

```
$ bundle install
$ yarn install
$ rake dev:setup
$ heroku local -f Procfile.dev
# If you chose the Docker route:
  $ docker-compose start -or- $ docker-compose up
# Else
  $ rails s
$ rspec (to run the test suite)
```

## Starting Local Services

### ... with Docker!

If you opted to install Docker Desktop, `docker-compose start` will run dependency services like PostgreSQL (the database), Redis (the job queue), and Mailcatcher (a fake SMTP mail server for testing). Services will run in the background. NOTE: these services will attempt to use some commonly used ports (e.g. 5432 for PostgreSQL) on localhost, so if you see errors about conflicting ports, you may have the corresponding service already running elsewhere on your development host.

```
$ docker-compose start
Starting db          ... done
Starting cache       ... done
Starting mailcatcher ... done

$ docker-compose ps
             Name                            Command               State                                 Ports
---------------------------------------------------------------------------------------------------------------------------------------------
voices-of-consent_cache_1         docker-entrypoint.sh redis ...   Up      127.0.0.1:6379->6379/tcp
voices-of-consent_db_1            docker-entrypoint.sh postgres    Up      127.0.0.1:5432->5432/tcp
voices-of-consent_mailcatcher_1   mailcatcher --foreground - ...   Up      127.0.0.1:1025->1025/tcp, 127.0.0.1:1080->1080/tcp, 25/tcp, 80/tcp
```

Stop the services with `docker-compose stop`.

```
$ docker-compose stop
Stopping voices-of-consent_mailcatcher_1 ... done
Stopping voices-of-consent_db_1          ... done
Stopping voices-of-consent_cache_1       ... done
```

If you prefer to keep an eye on what these background services are doing (or whether they're up!), you can run `docker-compose up` instead of `start` to keep the processes in the foreground. You will need to dedicate a terminal window to this display and continue working on the project in a new terminal session. Stop the services with CTRL-C in the terminal they are running in.

```
$ docker-compose up
Starting voices-of-consent_db_1          ... done
Starting voices-of-consent_cache_1       ... done
Starting voices-of-consent_mailcatcher_1 ... done
Attaching to voices-of-consent_cache_1, voices-of-consent_db_1, voices-of-consent_mailcatcher_1
cache_1        | 1:C 09 Aug 2019 23:13:09.680 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
cache_1        | 1:C 09 Aug 2019 23:13:09.680 # Redis version=5.0.5, bits=64, commit=00000000, modified=0, pid=1, just started
cache_1        | 1:C 09 Aug 2019 23:13:09.680 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
db_1           | 2019-08-09 23:13:09.968 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
db_1           | 2019-08-09 23:13:09.968 UTC [1] LOG:  listening on IPv6 address "::", port 5432
cache_1        | 1:M 09 Aug 2019 23:13:09.682 * Running mode=standalone, port=6379.
cache_1        | 1:M 09 Aug 2019 23:13:09.682 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
cache_1        | 1:M 09 Aug 2019 23:13:09.682 # Server initialized
cache_1        | 1:M 09 Aug 2019 23:13:09.682 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
cache_1        | 1:M 09 Aug 2019 23:13:09.682 * DB loaded from disk: 0.000 seconds
cache_1        | 1:M 09 Aug 2019 23:13:09.682 * Ready to accept connections
db_1           | 2019-08-09 23:13:09.972 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
db_1           | 2019-08-09 23:13:09.986 UTC [25] LOG:  database system was shut down at 2019-08-09 23:12:20 UTC
db_1           | 2019-08-09 23:13:09.994 UTC [1] LOG:  database system is ready to accept connections
mailcatcher_1  | Starting MailCatcher
mailcatcher_1  | ==> smtp://0.0.0.0:1025
mailcatcher_1  | /usr/lib/ruby/gems/2.5.0/gems/thin-1.5.1/lib/thin/server.rb:104: warning: constant ::Fixnum is deprecated
mailcatcher_1  | ==> http://0.0.0.0:1080/
```

### ... with individually installed services

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
