#! /usr/bin/ruby
#
# Show all databases you have access to.
#

require "rubygems"
require "json"
Dir[File.dirname(__FILE__) + '/datalanche/*.rb'].each {|file| require file }

begin
    # need to look for this module require "sys"
    config = JSON.load(open('../config.json'))

    # Load config.json for setting API_KEY, API_SECRET, host, port and verify_ssh
    # change the settings in config.json before running examples
    
    if config['verify_ssl'] == '0' or config['verify_ssl'] == 'false'
        config['verify_ssl'] = false
    else
        config['verify_ssl'] = true
    end

    # Please find your API credentials here: https://www.datalanche.com/account before use
    YOUR_API_KEY = config['api_key']
    YOUR_API_SECRET = config['api_secret']
    
    client = DLClient.new(key = YOUR_API_KEY, secret = YOUR_API_SECRET, host = config['host'], port = config['port'], verify_ssl = config['verify_ssl'])
    
    q = DLQuery.new()
    q.alter_database('my_database')
    q.rename_to('my_new_database')
    q.description('my_new_database description text')
    
    begin
        result = client.query(q)
    rescue DLException => e
        puts JSON.pretty_generate(e.detail)
        exit(1)
    else
        puts JSON.pretty_generate(result)
    end
end
