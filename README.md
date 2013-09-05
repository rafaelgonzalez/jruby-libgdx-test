jruby-libgdx-test
=================

## Description ##

This is a Proof of Concept game, mostly for myslef.

The goal create a functional game using the [LibGDX](http://libgdx.badlogicgames.com/) Java game library with the polished elegance of Ruby thanks to [JRuby](http://jruby.org/).

## Set up ##

**Requirements**

You need the following (please refer to their specific installation guidelines)

- Java SE Runtime Environment 1.6

  Java 7 will not work. libGDX relies on LWJGL, which does not entirely work with the latest Java.

- jruby 1.7.4 (I recommend using [RVM](http://rvm.io/) to install it with)
- [bundler gem](https://github.com/bundler/bundler)

Then run:

`bundle install`

## Running ##

    jruby main.rb

## Building ##

**Build an executable JAR**

    rake rawr:jar

**Build a Mac OSX app**

    rake rawr:bundle:app

**Build a Windows executable**

    rake rawr:bundle:exe

Builds can be found in the `build` directory.

## License ##

Released under the MIT License. See [LICENSE file](LICENSE) for details.