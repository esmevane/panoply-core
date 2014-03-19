# Visitor registers account

A visitor obtains a registratation by filling out a form with their name, email and password.  Provided the email is unique, they are then registered, and redirected to a dashboard.

#### Some example code

```ruby
class AccountRegistrationForm
  extend ActiveModel::Naming
  include ActiveModel::Conversions
  include ActiveModel::Validations

  attr_reader :email, :name, :password

  validates :email, presence: true
  validates :name, presence: true
  validates :password, presence: true

  validate :unique_email?

  def initialize options = Hash.new
    @email    = options.fetch :email
    @name     = options.fetch :name
    @password = options.fetch :password
  end

  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def unique_email?
    errors.add(:email, "already taken") if Panoply::Account.email_taken?(email)
  end

  def persist!
    Panoply::Account.register email: email, name: name, password: password
  end
end

# Accounts Controller
def create
  registration = AccountRegistrationForm.new params
  if registration.save
    redirect_to dashboard_path
  else
    render :new
  end
end
```

## Acceptance criteria

- A visitor is able to fill out a registration form and get an account
- After registering, the visitor may log in and out
- Passwords are salted and encrypted
- Emails, names and passwords are required
- Only unused emails are accepted

## Application Layer Design Details

### AccountRegistrationForm
* Validates email, name and password presence
* Validates email uniqueness

### Logging in

* `account = Panoply::Account.authenticate(email: email, password: password)`
* Assign `account.id` to `cookies[:account_id]`
* Later pages look up based on the cookie

### Logging out

* Unassign `cookies[:account_id]`

## Thoughts

* Validation might be a form layer concept, instead of a concern of the domain.  Otherwise the two need to have sustained conversations and that means that messages would potentially (and incorrectly) pass upward through the boundaries.
