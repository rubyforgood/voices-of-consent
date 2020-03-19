# The Organization:

Voices of Consent is a nonprofit organization whose goal is to support survivors after a traumatic experience. Locally based, this nonprofit operates in 42 states to help survivors. In the aftermath of a traumatic event, Voices of Consent sends a box to a survivor who requests one.

Survivor Boxes are personalized packages put together to let survivors know they are not alone after an event, that include resources to use as survivors begin the recovery process (including information about laws in their state, free health and counseling services in their area).

Voices of Consent gets the word out to survivors by talking at schools and churches. The boxes are sent to survivors who request them directly, or can be picked up at hospitals or police stations.

Please check out https://www.voicesofconsent.org/what-we-do as well as the rest of the website to learn more about this organization.

# Contributing

Visit our [CONTRIBUTING.md](https://github.com/rubyforgood/voices-of-consent/blob/develop/CONTRIBUTING.md) file for more information on making your contribution. We look forward to it.


# Background
We've started a few reference documents based on questions we've been asked. Make sure you also read our [background.md](notes/background.md), and check out the [database-diagram.png](notes/database-diagram.png) all of which is located in the [/notes](notes) folder in the repo.

Also located in the [/notes](notes) folder is [database-diagram.dot](notes/database-diagram.dot) which is used to create the [database diagram.png](notes/database-diagram.png). If you want to edit this file and generate new versions of the [database-diagram.png](notes/database-diagram.png), visit http://graphviz.it/ and paste the code from your [database-diagram.dot](notes/database-diagram.dot). Make sure you erase all the code on this website and replace it with the entire contents of your .dot file to see your diagram properly.

If you want to know more about how to update the [database-diagram.png](notes/database-diagram.png), please checkout Casey Watts' instructional post on graphviz at https://gist.github.com/caseywatts/be69bf941fa1f8e264bd07de698366a0.

If you have any questions please feel free to reach out in the Ruby for Good Slack or on Github so we can improve our references.

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

## Setting up Ruby

The easiest way to manage different installations of Ruby is with [rbenv](https://github.com/rbenv/rbenv). After following the installation instructions on the rbenv repo and restarting your terminal, you'll be able to run `rbenv install` in the root directory of the repository. rbenv will handle installing Ruby and switching to it for you when you enter the repo (so no need to worry about your other Ruby installs!) After that, run `gem install bundler` and you'll be all set to run `bundle install`.

If you run into a problem where your bundle install says you're on an older version of bundler than what's in the lockfile, run `gem update --system` to update RubyGems, then `gem install bundler:1.17.3`

Depending on your system, you might have trouble building the `pg` gem, probably due to a missing `libpq-fe.h`. To get the necessary libraries installed:
* Debian/Ubuntu: `sudo apt-get install libpq-dev`
* On Enterprise Linux (CentOS/RHEL/Fedora/Amazon Linux/Sci Linux): `yum install postgresql-devel`
* For Mac (Homebrew): `brew install postgresql`

## Setting up Node

The easiest way to manage different installations with node.js is with [nvm](https://github.com/nvm-sh/nvm). After following the installation instructions, type `nvm install` to install and run the right version of node.js.

You'll also need Yarn, a package manager for node.js. To install that:
* Debian/Ubuntu: 
```
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn
```
* On Enterprise Linux (CentOS/RHEL/Fedora/Amazon Linux/Sci Linux): 
```
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo yum install yarn
```
* For Mac (Homebrew): `brew install yarn`

## Setting up Heroku

The Rails, Sidekiq, and webpack processes are launched with Heroku. You can install Heroku Local using [these instructions](https://devcenter.heroku.com/articles/heroku-cli).

## Running the App!

First, set up Local Services via Docker or individually installed services. 
### Starting Local Services

#### ... with Docker!

If you opted to install Docker Desktop, `docker-compose up -d` will run dependency services like PostgreSQL (the database), Redis (the job queue), and Mailcatcher (a fake SMTP mail server for testing). Services will run in the background. NOTE: these services will attempt to use some commonly used ports (e.g. 5432 for PostgreSQL) on localhost, so if you see errors about conflicting ports, you may have the corresponding service already running elsewhere on your development host.

```
$ docker-compose up -d
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

When you're done, stop the services with `docker-compose stop`.

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

#### ... with individually installed services

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

### Run the App Locally

Then, to run the app locally,

```
$ bundle install
$ yarn install
$ docker-compose up -d (if using docker)
$ rake dev:setup
$ heroku local -f Procfile.dev
```

if you run into the following error:
```bash: heroku: command not found``` visit https://devcenter.heroku.com/articles/heroku-cli for instructions to install Heroku.


# Viewing the Application
## if you chose the local route, then you are good to go on:
  http://localhost:5000
  $ rspec (to run the test suite) or bundle exec rspec (if the first does not work)
## If you chose the Docker route:
  
  ```
  $ docker-compose up -d 
  http://localhost:3000
  $ rspec (to run the test suite)
  $ View `seeds.rb` file for login email and password to use while working in development
  ```
  
  -or- 
  
  ```
  $ docker-compose up
  http://localhost:3000
  $ rspec (to run the test suite)
  $ View `seeds.rb` file for login email and password to use while working in development
  ```
  
# Other Tips to Get Started

## Loggin In
A username and password to log in and test the app are in `seeds.rb`

## Re-seeding development database
To reset your development database with realistic data, run `rake dev:setup`. To add additional fake data during development after you have already run `rake dev:setup`, you can use `rake db:seed:dev`.

## Testing
When writing tests for rspec tests within the spec/request directory, you can use Warden::Test:Helpers
which give you access to the ```login_as(user, :scope => :user)``` method, as well as the ```logout``` method.
You use FactoryBot.create(:user) before the login_as method and pass it in as the required resource variable.
BE SURE to include the line ```after { Warden.test_reset! } ``` after the before do block with the login_as method
within it. This allows for any unexpected state data of the user from hanging around and causing errors.

Additional testing for front_end specs should make use of Capybara ```sign_in/sign_out``` Capybara methods.

## App Startup Troubleshooting
If you Recieve an error when trying to run

```
$ heroku local -f Procfile.dev
```

that looks like this ...

```
joe-shmo:~/projects/voices-of-consent(develop)$ heroku local -f Procfile.dev
 ›   Warning: heroku update available from 7.26.2 to 7.33.3.
[OKAY] Loaded ENV .env File as KEY=VALUE Format
12:02:46 PM web.1    |  => Booting Puma
12:02:46 PM web.1    |  => Rails 5.2.3 application starting in development
12:02:46 PM web.1    |  => Run `rails server -h` for more startup options
12:02:46 PM webpack.1 |  events.js:167
12:02:46 PM webpack.1 |        throw er; // Unhandled 'error' event
12:02:46 PM webpack.1 |        ^
12:02:46 PM webpack.1 |  Error: listen EADDRINUSE: address already in use 127.0.0.1:3035
12:02:46 PM webpack.1 |      at Server.setupListenHandle [as _listen2] (net.js:1290:14)
12:02:46 PM webpack.1 |      at listenInCluster (net.js:1338:12)
12:02:46 PM webpack.1 |      at GetAddrInfoReqWrap.doListen [as callback] (net.js:1471:7)
12:02:46 PM webpack.1 |      at GetAddrInfoReqWrap.onlookup [as oncomplete] (dns.js:62:10)
12:02:46 PM webpack.1 |  Emitted 'error' event at:
12:02:46 PM webpack.1 |      at emitErrorNT (net.js:1317:8)
12:02:46 PM webpack.1 |      at process._tickCallback (internal/process/next_tick.js:63:19)
[DONE] Killing all processes with signal  SIGINT
```

Run -
``` $ ps aux | grep node ```
and then use the following command on any PIDs that have voices of consent in the path, or mentions node/procfiles

```
kill -9 <PID #>
```
Then Re-run -

```
$ heroku local -f Procfile.dev
```

# [Notes for Running on Windows](NotesForRunningOnWindows.md)