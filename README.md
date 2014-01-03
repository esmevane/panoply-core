# Panoply core

## It would be nice if...
- We could see schedules from your organizations.
- We supported ingoing and outgoing emails or SMS

## Components

### Panoply::Components::Conversations

View, search, respond to and manage message threads.

When you retrieve messages using a conversation object, it returns a `Panoply::Collections::Threads` object that could contain zero or more `Panoply::Models::Thread` objects.

`Panoply::Models::Thread` objects are designed to contain all of the messages within a thread's lifespan, in order of creation.

#### Create conversation object

The Conversations object assumes that you will want to scope all of its searches to a specific object, either a `Panoply::Account` or `Panoply::Organization` instance is used to retrieve messages.

If an `Account` object is supplied, then the threads are scoped to the recipient account.

If an `Organization` object is supplied, then the threads are scoped to only messages addressed to an entire organization.

```ruby
conversations = Panoply::Components::Conversations.new(account)
# => Panoply::Components::Conversation instance for the account object
```

#### View threads with new messages

```ruby
conversations.unread
# => Panoply::Collections::Threads object
```

#### View threads

```ruby
conversations.inbox
# => Panoply::Collections::Threads object
```

#### Pagination

```ruby
# Default thread limit is 50
conversations.inbox.length
# => 50

# Modification is passed in as an argument
conversations.inbox(limit: 100).length
# => 100

# Starting page can be passed in as well
conversations.inbox(page: 3)
# => Returns the 3rd page of inbox threads
```

#### Search messages by criteria

Message threads can be retrieved with combinable criteria, and each accepts either a string, a Time value, array, boolean or range.  Both `#inbox` and `#unread` are convenience methods for `#search` with preset behavior.

```ruby
# By label
conversations.search(label: 'Inbox')
# => Panoply::Collections::Threads object

# By organization
conversations.search(organization: "The Fern")
# => Panoply::Collections::Threads object

# By sender
conversations.search(sender: "admin@example.com")
# => Panoply::Collections::Threads object

# By response type
conversations.search(response: "Rejections")
# => Panoply::Collections::Threads object

# By term
conversations.search(containing: "out of town")
# => Panoply::Collections::Threads object

# By sent time (value)
conversations.search(sent_before: 1.day.from_now)
conversations.search(sent_after: 1.day.from_now)
conversations.search(sent_within: 1.day.from_now..1.week.from_now)
# => Panoply::Collections::Threads object

# By requested time (value)
conversations.search(request_before: 1.day.from_now)
conversations.search(request_after: 1.day.from_now)
conversations.search(request_within: 1.day.from_now..1.week.from_now)
# => Panoply::Collections::Threads object
```

#### Retrieve a single thread

```ruby
# From a collection
threads = conversations.inbox
threads.first
# => Panoply::Models::Thread object

# Or directly
conversation.thread(message_id)
# => Panoply::Models::Thread object

# Long form
Panoply::Conversation.thread(account, message_id)
# => Panoply::Models::Thread object
```

Would it be valuable to pass in a set of IDs instead of a single ID and get a Collection object back (as a rule)?  Probably.  Maybe with `#search(id: [ids])` instead, though?

#### Message actions

A number of actions can be taken on behalf of a thread collection, or an individual thread, either through the `#perform(:symbol)` method or through the following convenience methods:
  - `#reject` - (convenience for `:reject`)
  - `#approve` - (convenience for `:approve`)
  - `#discard` - (convenience for `:discard`)
  - `#archive` - (convenience for `:archive`)

The following methods are available only for individual threads:
  - `#negotiate` - (convenience for `:negotiate`)
  - `#reply` - (convenience for `:reply`)

```ruby
# Batches
threads = conversations.search(containing: "")
threads.reject("Rejection reason")

# Individually
new_suggested_time = 3.days.from_now
thread.negotiate(time: new_suggested_time)
```

#### Send messages to users

```ruby
thread.reply(body: 'Contents of message')
```

### Panoply::Components::Accounts

Sign up, create and cancel subscriptions.

- Create account
- Subscribe to an organization
- Change organization subscription
- Cancel subscription
- Renew subscription
- Cancel account
- Edit account

### Panoply::Components::Calendars

View organization schedules and request availability.

- View organization schedules
- Create appointment request
- Cancel appointment request (Is this a Conversation?)
- Search for appointments
- Search for organizations

### Panoply::Components::Organizations

Manage an organization's information and users.

- Edit an organization
- Invite users to be providers
- Manage provider organization permissions
- Remove providers
- Accept organization invitations
- Cancel organization memberships

### Panoply::Components::Schedules

Create and manage schedules and time slots.

- Publish new schedules.
- View previously published schedules.
- Copy and republish schedules.
- Store schedule publication drafts.
- Modify currently published schedules.
- Unpublish schedules.

### Panoply::Components::Introductions

Scent-tailored landing pages for pitches.

## Contexts

#### Invite users to organizations.

```ruby
Panoply::Contexts::ManagerInvitesProvider.new(manager, provider).call
```
