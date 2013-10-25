require 'gist'
require 'rmeetup'
require 'parse-ruby-client'
require 'json'

Parse.init :application_id => "H4kSq1roztLdYcKu6IdixJgbVtzaoxlEfagYiRYA",
           :api_key        => "LGcTEzAnxzWUTngaXzdjy4FUixwUSeTJuy8sw56d"

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
      response = RMeetup::Client.post(:event_comment, {:event_id => "#{nextEvent.id}", :comment => "#{comment} - #{url}" })
      saveMetaData(meetup, comment, nextEvent, url, response)
      "Posted to github on '#{url}' and link to it on '#{meetup}' comments"
    end
  end

  def saveMetaData(meetup, comment, nextEvent, url, response)
    json = JSON.parse(response.body)
    
    code = Parse::Object.new("Code")
    code["meetup"] = meetup
    code["comment"] = comment
    code["nextEvent_id"] = nextEvent.id
    code["nextEvent_name"] = nextEvent.name
    code["member_id"] = json["member_id"].to_s
    code["member_name"] = json["member_name"]
    code["event_comment_id"] = json["event_comment_id"].to_s
    result = code.save
  end

  def login!(credentials={})
    Gist.login!(credentials)
  end
end
