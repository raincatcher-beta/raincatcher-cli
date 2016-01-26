#WFM CLI
A CLI tool for working with the WFM 2 demo and developing the WFM modules.

## Getting started
If this is your first time working with WFM, do the following:

1. Clone this CLI tool:
```
git clone git@github.com:feedhenry-staff/wfm-cli.git
```
2. Add the `wfm` script to your PATH.  eg. in your `.bashrc` file add:
```
export PATH="$PATH:$HOME/[path-to-wfm-cli-repo]"
```
3. This will clone all the wfm repos:
```
wfm clone
```
4. This will run `npm install` in each repo :
```
wfm install
```
5. This will run `npm link` for all the wfm modules in each of the apps:
```
wfm link
```

### Resulting folder structure:
```
├── modules
│   ├── wfm-appform
│   ├── wfm-component-signature
│   ├── wfm-mediator
│   ├── wfm-risk-assessment
│   ├── wfm-sync
│   ├── wfm-template-build
│   ├── wfm-user
│   ├── wfm-vehicle-inspection
│   ├── wfm-workflow
│   └── wfm-workorder
├── wfm-auth
├── wfm-cli
├── wfm-cloud
├── wfm-mobile
└── wfm-portal
```

## Working with the repos
The commands `wfm status` and `wfm pull` will run their respective _git_ commands on all folders in the repository.

The command `wfm clean` will remove the *node_modules* folder in each of the app folders **only**.

The command `wfm install` will run *npm install* in each of the app and module folders.

## Running the apps
Before running the applications (via `grunt` in the respective folders), you must start mongo.  The wfm-cli provides the `wfm mongo {start|stop|status}` command to do this:
```
wfm mongo start
wfm mongo status
wfm mongo stop
```
