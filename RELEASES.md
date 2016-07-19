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
ncu -f /^fh-wfm/ -u && rm -rf node_modules/ npm-shrinkwrap.json  && npm install && npm shrinkwrap
git diff
git commit -a -m'Updated fh-wfm dependencies'
git push
git status
npm version 2.0.0-alpha.5
git push --tags origin master
```

### Release the client apps
For the _wfm-mobile_ and _wfm-portal_ applications we will switch to a _release_ branch and check in the results of the build artifacts.

On a fresh clone, you will have to create the release branch first : 
```
git checkout -b release
```

then : 


```
ncu -f /^fh-wfm/ -u && rm -rf node_modules/ npm-shrinkwrap.json  && npm install && npm shrinkwrap
git diff
git commit -a -m'Updated fh-wfm dependencies'
git push
git checkout release
git reset --hard master
grunt build
sed -i 's/^www/#www/' .gitignore
git status
git add .gitignore www/
git commit -m'Added the www folder'
npm version 2.0.0-alpha.5
git push origin --tags
git checkout master
```
