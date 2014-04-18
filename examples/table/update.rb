#! /usr/bin/ruby
#
# Update rows in the given table. Must have write access for the given database.
#
# equivalent SQL:
# UPDATE my_schema.my_table SET col3 = 'hello world' WHERE col3 = 'hello';
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
    
    q = DLQuery.new(database = 'my_database')
    q.update('my_schema.my_table')
    q.set({
        'col3' => 'hello world'
    })
    q.where(q.expr(q.column('col3'), '=', 'hello'))

    begin
        result = client.query(q)
    rescue DLException => e
        puts JSON.pretty_generate(e.detail)
        exit(1)
    else
        puts JSON.pretty_generate(result)
    end
end
