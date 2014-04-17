#! /usr/bin/ruby
#
# Create an index on the given table. Must have admin access for the given database.
#
# equivalent SQL:
# CREATE UNIQUE INDEX my_index ON my_schema.my_table USING btree (col1, col2);
#
current_dir = File.expand_path(File.dirname(__FILE__))
require "rubygems"
require "json"
require File.dirname(__FILE__) + '/../../datalanche/datalanche_modu'

begin
    # need to look for this module require "sys"
    config = JSON.load(open(current_dir + '/../config.json'))
    
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
    q.create_index('my_index')
    q.unique(True)
    q.on_table('my_schema.my_table')
    q.using_method('btree')
    q.columns([ 'col1', 'col2' ])

    begin
        result = client.query(q)
    rescue DLException => e
        puts JSON.pretty_generate(e.detail)
        exit(1)
    else
        puts JSON.pretty_generate(result)
        puts "create_index succeeded!\n"
    end
end
