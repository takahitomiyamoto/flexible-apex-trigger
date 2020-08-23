![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)
[![dependencies status](https://david-dm.org/takahitomiyamoto/flexible-apex-trigger.svg)](https://david-dm.org/takahitomiyamoto/flexible-apex-trigger)
[![devDependency status](https://david-dm.org/takahitomiyamoto/flexible-apex-trigger/dev-status.svg)](https://david-dm.org/takahitomiyamoto/flexible-apex-trigger#info=devDependencies)
[![Code Climate](https://codeclimate.com/github/takahitomiyamoto/flexible-apex-trigger.svg)](https://codeclimate.com/github/takahitomiyamoto/flexible-apex-trigger)

# Flexible Apex Trigger

This is a framework that makes our Apex Trigger development more flexible.

# How to use

## install on your org

```sh
sfdx force:package:install -p flexible-apex-trigger@1.0.1.0 -s AllUsers -u [targetusername]
sfdx force:package:install:report -i 0HfXXXXXXXXXXXXXXX -u [targetusername]
```

## assign a permission set to one or more users of an org

```sh
sfdx force:user:permset:assign -n FAT_Logger_User -u [targetusername]
```

## open an org in your browser

```sh
sfdx force:org:open -p lightning/setup/ImportedPackage/home -u [targetusername]
```

# Acknowledgment

- [Dependency Injection Sample for Apex Trigger](https://github.com/takahitomiyamoto/di-sample-apex-trigger)

---

# Appendix

## Create a package

### create a package

```sh
sfdx force:package:create -d "This is a framework that makes our Apex Trigger development more flexible." -e -n "flexible-apex-trigger" -r force-app-fat -t Unlocked -v DevHub
```

### create a package version

```sh
sfdx force:package:version:create -a "Summer '20" -b "master" -c -e "Summer '20 (API version 49.0)" -f config/project-scratch-def.json -n 1.0.0.0 -p 0HoXXXXXXXXXXXXXXX -t v49.0 -v DevHub -x --postinstallurl "https://github.com/takahitomiyamoto/flexible-apex-trigger" --releasenotesurl "https://github.com/takahitomiyamoto/flexible-apex-trigger/releases"
```

### retrieve details about a package version creation request

```sh
sfdx force:package:version:create:report -i 08cXXXXXXXXXXXXXXX -v DevHub
```

### list package version creation requests

```sh
sfdx force:package:version:create:list -s Success -v DevHub
```

### promote a package version to released

```sh
sfdx force:package:version:promote -p 04tXXXXXXXXXXXXXXX -v DevHub
```

### retrieve details about a package version in the Dev Hub org

```sh
sfdx force:package:version:report -p 04tXXXXXXXXXXXXXXX -v DevHub --verbose
```

### list all packages in the Dev Hub org

```sh
sfdx force:package:list -v DevHub --verbose
```

### list all package versions in the Dev Hub org

```sh
sfdx force:package:version:list -p flexible-apex-trigger -v DevHub --verbose
```

## Update a package

### create a package version

```sh
sfdx force:package:version:create -a "Summer '20" -b "master" -c -e "Summer '20 (API version 49.0)" -f config/project-scratch-def.json -n 1.0.1.0 -p 0HoXXXXXXXXXXXXXXX -t v49.0 -v DevHub-FAT -x --postinstallurl "https://github.com/takahitomiyamoto/flexible-apex-trigger" --releasenotesurl "https://github.com/takahitomiyamoto/flexible-apex-trigger/releases"
```

### retrieve details about a package version creation request

```sh
sfdx force:package:version:create:report -i 08cXXXXXXXXXXXXXXX -v DevHub-FAT
```

### update a package version

```sh
sfdx force:package:version:update -a "Summer '20" -b "master" -e "Summer '20 (API version 49.0)" -p 04tXXXXXXXXXXXXXXX -t v49.0 -v DevHub-FAT
```

### promote a package version to released

```sh
sfdx force:package:version:promote -p 04tXXXXXXXXXXXXXXX -v DevHub-FAT
```

### list all package versions in the Dev Hub org

```sh
sfdx force:package:version:list -p flexible-apex-trigger -v DevHub-FAT --verbose
```
