#! /usr/bin/ruby
#
# Delete rows from the given table. Must have write access for the given database.
#
# equivalent SQL:
# DELETE FROM my_schema.my_table WHERE col3 = 'hello';
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
    
    q = DLQuery.new(database = 'my_database')
    q.delete_from('my_schema.my_table')
    q.where(q.expr(q.column('col3'), '=', 'hello'));

    begin
        result = client.query(q)
    rescue DLException => e
        puts JSON.pretty_generate(e.detail)
        exit(1)
    else
        puts JSON.pretty_generate(result)
    end
end
