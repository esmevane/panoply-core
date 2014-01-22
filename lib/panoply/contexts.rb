module Panoply
  module Contexts
    autoload :ApproveRequest,  'panoply/contexts/approve_request'
    autoload :ArchiveMessage,  'panoply/contexts/archive_message'
    autoload :DeclineRequest,  'panoply/contexts/decline_request'
    autoload :DiscardMessage,  'panoply/contexts/discard_message'

    autoload :MessageDelivery, 'panoply/contexts/message_delivery'
    autoload :SearchThreads,   'panoply/contexts/search_threads'
    autoload :StartThread,     'panoply/contexts/start_thread'
    autoload :ThreadResponse,  'panoply/contexts/thread_response'
  end
end