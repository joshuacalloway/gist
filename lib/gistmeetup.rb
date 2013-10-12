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

    nextEvent = events[0]
    url = ret["html_url"]
    RMeetup::Client.post(:event_comment, {:event_id => "#{nextEvent.id}", :comment => "#{comment} - #{url}" })
    "Code posted on #{ret} and on Meetup comments for "#{meetup}"
  end

  def login!(credentials={})
    Gist.login!(credentials)
  end
end
