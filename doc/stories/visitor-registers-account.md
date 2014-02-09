# Visitor registers account

A visitor obtains a registratation by filling out a form with their name, email and password.  Provided the email is unique, they are then registered, and redirected to a dashboard.

#### Some example code

```ruby
class VisitorRegistersAccount
  attr_reader :email, :name, :password
  def initialize options = Hash.new
    @email    = options.fetch :email
    @name     = options.fetch :name
    @password = options.fetch :password
  end

  def perform
    Account.register email: email, name: name, password: password
  end
end

registration = VisitorRegistersAccount.new params
registration.perform
```

## Acceptance criteria

[ ] - A visitor is able to fill out a registration form and get an account
[ ] - After registering, the visitor may log in and out