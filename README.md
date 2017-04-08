semver_shell is a shell script parser for semantic versioning
====================================================

[Semantic Versioning](http://semver.org/) is a set of guidelines that help keep
version and version management sane. This is a Unix shell script parser to help manage a project's versions.

Use it from a Makefile or any scripts you use in your project.

Travis: [![Travis](https://travis-ci.org/warehouseman/semver_bash.svg?branch=master)](https://travis-ci.org/warehouseman/semver_bash)
  CircleCI: [![CircleCI](https://circleci.com/gh/warehouseman/semver_shell.svg?style=svg)](https://circleci.com/gh/warehouseman/semver_shell)

Usage
-----
semver_shell can be used from the command line as:  

    $ ./semver.sh "3.2.1" "3.2.1-alpha"  
    3.2.1 -> M: 3 m:2 p:1 s:  
    3.2.1-alpha -> M: 3 m:2 p:1 s:-alpha  
    3.2.1 == 3.2.1-alpha -> 1.  
    3.2.1 < 3.2.1-alpha -> 1.  
    3.2.1 > 3.2.1-alpha -> 0.


Alternatively, you can source it from within a script:

    . ./semver.sh  
    
    local MAJOR=0  
    local MINOR=0  
    local PATCH=0  
    local SPECIAL=""
    
    semverParseInto "1.2.3" MAJOR MINOR PATCH SPECIAL  
    semverParseInto "3.2.1" MAJOR MINOR PATCH SPECIAL  
