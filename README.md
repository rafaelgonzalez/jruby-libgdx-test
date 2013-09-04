jruby-libgdx-test
=================

## Building ##

**Requirements**

You need the following (please refer to their specific installation guidelines)

- Java SE Runtime Environment (> 1.6)
- jruby 1.7.4
- [bundler gem](https://github.com/bundler/bundler)

Then run:

`bundle install`

**Build an executable JAR**

`rake rawr:jar`

**Build a Mac OSX app**

`rake rawr:bundle:app`

**Build a Windows executable**

`rake rawr:bundle:exe`

Builds can be found in the `build` directory.