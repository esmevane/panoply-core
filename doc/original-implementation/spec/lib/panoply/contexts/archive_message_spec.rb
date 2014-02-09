require 'spec_helper'

describe Panoply::Contexts::ArchiveMessage do

  it "removes inbox state" do
    sender          = Fabricate :account
    recipient       = Fabricate :account
    inbox_state     = Panoply::LabelStates.get :inbox
    sender_messages = Panoply::Components::Conversation.new account: sender
    recipient_inbox = Panoply::Components::Conversation.new account: recipient

    message = sender_messages.create recipients: [recipient], body: "Hey there!"
    labels  = message.labels
    context = Panoply::Contexts::ArchiveMessage.new message: message,
      recipient: recipient

    labels.map do |label|
      label.update_attribute :content, [inbox_state] + label.content
    end

    context.call

    labels.reload.map(&:content).flatten.wont_include inbox_state
  end

end
