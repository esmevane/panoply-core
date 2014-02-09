module Panoply
  module LabelStates
    extend self

    def all key
      all_states.fetch key.to_sym
    end

    def get key
      state.fetch key
    end

    def state
      { inbox:     "Inbox",
        approved:  "Approved",
        unread:    "Unread",
        request:   "Request",
        declined:  "Declined",
        discarded: "Discarded" }
    end

    def all_states
      { new:      [ get(:inbox), get(:unread) ],
        request:  [ get(:request) ],
        declined: [ get(:declined) ],
        approved: [ get(:approved) ] }
    end

  end
end