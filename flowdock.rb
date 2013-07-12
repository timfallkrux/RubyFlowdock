#!/usr/bin/env ruby

require "rubygems"
require "flowdock"
require "json"
require "eventmachine"
require 'em-http-request'

#include "FlowdockAuth"

$company ="krux"
#tokens
#flows

token = 'a5ee341e5249df691399fa04be374f4f'
flow = 'testing'

#Authenticate our user and retrieve a list of flows
# tokens.each(:associatedflow) |token| do
#     tokens{:status => TokenAuthed(tokens{:token}, company, tokens{:associatedflow})}
# end



http = EM::HttpRequest.new("https://stream.flowdock.com/flows/#{$company}/#{flow}")
EventMachine.run do
    flowstream = http.get(:head => {'Authorization' => [token, ''], 'accept' => 'application/json'}, :keepalive => true, :connect_timeout => 0, :inactivity_timeout => 0)
    buffer = ''
    flowstream.stream do |chunk|
        buffer << chunk
        while line = buffer.slice!(/.+\r\n/)
            parsedinput = JSON.parse(line)
            if parsedinput["event"] == "message"
                puts "User #{parsedinput["user"]} said #{parsedinput["content"]}"
            end
        end
    end
end