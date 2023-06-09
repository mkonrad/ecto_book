Programming Ecto Book Notes 
===========================

---

Repository for working through the Programming Ecto book.

Starting Point
--------------

Create GitHub repository based on aviumlabs/phoenix-compose

    $ cd <projects/directory>
    $ gh repo create ecto_book -c -d \
      "Repository for working through Programming Ecto" --public \
      -p aviumlabs/phoenix-compose 


Development
-----------
With the src directory bind mounted to the application directory, you can use 
your favorite local development environment to continue with developing 
your application.

### Running Mix Against the Docker Container
Running mix against the container, set up the following aliases:

#### Source File 
    
    File name: .mdbdev

    $ cd <project/root/dir>

Create the .mdbdev file with the following content:

    export APP_CONTAINER_ROOT=/opt
    export APP_NAME=music_db

    alias mix="docker compose run --rm app mix"
    alias iex="docker compose run --rm app iex -S mix"

Then before starting development, source the file in your shell:

    $ cd <project/root/dir>
    $ . ./.mdbdev
   
Comfirm the aliases are set correctly:

    $ alias

        > iex='docker compose run --rm app iex -S mix'
        > mix='docker compose run --rm app mix'


Prepare Script
--------------

The prepare script included in aviumlabs/phoenix-compose configures a Phoenix
Framework and PostgreSQL application. This does not follow the books pattern of 
a straight Elixir project.

    $ ./prepare -i music_db 

        > ...
        > * running mix deps.get
        > * running mix assets.setup
        > * running mix deps.compile
        > ...
        > You can also run your app...

    $ ./prepare -f 

        > Running mix ecto.create...
        > ...
        > Running docker compose up; press cntl-c to stop.



### Book Resources

#### Prerequisites
Download the books resources from the book's web site. 

Change the MusicDB reference to MusicDb in the seed, migrations and the 
lib/\*.ex files.

Add the using\_postgres? function to the repo.ex module.

From the resources, copy the priv/repo/seed.exs, migration lib/\* files: 

    $ cd <path_to>/code/priv/repo
    $ cp seed.exs <path_to>/src/music_db/priv/repo
    $ cp migrations/* <path_to>/src/music_db/priv/repo/migrations
    $ cd ../../lib
    $ cp album.ex album_genre.ex album_with_embed.ex artist.ex artist_embed.ex \
      band.ex genre.ex log.ex note.ex search_engine.ex solo_artist.ex track.ex \
      track_embed.ex <path_to>/src/music_db/lib/music_db
    $ cd src/music_db
    $ mix ecto.setup

        > ...
        > Success! Sample data has been added.

Now work through the book examples.


Additional Information
----------------------

### aviumlabs/phoenix-compose runtime
By default aviumlabs/phoenix-compose runs the docker services in the foreground.

To run mix ecto.reset, you need to stop the running services `ctrl-c` and 
then run the following:

    $ docker compose up db
    $ mix ecto.reset
    $ ctrl-c
    $ docker compose up

Alternatively, you can run the docker services in the background;

    $ docker compose up -d

Then run the steps above as follows:

    $ docker compose stop app
    $ mix ecto.reset
    $ docker compose start app

To watch the db logs, run:

    $ docker logs -f ecto_book-db-1

To watch the app logs, run:

    $ docker logs -f ecto_book-app-1


If you are not sure of the container names, run:

    $ docker container ls

| CONTAINER ID     | IMAGE            | ...  | NAMES                |
|------------------|------------------|------|----------------------|
| nnn              | postgres:15.3... | ...  | ecto\_book-db-1      |
| nnn              | aviumlabs/...    | ...  | ecto\_book-app-1     |



#### Breakdown of the docker aliases

* docker compose run is the docker syntax for executing a command in a container.
* app is the container to execute the command in.
* mix is the command to execute.

