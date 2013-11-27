jruby-libgdx-test
=================
<!-- [![Build Status](https://travis-ci.org/rafaelgonzalez/jruby-libgdx-test.png?branch=master)](https://travis-ci.org/rafaelgonzalez/jruby-libgdx-test) -->
<!-- [![Coverage Status](https://coveralls.io/repos/rafaelgonzalez/jruby-libgdx-test/badge.png?branch=master)](https://coveralls.io/r/rafaelgonzalez/jruby-libgdx-test) -->
[![Code Climate](https://codeclimate.com/github/rafaelgonzalez/jruby-libgdx-test.png)](https://codeclimate.com/github/rafaelgonzalez/jruby-libgdx-test)

## Description ##

This is a Proof of Concept game, mostly for myself.

The goal is to create a functional game using the [LibGDX](http://libgdx.badlogicgames.com/) Java game library with the polished elegance of Ruby thanks to [JRuby](http://jruby.org/).

## Set up ##

**Requirements**

You need the following (please refer to their specific installation guidelines)

- Java SE Runtime Environment 1.6 or 1.7
- jruby 1.7.8 (I recommend to install it with [rbenv](https://github.com/sstephenson/rbenv) or [RVM](http://rvm.io/))
- [bundler gem](https://github.com/bundler/bundler)

Then run:

    bundle install

## Running ##

    jruby main.rb

## Building ##

You will need JRuby as a JAR before you can start building. You can get it with:

    rawr install

Now you can build an executable JAR

    rake rawr:jar

Or a Mac OSX app

    rake rawr:bundle:app

Or a Windows executable

    rake rawr:bundle:exe

Builds can be found in the `build` directory.

## License ##

This project uses the [libGDX](http://libgdx.badlogicgames.com/) Java library as well as [Liberated Pixel Cup](http://lpc.opengameart.org/) assets, both released under different licenses.

This project will try to comply with both as best as possible, but in the meantime there will not be a specific license mentioned here.