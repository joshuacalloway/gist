require 'gist'
require 'rmeetup'

module Gistmeetup
  extend self

  VERSION = '0.0.1'

  module Error;
    def self.exception(*args)
      RuntimeError.new(*args).extend(self)
    end
  end

  def post(meetup, comment, files, options={})
    ret = Gist.multi_gist(files, options)

    RMeetup::Client.api_key = "311e1e54e55667752236e673758662c"

    events = RMeetup::Client.fetch(:events, {:group_urlname => "#{meetup}"})
    if events.empty?
      groups = RMeetup::Client.fetch(:groups, {:group_urlname => "#{meetup}"})
      ret = ""
      if groups.empty?
        ret = "The meetup '#{meetup}' does not exist." 
      else
        ret = "No meetup events exist for '#{meetup}'"
      end
      ret
    else
      nextEvent = events[0]
      url = ret["html_url"]
      RMeetup::Client.post(:event_comment, {:event_id => "#{nextEvent.id}", :comment => "#{comment} - #{url}" })
      "Posted to github on '#{url}' and link to it on '#{meetup}' comments"
    end
  end

  def login!(credentials={})
    Gist.login!(credentials)
  end
end
