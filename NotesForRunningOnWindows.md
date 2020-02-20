# Notes for Running on Windows 

## Update Ruby version
1. Install Ruby 2.6.5

## Run specific version of bundler

Run specific version of bundler:

	```
	gem install bundler -v 1.0.10
	bundle _1.3.17_ install
	```
## Environment Variables
Before running, need to set the environment variable USER. Windows has a variable called USERNAME the value of this variable must be the same as USER. The USER variable is used to setup the DB.

## Heroku
Running the command: 
```
$ heroku local -f Procfile.dev
```
resulted in the following error:

```
1:13:22 PM web.1     |  'bin' is not recognized as an internal or external command,
1:13:22 PM web.1     |  operable program or batch file.
[DONE] Killing all processes with signal  SIGINT
1:13:22 PM webpack.1 |  'bin' is not recognized as an internal or external command,
1:13:22 PM webpack.1 |  operable program or batch file.
1:13:22 PM web.1     Exited with exit code null
1:13:22 PM webpack.1 Exited with exit code null
1:13:22 PM sidekiq.1 Exited with exit code SIGINT
```

Running the commands inside of the Procfile.dev seems to be a good workaround.
