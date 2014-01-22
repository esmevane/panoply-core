module Panoply
  module Data
    class Message < ActiveRecord::Base
      belongs_to :sender, class_name: 'Panoply::Data::Account'

      has_many :labels
      has_many :accounts, through: :labels

      scope :for_recipients, -> *recipients do
        joins { labels }.where { labels.account_id.in recipients }
      end

      scope :labeled_by, -> *labels do
        ids = Panoply::Data::Label.labeled_by(*labels).select { message_id }
        where { id.in ids }
      end

    end
  end
end
