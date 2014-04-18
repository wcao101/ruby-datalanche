#! /usr/bin/ruby
#
# Alter the given schema's properties. Must have admin access for the given database.
#
# equivalent SQL:
# ALTER SCHEMA my_schema RENAME TO my_new_schema;
#

require "rubygems"
require "json"
require File.dirname(__FILE__) + '/../../datalanche/datalanche_modu'

begin
    config = JSON.load(open(File.expand_path(File.dirname(__FILE__)) + '/../config.json'))
    
    # Please find your API credentials here: https://www.datalanche.com/account before use
    YOUR_API_KEY = config['api_key']
    YOUR_API_SECRET = config['api_secret']
    
    client = DLClient.new(key = YOUR_API_KEY, secret = YOUR_API_SECRET)
    
    q = DLQuery.new(database='my_database')
    q.alter_schema('my_schema')
    q.rename_to('my_new_schema')
    q.description('my_new_schema description text')

    begin
        result = client.query(q)
    rescue DLException => e
        puts JSON.pretty_generate(e.detail)
        exit(1)
    else
    puts JSON.pretty_generate(result)
    puts "alter_schema succeeded!\n"
    end
end
