require 'mongoid/sessions'

module Mongoid
	module Sessions 

    def collection
      @collection
    end

    def collection_name
      @collection_name
    end
	end
end
