module Panoply
  module Roles
    autoload :Approver,    'panoply/roles/approver'
    autoload :Archiver,    'panoply/roles/archiver'
    autoload :Decliner,    'panoply/roles/decliner'
    autoload :Deliverable, 'panoply/roles/deliverable'
    autoload :Discarder,   'panoply/roles/discarder'
    autoload :Notifiable,  'panoply/roles/notifiable'
  end
end