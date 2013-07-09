#!/usr/bin/env ruby

require "rubygems"
require "flowdock"
require "json"
require "eventmachine"

#include "FlowdockAuth"

$company ="krux"
tokens
flows

token = 'e07b8f405e6194bdc3a8abb4d1db741d'
flow = 'testing'

#Authenticate our user and retrieve a list of flows
# tokens.each(:associatedflow) |token| do
#     tokens{:status => TokenAuthed(tokens{:token}, company, tokens{:associatedflow})}
# end



http = EM::HTTP.get("https://stream.flowdock.com/flows/#{company}/#{flow}")
EventMachine.run do
    flowstream = http.get(:head => {'Authorization' => [token, ''], 'accept' => 'application/json'}, :keepalive => true, :connect_timeout => 0, :inactivity_timeout => 0)
    buffer = ''
    flowstream.stream do |chunk|
        buffer << chunk
        while line buffer.slice(/.+\r\n/)
            puts JSON.parse(line).inspect
        end
    end
end