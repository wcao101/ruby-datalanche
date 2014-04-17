#! /usr/bin/ruby
#
#
# Alter the given table's properties. Must have admin access for the given database.
#
# equivalent SQL:
#
# BEGIN TRANSACTION;
#
# ALTER TABLE my_schema.my_table
#     DROP COLUMN col2,
#     ALTER COLUMN col1 DROP NOT NULL,
#     ALTER COLUMN col1 SET DATA TYPE text,
#     ADD COLUMN new_col integer;
# ALTER TABLE my_schema.my_table RENAME COLUMN col3 TO col_renamed;
# ALTER TABLE my_schema.my_table RENAME TO my_new_table;
# ALTER TABLE my_schema.my_new_table SET SCHEMA my_new_schema;
#
# COMMIT;
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
    q.alter_table('my_schema.my_table')
    q.set_schema('my_new_schema')
    q.rename_to('my_new_table')
    q.description('my_new_table description text')
    q.add_column('new_col', {
        'data_type' => {
            'name' => 'integer'
        },
        'description' => 'new_col description text'
    })
    q.alter_column('col1', {
        'data_type' => {
            'name' => 'text'
        },
        'description' => 'new col1 description text'
    })
    q.drop_column('col2')
    q.rename_column('col3', 'col_renamed')

    begin
        result = client.query(q)
    rescue DLException => e
        puts JSON.pretty_generate(e.detail)
        exit(1)
    else
        puts JSON.pretty_generate(result)
        puts "alter_table succeeded!\n"   
    end
end
