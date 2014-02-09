Fabricator :account, from: Panoply::Data::Account

Fabricator :label, from: Panoply::Data::Label do
  account { Fabricate :account }
end

Fabricator :bare_message, from: Panoply::Data::Message do
  after_create do |message|
    message.update_attribute :thread_ids, [message.id]
  end
end

Fabricator :message, from: :bare_message do
  labels { [ Fabricate(:label, content: %w(Unread Inbox)) ] }
end

Fabricator :read_message, from: :message do
  labels { [ Fabricate(:label, content: %w(Inbox)) ] }
end

Fabricator :archived_message, from: :message do
  labels { [ Fabricate(:label, content: %w(Unread)) ] }
end
