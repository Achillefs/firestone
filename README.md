# firestone [![Build Status](https://travis-ci.org/Achillefs/firestone.png?branch=master)](https://travis-ci.org/Achillefs/firestone)

A collection of Firefox automation and programmatic management scripts in Ruby

## Platforms

Profile and Addon management works on Windows, Linux and Mac OSX.
The Installer is only implemented for OSX at this time.

## Installation

Add this line to your application's Gemfile:

    gem 'firestone', :require => 'firefox'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install firestone

## Usage

### Install Firefox from a ruby script

    require 'firefox'
    Firefox.install!

or

    require 'firefox'
    installer = Firefox::Installer.new(:osx)
    installer.install!

This currently only works on OSX.

### Create a new Firefox profile with a couple of custom preferences

    require 'firefox'
    p = Firefox::Profile.create('./newprofile')
    p.prefs = {
      'browser.rights.3.shown' =>  true,
      'browser.shell.checkDefaultBrowser' =>  false,
      'toolkit.telemetry.prompted' =>  2,
      'toolkit.telemetry.rejected' =>  true
    }
    p.save!

This will create a new firefox profile in `./newprofile`. It will populate the new profile's preferences with the values provided.
If the given folder does not exist it will create it.

## Suggestions, comments, bugs, whatever
Feel free to use Issues to submit bugs, suggestions or feature requests. 

## Contributing
  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create new Pull Request