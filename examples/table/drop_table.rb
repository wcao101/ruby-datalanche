#! /usr/bin/ruby
#
# Drop the given table. Must have admin access for the given database.
#
# equivalent SQL:
# DROP TABLE my_schema.my_table CASCADE;
#
#! /usr/bin/python
#
# Show the given table's details. Must have read access for the given database.
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
    q.drop_table('my_schema.my_table')
    q.cascade(true)

    begin
        result = client.query(q)
    rescue DLException => e
        puts JSON.pretty_generate(e.detail)
        exit(1)
    else
        puts JSON.pretty_generate(result)
        puts "drop_table succeeded!\n"
    end
end
