module Panoply
  class Account
    attr_accessor :options, :repo

    def initialize options = Hash.new
      @options = options
    end

    def register
      # Do something to create a record with the given options
    end

    def self.register options = hash.new
      new(options).register
    end
  end

  # User stories expressed by core represented as method calls?
  def self.register_account options = Hash.new
    Account.register options
  end
end

class AbstractForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

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

  def persist!
    # No-op, define in inheriting classes.
  end

end

class RegistrationForm < AbstractForm
  attr_reader :email, :name, :password

  validates :name, :password, presence: true
  validates :email, presence: true, uniqueness: true

  def initialize options = Hash.new
    @email    = options.fetch :email
    @name     = options.fetch :name
    @password = options.fetch :password
  end

  private

  def persist!
    Panoply.register_account email: email, name: name, password: password
  end

end

class API::AccountsController < ApiController
  # POST /api/v0/accounts
  def create
    if registration.save
      render json: registration, status: :created
    else
      render json: registration.errors, status: :unprocessable_entity
    end
  end

  protected

  def registration
    registration_params = params.permit(:email, :name, :password)
    @registration ||= RegistrationForm.new registration_params
  end
end

class AccountsController < ApplicationController
  # POST /accounts
  def create
    if registration.save
      redirect_to dashboard_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  protected

  def registration
    registration_params = params.permit(:email, :name, :password)
    @registration ||= RegistrationForm.new registration_params
  end
end
