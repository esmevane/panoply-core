require 'spec_helper'

describe Panoply::Contexts::DiscardMessage do

  it "removes inbox state and adds a discarded state" do
    sender          = Fabricate :account
    recipient       = Fabricate :account
    inbox_state     = Panoply::LabelStates.get :inbox
    discarded_state = Panoply::LabelStates.get :discarded
    sender_messages = Panoply::Components::Conversation.new account: sender
    recipient_inbox = Panoply::Components::Conversation.new account: recipient

    message = sender_messages.create recipients: [recipient], body: "Hey there!"
    labels  = message.labels
    context = Panoply::Contexts::DiscardMessage.new message: message,
      recipient: recipient

    labels.map do |label|
      label.update_attribute :content, [inbox_state] + label.content
    end

    context.call

    labels.reload.map(&:content).flatten.must_include discarded_state
    labels.reload.map(&:content).flatten.wont_include inbox_state
  end

end
