$: << File.expand_path('../', __FILE__)

require 'panoply/version'

aggregates = %w(account)
entities   = %w(account service subscription)
factories  = %w(account)
repos      = %w(account)
services   = %w(authenticate_account register_account search_services)
values     = %w(encrypted_password)

aggregates.each { |agg|     require "panoply/aggregates/#{agg}"    }
entities.each   { |entity|  require "panoply/entities/#{entity}"   }
factories.each  { |factory| require "panoply/factories/#{factory}" }
repos.each      { |repo|    require "panoply/repositories/#{repo}" }
services.each   { |service| require "panoply/services/#{service}"  }
values.each     { |value|   require "panoply/values/#{value}"      }

module Panoply
end
