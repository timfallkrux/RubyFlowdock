class FlowdockAuth {
    server = 'https://api.flowdock.com'
    def TokenAuthed (token, company, path)
        http = Net::HTTP.new (server)
        http.use_ssl = true
        resp = Net ::HTTP::Get.new (path)
        resp.basic_auth token
        message = http.request (resp)
        return message.body
    end
    
    def MessageTrigger (tokens, triggermessages)
        for tokens.each do |i|
            for triggermessages.each do |r|
                if i == r
                    return true
                end
            end
        end
        return false
    end
    
    def FlowObj (token, {username, address, source})
        username = nil
        address = nil
        source = nil
        flow = Flowdock::Flow.new (:api_token => token, :external_user_name => username, :address => address, :source => source)