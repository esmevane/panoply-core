# Panoply core

## It would be nice if...
- We could see schedules from your organizations.
- We supported ingoing and outgoing emails or SMS

## Components

### Panoply::Components::Conversations

View, search, respond to and manage message threads.

When you retrieve messages using a conversation object, it returns a `Panoply::Collections::Threads` object that could contain zero or more `Panoply::Models::Thread` objects.  The conversation object keeps these threads scoped to the account object (a `Panoply::Components::Account` instance) used to initialize it.

`Panoply::Models::Thread` objects are designed to contain all of the messages within a thread's lifespan, in order of creation.

#### Create conversation object

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

##### TODO

* Retrieve conversations by time sent
* Retrieve conversations by time requested (for displaying when a specific Calendar date)
* Initialize conversations with an Organization object (where recipients can be any of the organization members)
* Recording and utilizing actions - how do I implement the knowledge of actionable features on an individual message?  How does that float up to the parent thread model?  Or the parent threads collection?
* Ordering threads by different signals
* Send bare message
* Send group message
* Send organization message
* Send actionable message (Rejectable, Approvable, Negotiable)
* Forward a message
* Actionable messages probably have an actions hstore field, or maybe just an array as in other parts of the message schema.  Does this mean I need to come up with some sort of paper trail / history / undoable feature for messages?  I.E., send a rejection and then undo it?
* It seems like undoing is a big deal here UX-wise, I don't see why I shouldn't start out with versions.  I've heard the memory hog concept, but maybe fixing that is as simple as wiping out versions older than 30 seconds.
* Every time a message is sent within a thread, all messages within that thread need to have their thread_ids updated.  I am thinking that there is an opportunity for a reusable Panoply::Utilities::Ancestry module here which I can use to take a data object and criteria and return a manageable list of IDs.

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

# Message Delivery notes

Not very happy about the way the message delivery process looks.  There is too much knowledge of Data objects in here.

Ideally, wouldn't it be better to be reaching for Labels and Messages through a repository of some sort?

Maybe I'm getting lost in architecture here, and assuming that, I will leave it as-is and put some dreamcode in place here so that later I can improve it.

```ruby
def call
  new_message(message_params) do |message|
    label_repo.new_labels(recipients, message)
  end
end
def new_message
  yield message_repo.new_message message_params
end
```

