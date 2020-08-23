![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)
[![dependencies status](https://david-dm.org/takahitomiyamoto/flexible-apex-trigger.svg)](https://david-dm.org/takahitomiyamoto/flexible-apex-trigger)
[![devDependency status](https://david-dm.org/takahitomiyamoto/flexible-apex-trigger/dev-status.svg)](https://david-dm.org/takahitomiyamoto/flexible-apex-trigger#info=devDependencies)
[![Code Climate](https://codeclimate.com/github/takahitomiyamoto/flexible-apex-trigger.svg)](https://codeclimate.com/github/takahitomiyamoto/flexible-apex-trigger)

# Flexible Apex Trigger

This is a framework that makes our Apex Trigger development more flexible.

## Tutorial

- [Apex Trigger Intermediate](https://takahitomiyamoto.github.io/apex-trigger-intermediate/)

## How to use

### 1. install the framework on your org

```sh
sfdx force:package:install -p flexible-apex-trigger@1.0.1.0 -s AllUsers -u [targetusername]
sfdx force:package:install:report -i 0HfXXXXXXXXXXXXXXX -u [targetusername]
sfdx force:org:open -p lightning/setup/ImportedPackage/home -u [targetusername]
```

### 2. assign the permission set to one or more users of your org

```sh
sfdx force:user:permset:assign -n FAT_Logger_User -u [targetusername]
```

### 3. create Apex classes

```sh
sfdx force:source:deploy -p force-app/main/default/labels/ -u [targetusername]
sfdx force:source:deploy -p force-app/main/default/classes/ -u [targetusername]
```

- [Custom Labels](https://github.com/takahitomiyamoto/flexible-apex-trigger/tree/master/force-app/main/default/labels)
- [Apex Classes](https://github.com/takahitomiyamoto/flexible-apex-trigger/tree/master/force-app/main/default/classes)

### 4. create Apex triggers

```sh
sfdx force:source:deploy -p force-app/main/default/triggers/ -u [targetusername]
```

- [Apex Triggers](https://github.com/takahitomiyamoto/flexible-apex-trigger/tree/master/force-app/main/default/triggers)

### 5. associate Apex classes with Apex Trigger operations

```sh
sfdx force:source:deploy -p force-app/main/default/customMetadata/ -u [targetusername]
```

- [Custom Metadata types](https://github.com/takahitomiyamoto/flexible-apex-trigger/tree/master/force-app/main/default/customMetadata)

### 6. create Apex test classes

```sh
sfdx force:source:deploy -p force-app/test/default/classes/ -u [targetusername]
```

- [Apex Test Classes](https://github.com/takahitomiyamoto/flexible-apex-trigger/tree/master/force-app/test/default/classes)

## Acknowledgment

- [Dependency Injection Sample for Apex Trigger](https://github.com/takahitomiyamoto/di-sample-apex-trigger)

---

## Appendix: How to create a package

### 1. create a package

```sh
sfdx force:package:create -d "This is a framework that makes our Apex Trigger development more flexible." -e -n "flexible-apex-trigger" -r force-app-fat -t Unlocked -v DevHub
```

### 2. create a package version

```sh
sfdx force:package:version:create -a "Summer '20" -b "master" -c -e "Summer '20 (API version 49.0)" -f config/project-scratch-def.json -n 1.0.0.0 -p 0HoXXXXXXXXXXXXXXX -t v49.0 -v DevHub -x --postinstallurl "https://github.com/takahitomiyamoto/flexible-apex-trigger" --releasenotesurl "https://github.com/takahitomiyamoto/flexible-apex-trigger/releases"
```

### 3. retrieve details about a package version creation request

```sh
sfdx force:package:version:create:report -i 08cXXXXXXXXXXXXXXX -v DevHub
```

### 4. list package version creation requests

```sh
sfdx force:package:version:create:list -s Success -v DevHub
```

### 5. promote a package version to released

```sh
sfdx force:package:version:promote -p 04tXXXXXXXXXXXXXXX -v DevHub
```

### 6. retrieve details about a package version in the Dev Hub org

```sh
sfdx force:package:version:report -p 04tXXXXXXXXXXXXXXX -v DevHub --verbose
```

### 7. list all packages in the Dev Hub org

```sh
sfdx force:package:list -v DevHub --verbose
```

### 8. list all package versions in the Dev Hub org

```sh
sfdx force:package:version:list -p flexible-apex-trigger -v DevHub --verbose
```

## Appendix: How to update a package

### 1. create a package version

```sh
sfdx force:package:version:create -a "Summer '20" -b "master" -c -e "Summer '20 (API version 49.0)" -f config/project-scratch-def.json -n 1.0.1.0 -p 0HoXXXXXXXXXXXXXXX -t v49.0 -v DevHub-FAT -x --postinstallurl "https://github.com/takahitomiyamoto/flexible-apex-trigger" --releasenotesurl "https://github.com/takahitomiyamoto/flexible-apex-trigger/releases"
```

### 2. retrieve details about a package version creation request

```sh
sfdx force:package:version:create:report -i 08cXXXXXXXXXXXXXXX -v DevHub-FAT
```

### 3. update a package version

```sh
sfdx force:package:version:update -a "Summer '20" -b "master" -e "Summer '20 (API version 49.0)" -p 04tXXXXXXXXXXXXXXX -t v49.0 -v DevHub-FAT
```

### 4. promote a package version to released

```sh
sfdx force:package:version:promote -p 04tXXXXXXXXXXXXXXX -v DevHub-FAT
```

### 5. list all package versions in the Dev Hub org

```sh
sfdx force:package:version:list -p flexible-apex-trigger -v DevHub-FAT --verbose
```
