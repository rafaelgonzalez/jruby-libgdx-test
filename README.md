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
- jruby 1.7.11 (I recommend to install it with [rbenv](https://github.com/sstephenson/rbenv) or [RVM](http://rvm.io/))
- [bundler gem](https://github.com/bundler/bundler)

Then run:

    bundle install

## Running ##

    jruby main.rb

## Building ##

**This is broken at the moment**

You will need JRuby as a JAR before you can start building. You can get it with:

    rawr install

Now you can build an executable JAR

    rake rawr:jar

Or a Mac OSX app

    rake rawr:bundle:app

Or a Windows executable

    rake rawr:bundle:exe

Builds can be found in the `build` directory.

## COPYING ##

In order to comply with the external materials used (see credits section below), this project is licensed under [GNU GPL 3.0](COPYING.txt).

## Credits ##

Kudos to the following, without which this project would not exist.

- [JRuby](http://jruby.org/) ([EPL/GPL/LGPL](https://github.com/jruby/jruby/blob/master/COPYING))

  For providing the power of Java through the elegancy of Ruby.

- [libGDX](http://libgdx.badlogicgames.com/) ([Apache 2 License](http://www.apache.org/licenses/LICENSE-2.0.html))

  An awesome open-source Java gaming library.

- [Liberated Pixel Cup](http://lpc.opengameart.org/) ([CC BY-SA 3.0](http://creativecommons.org/licenses/by-sa/3.0/) / [GNU GPL 3.0](http://www.gnu.org/licenses/gpl-3.0.html))

  Cool assets made available to everyone.

  Also this great repository that compiles up assets neatly: [Universal LPC spritesheet](https://github.com/makrohn/Universal-LPC-spritesheet).

- Peter Cooper and his ["Let’s Build a Simple Video Game with JRuby: A Tutorial" article](http://www.rubyinside.com/video-game-ruby-tutorial-5726.html) that sparked the initial flame.
