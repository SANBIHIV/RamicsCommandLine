require 'rest-client'
require 'json'
require 'rexml/document'

name = ARGV[0]
sample_file = ARGV[1]
reference_file = ARGV[2]
parameters = ARGV[3]

url = "https://hiv-tools-api.sanbi.ac.za/v2"

job = {tool: 'Ramics', name: name}
job['parameters'] = JSON.parse(parameters) unless parameters.nil?
job['input_files'] = {}

[sample_file, reference_file].each_with_index do |file, i|
	RestClient::Request.execute(method: :get, url: url + "/authentications/s3", headers: {content_type: 'application/json'}) do |response, request, result|
		if result.code == "200"
			policy = JSON.parse(response.body)
			RestClient::Request.execute(method: :post, url: 'https://hiv-uploads.s3.amazonaws.com', headers: {content_type: 'multipart/form-data'}, payload: {
					'key' => policy['key'] + File.basename(file),
					'AWSAccessKeyId' => policy['aws_key_id'],
					'acl' => policy['acl'],
					'success_action_status' => policy['success_action_status'],
					'signature' => policy['signature'],
					'policy' => policy['policy'],
					'file' => File.open(file, 'r'),
				} ) do |response, request, result|
					doc = REXML::Document.new(response.body)
					job['input_files'][i.to_s] = {'public_url' => doc.root.elements['Location'].text, 'filename' => File.basename(file)}
				end
		else
			puts response.body
		end
	end
end

RestClient::Request.execute(method: :post, url: url + "/jobs", payload: {job: job}, headers: {content_type: 'application/json'}) do |response, request, result|
	if result.code == "200"
		puts JSON.parse(response.body)['job']['_id']
	else
		puts response.body
	end
end