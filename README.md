# Active Bloom Filter

## BEWARE

THIS WILL LOAD EVERY RECORD IN YOUR TABLE AND USE LOTS OF MEMORY !!!

IF YOUR HAVE A LARGE TABLE IT WILL CRASH YOUR SYSTEM !!!

It would not be useful otherwise, but you are trading network and disk usage for memory.

## Features

* Very fast way to know if something is MORE THAN LIKELY or ABSOLUTELY NOT in your database once the data is loaded.
* Easy to use
* Can bloomfilter on more than one column / field


## Requirements

I ran into deprecated code trying to get Rails 3 working so it is Rails 4 and up for now.

## Install

add this to your Gemfile

    gem 'acts_as_bloomfilter' , git:  "https://github.com/lankford/acts_as_bloomfilter"

then in your model add

    include ActsAsBloomFilter

    acts_as_bloomfilter :myfieldname , :myothername

like so

    class MyClass

      include ActsAsBloomFilter

      acts_as_bloomfilter :myfieldname , :myothername

    end

## Usage

The main use of this for me is when I am doing *Extract Transform Load* operations which I do a lot of.

I would do something like

    unless MyClass.myfieldname_bloom.include? new_value

      MyClass.find_or_create_by(myfieldname:new_value)

    end

## New methods

This adds to your existing model based on the field name you are blooming for

    MyClass.myfieldname_bloom

    MyClass.myfieldname_bloom.insert 'some value'

    MyClass.myfieldname_bloom.delete 'some value'

## Gotchas

Records that are destroyed are automatically removed from the bloomfilter.

Rails does not have a after_delete callback (coming in rails 5 I think) so those are not removed.

You can remove them with a call like this:

     myfieldname_bloom.delete myfieldname

## Credits

Tatsuya Mori [valdzone@gmail.com](mailto:valdzone@gmail.com) [(Original C implementation](http://vald.x0.com/sb/))

This work is based on [Ilya Grigorik's](https://github.com/igrigorik) bloomfilter wrapper called   [bloomfilter-rb](https://github.com/igrigorik/bloomfilter-rb)
