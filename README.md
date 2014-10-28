# MadId

Will can help you to inject easy identifiers into your `ActiveRecord` models.

It will:

  * set up a `before_save` callback to set `identifier`
  * override `to_param` to return `identifier`
  * give you a `short_identifer` that returns the first 12 chars of `identifier`

Rightnow its very opinonated and not configurable in any way, this might change.

## Installation

Add this line to your application's Gemfile:

    gem 'mad_id'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mad_id

## Usage

### Rails

    class YourModel < ActiveRecord::Base
      identify_with :foo
    end

after you create the object it will have the `identifier` attribute set to

    "foo-<UUID>"

### Plain

If your not using Rails you'll have to include `MadId` on your own

    class YourModel < ActiveRecord::Base
      include MadID

      identify_with :baz
    end

### Registry

You can access all registered identifiers and the associated class via MadID's registry

    MadID.registry
    # => { 'foo' => YourModel }

### Locator

    MadID.locate("pny-1312313412")
    # => #Object:Pony:1312313412

## Contributing

1. Fork it ( http://github.com/<my-github-username>/mad_id/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
