#! /usr/bin/ruby
#
# Drop the given schema. Must have admin access for the given database.
#
# equivalent SQL:
# DROP SCHEMA my_schema CASCADE;
#

require "rubygems"
require "json"
require "datalanche"

begin
    config = JSON.load(open(File.expand_path(File.dirname(__FILE__)) + '/../config.json'))
    
    # Please find your API credentials here: https://www.datalanche.com/account before use
    YOUR_API_KEY = config['api_key']
    YOUR_API_SECRET = config['api_secret']
    
    client = DLClient.new(key = YOUR_API_KEY, secret = YOUR_API_SECRET)
    
    q = DLQuery.new(database = 'my_database')
    q.drop_schema('my_schema')
    q.cascade(true)

    begin
        client.query(q)
    rescue DLException => e
        puts JSON.pretty_generate(e.detail)
        exit(1)
    else
        puts "drop_schema succeeded!\n"
    end
end
