require 'digest'

# Two scenarios exist:
# * A new account, created with email and password.  A salt and an encrypted
#   password will need to be created.  In order to do this, an encrypted
#   password will have to be generated.
# * An account reconstituted from a repository.  This will already have a
#   set of salt/encrypted password values.  This means the encryptyed password
#   will have to be simply instantiated.
#
# * Basically, creation and reconstitution are two separate EncyptedPassword
#   ideas.

class Account
  attr_reader :email, :encrypted_password, :password, :salt
  def initialize options = Hash.new
    @email    = options.fetch(:email)
    @password = options.fetch(:password)
    @salt     = options.fetch(:salt)
  end

  def save
    @salt = make_salt unless has_password?(password)
    @encrypted_password = encrypt(password)
  end

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  private

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end

account = Account.new email: 'bob@example.com', password: 'burrito', salt: ''
account.save
