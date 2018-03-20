require 'json'

def api_url
	return "https://my-daas-api.com/api/v1"
end

def api_key_header
	return "X-DaaS-Api-Key: your_api_key_here"
end

def get(path)
	return "GET #{api_url}#{path}"
end

def post(path)
	return "POST #{api_url}#{path}"
end

def put(path)
	return "PUT #{api_url}#{path}"
end

def delete(path)
	return "DELETE #{api_url}#{path}"
end

def json(data)
	return JSON.pretty_generate(data)
end

def http(code)
	name = case code
		when 200 then "OK"
		when 201 then "CREATED"
		when 204 then "NO CONTENT"
	end

	return "Example response - #{code.to_s} #{name}"
end

def normalize_request_headers(request)
	headers = {"X-DaaS-Api-Key": "your_api_key_here"}

	if request[:body] then
		headers = headers.merge({"Content-Type": "application/json"})
	end

	if request[:headers] then
		headers = headers.merge(request.headers)
	end

	return headers
end

def curl(request)
	headers = normalize_request_headers(request)

	nl = " \\\n\t" # new line

	response = "curl \"#{api_url}#{request[:endpoint]}\"#{nl}"

	if request[:method]
		response += "-X #{request[:method]}#{nl}"
	end

	response += headers
		.map { |key, value| "#{key.to_s}: #{value}" }
		.map { |h| "-H \"#{h}\""}
		.join(nl)

	if request[:body]
		json = JSON.pretty_generate(request[:body])
			.gsub(/\n/, "\n\t")

		response += "#{nl}-d '#{json}'"
	end

	return response
end

def example_api_key
	return {
		:label => "Service administrator",
		:fragment => "81524",
		:lastUsed => 1577848920,
		:permissions => {
			:apiKeys => "NONE",
			:bots => "READ",
			:lobbies => "WRITE",
			:webhooks => "READ",
		}
	}
end

def example_bot
	return {
		:id => 1,
		:username => "mytestbot",
		:password => "hunter2",
		:steamGuardEnabled => true,
		:status => "OFFLINE",
		:disabledUntil => 1577848920
	}
end

def example_lobby
	return {
		:id => 1,
		:name => "Alliance vs Ninjas in Pyjamas",
		:password => "e25beafbc2ef05afc1d1",
		:server => "LUXEMBOURG",
		:gameMode => "CAPTAINS_MODE",
		:radiantHasFirstPick => false,
		:status => "CLOSED",
		:matchId => "1864620776",
		:matchResult => "RADIANT_VICTORY",
		:players => [
			{
				:steamId => "76561198001497299",
				:isRadiant => true,
				:isReady => true,
				:isCaptain => true
			},
			{
				:steamId => "76561198001554683",
				:isRadiant => true,
				:isReady => true,
				:isCaptain => false
			},
			{
				:steamId => "76561198061761348",
				:isRadiant => true,
				:isReady => true,
				:isCaptain => false
			},
			{
				:steamId => "76561198021550341",
				:isRadiant => true,
				:isReady => true,
				:isCaptain => false
			},
			{
				:steamId => "76561198036748162",
				:isRadiant => true,
				:isReady => true,
				:isCaptain => false
			},
			{
				:steamId => "76561197978446698",
				:isRadiant => false,
				:isReady => true,
				:isCaptain => false
			},
			{
				:steamId => "76561197972496930",
				:isRadiant => false,
				:isReady => true,
				:isCaptain => false
			},
			{
				:steamId => "76561198060583478",
				:isRadiant => false,
				:isReady => true,
				:isCaptain => true
			},
			{
				:steamId => "76561198031551853",
				:isRadiant => false,
				:isReady => true,
				:isCaptain => false
			},
			{
				:steamId => "76561198000475053",
				:isRadiant => false,
				:isReady => true,
				:isCaptain => false
			}
		]
	}
end

def example_player
	return {
		:steamId => "76561198001497299",
		:isRadiant => true,
		:isReady => true,
		:isCaptain => true
	}
end	

def example_webhook
	return {
		:id => 1,
		:eventType => "GAME_FINISHED",
		:url => "https://my-super-app.com/api/webhooks/daas/gameFinished",
		:secret => "fd86a4bab4ec53bc4941ff266199a41ae98e7406"
	}
end	