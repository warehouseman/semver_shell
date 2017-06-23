semver_shell is a shell script parser for semantic versioning
====================================================

[Semantic Versioning](http://semver.org/) is a set of guidelines that help keep version and version management sane. This is a Unix shell script parser to help manage a project's versions.

Use it from a Makefile or any scripts you use in your project.

Travis: [![Travis](https://travis-ci.org/warehouseman/semver_shell.svg?branch=master)](https://travis-ci.org/warehouseman/semver_shell)
  CircleCI: [![CircleCI](https://circleci.com/gh/warehouseman/semver_shell.svg?style=svg)](https://circleci.com/gh/warehouseman/semver_shell)

Usage
-----
semver_shell can be used from the command line as:

    $ ./semver.sh "3.2.1" cmp "3.2.1-alpha"
    2
    $ ./semver.sh "3.2.1-alpha" cmp "3.2.1"
    1
    $ ./semver.sh "3.2.1-alpha" cmp "3.2.1-alpha"
    0
    $ ./semver.sh "3.2.1" eq "3.2.1-alpha"
    1
    $ ./semver.sh "3.2.1" lt "3.2.1-alpha"
    0
    $ ./semver.sh "3.2.1" gt "3.2.1-alpha"
    1
    $ ./semver.sh "3.2.1" le "3.2.1-alpha"
    0
    $ ./semver.sh "3.2.1" ge "3.2.1-alpha"
    1
    $ ./semver.sh "3.2.1-alpha" bump_major
    4.0.0
    $ ./semver.sh "3.2.1-alpha" bump_minor
    3.3.0
    $ ./semver.sh "3.2.1-alpha" bump_patch
    3.2.2
    $ ./semver.sh "3.2.1-alpha" strip_special
    3.2.1
    $ ./semver.sh "3.2.1-alpha" parse M m p s
    export M=3;
    export m=2;
    export p=1;
    export s=alpha;


Alternatively, you can source it from within a script:

    . ./semver.sh

    local MAJOR=0
    local MINOR=0
    local PATCH=0
    local SPECIAL=""

    semverParseInto "1.2.3" MAJOR MINOR PATCH SPECIAL
    semverParseInto "3.2.1" MAJOR MINOR PATCH SPECIAL
