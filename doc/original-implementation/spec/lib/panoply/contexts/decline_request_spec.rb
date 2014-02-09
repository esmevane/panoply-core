require 'spec_helper'

describe Panoply::Contexts::DeclineRequest do
  it "removes a request state and adds a declined state" do
    sender          = Fabricate :account
    recipient       = Fabricate :account
    request_state   = Panoply::LabelStates.get :request
    declined_state  = Panoply::LabelStates.get :declined
    sender_messages = Panoply::Components::Conversation.new account: sender
    recipient_inbox = Panoply::Components::Conversation.new account: recipient

    message = sender_messages.create recipients: [recipient], body: "Hey there!"
    labels  = message.labels
    context = Panoply::Contexts::DeclineRequest.new message: message,
      recipient: recipient

    labels.map do |label|
      label.update_attribute :content, [request_state] + label.content
    end

    context.call

    labels.reload.map(&:content).flatten.must_include declined_state
    labels.reload.map(&:content).flatten.wont_include request_state
  end
end
