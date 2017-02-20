# Releasing WFM

## Update the WFM repositories

Make sure you are on `master` on all the repositories
```
wfm git checkout master
```
then :

```
wfm git pull
wfm clean
wfm install
wfm status
```

## Release & publish the modules
Iterate over each of the modules, performing a npm release and publish if required:

```
wfm release
```

Push the modules commits to the remotes :

```
wfm git push --tags origin master
```

## Release the demo apps
For each of the demo apps, we will update the wfm module dependencies and replace the shrinkwrap file.  For _wfm-mobile_ and _wfm-portal_ we will also check-in the build artifacts, but we will do this (and the release tag) on a branch.

### Release the cloud apps
For _wfm-cloud_ and _wfm-auth_ we do the release right on master:

```
ncu -f /^fh-wfm/ -u && rm -rf node_modules/ npm-shrinkwrap.json  && npm cache clean && npm install --production && npm shrinkwrap
git diff
git commit -a -m'Updated fh-wfm dependencies'
git push
git status
npm version 2.0.0-alpha.5
git push --tags origin master
```

### Release the client apps
For the _wfm-mobile_ and _wfm-portal_ applications we will switch to a _release_ branch and check in the results of the build artifacts.

The `release` branch is just a holder for generating browserified files from all of the modules. It should never be used for development.

(If the release branch is already in the upstream, it can be deleted.)

then :

```
# Deleting the release branch from the upstream
git push upstream :release
# Deleting the local release branch
git branch -D release
git checkout master
git reset --hard upstream/master
ncu -f /^fh-wfm/ -u && rm -rf node_modules/ npm-shrinkwrap.json  && npm cache clean && npm install --production && npm shrinkwrap
git diff
```

Update the `package.json` file to the new version (Minor for master branches, hotfix for FHv-3.x.x branches). Then:

```
git commit -am 'Updated fh-wfm dependencies'
git push upstream master
```

Now that the versions have been updated on master, we need to generate the build folder (www) and add that to the tag.

```
git checkout -b release
npm install
grunt build
#For mac you need to use sed -i -e ..
sed -i 's/^www/#www/' .gitignore
git status
git add .gitignore www/
git commit -m 'Added the www folder'
git tag <package.json version>
git push upstream --tags
git checkout master
```
