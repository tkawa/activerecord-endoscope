# activerecord-endoscope

Endoscope enables scope to apply to model instance

## Example

```ruby
class User < ActiveRecord::Base
  extend ActiveRecord::Endoscope # add this before using scope
  scope :admin, -> {
    where(role: 'admin')
  }
  scope :not_admin, -> {
    where.not(role: 'admin')
  }
  scope :admin_or_manager, -> {
    where(role: ['admin', 'manager'])
  }
  scope :minor, -> {
    where(age: 0..19)
  }
  scope :aged, ->(age) {
    where(age: age)
  }
  scope :have_no_email, -> {
    where(email: nil)
  }
  scope :have_email, -> {
    where.not(email: nil).where.not(email: '')
  }
end
```

Then these methods are defined automatically:

```ruby
u = User.new(role: 'ordinary', age: 20, email: 'foobar@example.com')
u.admin?            # => false
u.not_admin?        # => true
u.admin_or_manager? # => false
u.minor?            # => false
u.aged?(20)         # => true
u.has_no_email?     # => false
u.has_email?        # => true
```

**With NO SQL execution.**


## Restriction

Limited queries have been supported yet.

SQL literal such as `where('email IS NOT NULL')` is not supported.

Supported queries are shown in:
https://github.com/tkawa/arel_ruby/blob/master/lib/arel/visitors/ruby.rb

If your query is not supported, you can override the method manually.


## Installation

Add these lines to your application's Gemfile:

    gem 'activerecord-endoscope'
    gem 'arel_ruby', github: 'tkawa/arel_ruby'

And then execute:

    $ bundle


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Acknowledgment

The features of this gem almost depend on arel_ruby.

https://github.com/amatsuda/arel_ruby

Thanks @amatsuda!
