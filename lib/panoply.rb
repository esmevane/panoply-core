libs = %w(account calendar conversation organization schedule)
libs.each { |lib| require_relative "./panoply/#{lib}" }

module Panoply
end