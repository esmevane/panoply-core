# Visitor purchases subscription

A visitor purchases a subscription by inputing billing, account and plan preferences into a subscription form.  On completion, an account and subscription are created for the visitor, and the application begins a tutorial of the dashboard.

#### Some example code

```ruby
class VisitorPurchasesSubscription
  attr_reader :email, :plan, :registration, :token
  def initialize options = Hash.new
    @email        = options.fetch :email
    @plan         = options.fetch :plan
    @registration = VisitorRegistersAccount.new options
    @token        = options.fetch :token
  end

  def perform
    account = registration.perform
    customer = Stripe::Customer.create description: email, plan: plan,
      card: token
    subscription = Subscription.create email: email, plan: plan,
      customer: customer.id
  end
end

purchase_subscription = VisitorPurchasesSubscription.new params
purchase_subscription.perform

```

## Acceptance criteria

- [ ] A visitor is able to pick a plan and subscribe to it
- [ ] A visitor lands on a tutorial-ready dashboard afterward
