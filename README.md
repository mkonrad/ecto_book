A Phoenix Framework Docker Compose Repo
=======================================

---

This is a template repo and it can be utilized using the following pattern. 


See the __Development__ section below for handy tips on setting aliases.

Creating a Repository From this Template
----------------------------------------

[GitHub Documentation] [git-from-template]


### Example Project

#### Create a New Repository on GitHub.com

- Go to https://github.com/aviumlabs/phoenix-compose
- Select Use this template
- Select Create a new repository

Repository name: __gutentag__<br />
Description: A hello world application<br />
Public<br />

- Select 'Create repository from template'

Generating your repository...

#### Clone the New Repository

GitHub CLI

    $ cd <projects/directory>
    $ gh repo clone aviumlabs/gutentag

__or__

---

#### Create and Clone a New Public Repository with GitHub CLI

    $ cd <projects/directory>
    $ gh repo create gutentag -c -d "A hello world app" --public \
      -p aviumlabs/phoenix-compose 

Created repository aviumlabs/gutentag on GitHub<br />
Cloning into 'gutentag'...<br />

---

#### Avium Labs Prepare Script

The included prepare script will create a Phoenix Framework project. 

Run `$ ./prepare -h` to get started.

Running the prepare script to initialize the Phoenix Framework project:

    $ cd gutentag
    $ ./prepare -i gutentag -u

...

We are almost there! ...

    $ ./prepare -f
    
Running mix ecto.create...

...

Running docker compose up; press cntl-c to stop.

...


The example application is now running in the foreground and can be shutdown 
with `cntl-c`.

Service Details
---------------

The Phoenix Framework application is exposed on port 4000. 

The src directory in the project working directory is bind mounted to the 
APP\_CONTAINER\_ROOT directory which by default is set to /opt when initialized
and is then set to /opt/\<application\_name\> after running finalize.

The default APP\_CONTAINER\_ROOT can be set during the project initialization 
phase by specifying the -r flag to the prepare script.

    $ ./prepare -i gutentag -r /usr/local

The prepare script performs the following actions during initialization:
- generates a docker environment file (.env)
- generates a random password for the Postgres account 

The prepare script performs the following actions during finalization:
- prepares the config/dev.exs dev environment:
  - sets the ip address to 0, 0, 0, 0
  - sets the database host
  - sets the database password (pulled from the .env file)


### Docker Images
- Phoenix Framework image: aviumlabs/phoenix:latest-alpine 
- PostgreSQL image: postgres:15.3-alpine3.18

Umbrella Project
----------------
A Phoenix Framework umbrella project can also be created with the prepare 
script. 

    $ ./prepare -i <app_name> -r /opt -u
    $ ./prepare -i <app_name> -u

Official Elixir Umbrella Documentation 
[Link](https://elixir-lang.org/getting-started/mix-otp/dependencies-and-umbrella-projects.html)

Development
-----------
With the src directory bind mounted to the application directory, you can use 
your favorite local development environment to continue with developing 
your application.

### Running Mix Against the Docker Container
To run mix against the container, setting up some aliases can reduce some 
typing.

Create a file in the root of the application directory with the following 
content, e.g. `.<app_name>dev`:

    export APP_CONTAINER_ROOT=/opt
    export APP_NAME=app

    alias mix="docker compose exec app mix"
    alias amix="docker compose exec -w "$APP_CONTAINER_ROOT/$APP_NAME"_umbrella/apps/$APP_NAME app mix"
    alias wmix="docker compose exec -w "$APP_CONTAINER_ROOT/$APP_NAME"_umbrella/apps/"$APP_NAME"_web app mix"
    alias iex="docker compose exec app iex"

Then before starting development, source the file in your shell:

    $ cd <app>/<root>
    $ . ./.<app_name>dev
   
Comfirm the aliases are set correctly:

    $ alias

If you are not using an umbrella application structure, don't forget to remove the 
`_umbrella/apps` from the above aliases.

#### Breakdown of the aliases

* docker compose exec is the docker syntax for executing a command in a container.
* app is the container to execute the command in.
* mix is the command to execute.


[git-from-template]: https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template
