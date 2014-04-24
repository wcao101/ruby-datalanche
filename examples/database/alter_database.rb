#! /usr/bin/ruby
#
# Alter the given database's properties. Must have admin access for the database.
#
# equivalent SQL:
# ALTER DATABASE my_database RENAME TO my_new_database;
#
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
    
    q = DLQuery.new()
    q.alter_database('my_database')
    q.rename_to('my_new_database')
    q.description('my_new_database description text')
    
    begin
        client.query(q)
    rescue DLException => e
        puts JSON.pretty_generate(e.detail)
        exit(1)
    else
        puts "alter_database succeeded!\n"
    end
end
