# encoding: UTF-8
module Cluster
  class RetrieveActivityProfile

    def self.build(lrs, type)
      request = {}

      case type
        when 'typical'
          request['primers'] = [
              FactoryGirl.create(:typical_activity_profile, lrs: lrs)
          ]
          request['main'] = Request::RetrieveActivityProfile.build(lrs, 'typical')
      end

      request
    end
  end
end