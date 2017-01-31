# Raincatcher Command Line Interface (CLI)

This module provides a CLI tool for working with the Raincatcher demos and developing the Raincatcher modules. The Raincatcher demo solution has a dependency on many separate modules.

It is possible to manually set up your local development environment without this tool, but this tool provides functionality to do the required steps automatically.

This CLI tool allows developers to:

- Clone the demo solution to a local machine.
- Clone all of the Raincatcher modules that the demo solution requires.
- Run the full demo solution locally.
- Set up for local development by linking all of the Raincatcher modules to the demo solution.

## Getting Started

*Note:* To be able to clone repositories from GitHub using ssh, you must have a ssh key associated with your GitHub account. See [this guide](https://help.github.com/articles/generating-an-ssh-key/) for more information.

To get set up for developing Raincatcher locally it is recommended that you set up a separate folder to contain all of the Raincatcher modules and demo apps. (e.g. `~/raincatcher`).

The following steps will assume that the *RAINCATCHER_DIRECTORY* is the folder that you use for your local development.

If this is your first time working with Raincatcher, perform the following steps to set up your local development environment:

1. Clone this CLI tool using the following commands:
  ```
  # Exporting the working directory for all Raincatcher modules.
  export RAINCATCHER_DIRECTORY=~/raincatcher/
  mkdir -p $RAINCATCHER_DIRECTORY
  cd $RAINCATCHER_DIRECTORY

  git clone git@github.com:feedhenry-raincatcher/raincatcher-cli.git
  ```

2. Add the `wfm` script to your PATH. For example, in your `.bashrc` file, add:
  ```
  export PATH="$PATH:$RAINCATCHER_DIRECTORY/raincatcher-cli"
  ```

3. With the `wfm` command now available, clone all of the Raincatcher modules to your local machine using the following command:
  ```
  wfm clone
  ```

4. Use the following command to install all of the dependencies for each Raincatcher module:
  ```
  wfm install
  ```

5. Run the following command to link all of the Raincatcher modules to modules that depend on them. This command will run the `npm link` command for any Raincatcher module dependencies. This useful when you intend to modify multiple modules and see the results in the demo app immediately.
  ```
  wfm link
  ```

### Folder Structure For Local Development

Having run all of the commands above the following folder structure will have been created.

```
├── RAINCATCHER_DIRECTORY
│   ├── raincatcher-cli
│   ├── modules
│   │   ├── raincatcher-analytics
│   │   ├── raincatcher-appform
│   │   ├── raincatcher-camera
│   │   ├── raincatcher-file
│   │   ├── raincatcher-map
│   │   ├── raincatcher-mediator
│   │   ├── raincatcher-message
│   │   ├── raincatcher-result
│   │   ├── raincatcher-risk-assessment
│   │   ├── raincatcher-schedule
│   │   ├── raincatcher-signature
│   │   ├── raincatcher-sync
│   │   ├── raincatcher-template-build
│   │   ├── raincatcher-user
│   │   ├── raincatcher-vehicle-inspection
│   │   ├── raincatcher-workflow
│   │   └── raincatcher-workorder
│   ├── raincatcher-demo-auth
│   ├── raincatcher-demo-cloud
│   ├── raincatcher-demo-mobile
│   └── raincatcher-demo-portal
```

## Local Development

Having cloned all of the required Raincatcher repositories to your local development environment, you are now ready to start local development.

1. Install MongoDB [locally](https://docs.mongodb.com/manual/installation/) or [containerised](#using-mongodb-from-a-container)

2. Install Redis
  * On Linux: https://redis.io/topics/quickstart
  * On Mac
    ```
    brew install redis
    ```

3. Install *tmux*
  * On Linux:
    ```
    apt-get install tmux
    ```
  * On Mac: https://gist.github.com/simme/1297707.

4. Install tmuxinator (Ruby required)
  ```
  gem install tmuxinator
  ```

5. Install grunt (Node.js required)
  ```
  npm install -g grunt
  ```

6. Start the Raincatcher node processes (mongo will be started automatically if you installed it locally, else the Docker container should already be running):
  ```
  wfm start
  ```

Each of the terminals started by tmux can be interacted with individually to stop/restart each node process.

### Using MongoDB from a container

***Note*** If you do not have Docker installed you must first [install it](https://docs.docker.com/engine/installation/).

To run a containerised version of MongoDB run:

```bash
docker run --name raincatcher-mongo -p 27017:27017 -d mongo:2
```

There should now be a running instance of MongoDB running inside a container with port `27017` accessible by the appt.

To confirm that the MongoDB container is running as expected, run:

```bash
docker ps
```

and ensure that the `raincatcher-mongo` container is running.

#### MongoDB container isn't running

There may already be a container named `raincatcher-mongo`,
if this container is running then there is no need to create a new MongoDB container. If the container is stopped and you wish
to have a new container, delete the old `raincatcher-mongo` by running:

```bash
docker rm raincatcher-mongo
```

and run the `docker run` command again.

If this is not the issue then port `27017` on your local machine may have already be claimed by another running instance of MongoDB.
If this is the case, shut down that MongoDB and run the `docker run` command again.

### (Optional) Manual MongoDB Controls

The `wfm start` task will start mongo automatically.  However the raincatcher-cli provides the `wfm mongo {start|stop|status}` command take manual control of the mongo process:
```
wfm mongo start
wfm mongo status
wfm mongo stop
```

### Useful Commands For Working With The Local GIT Repositories

The commands `wfm status` and `wfm pull` will run their respective _git_ commands on all folders in the repository.

The command `wfm clean` will remove the *node_modules* folder in each of the app folders **only**.

The command `wfm install` will run *npm install* in each of the app and module folders.
