#! /usr/bin/env ruby

require 'json'

class Conditions
    matchingconditions
    def initialize(conditions)
        matchingconditions = conditions
    end
    def matches? (input)
        return input == matchingconditions[:condition][:matches]
    end
    def respond
        flowdock.posttochat(matchingconditions["respondwith"])
    end
end