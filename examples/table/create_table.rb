#! /usr/bin/ruby
#
# Create the given table. Must have admin access for the given database.
#
# equivalent SQL:
# CREATE TABLE my_schema.my_table(
#     col1 uuid NOT NULL,
#     col2 varchar(50),
#     col3 integer DEFAULT 0 NOT NULL
# );
#
# COMMIT;
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
    q.create_table('my_schema.my_table')
    q.description('my_table optional description text')
    q.columns({
        'col1' => {
            'data_type' => {
                'name' => 'uuid'
            },
            'description' => 'col1 description text',
            'not_null' => true
        },
        'col2' => {
            'data_type' => {
                'name' => 'timestamptz'
            },
            'description' => 'col2 description text',
            'default_value' => nil,
            'not_null' => false
        },
        'col3' => {
            'data_type' => {
                'name' => 'text'
            },
            'description' => 'col3 description text',
            'default_value' => 'default text',
            'not_null' => true
        },
        'col4' => {
            'data_type' => {
                'name' => 'varchar',
                'args' => [ 50 ]
            },
            'description' => 'col4 description text'
        },
    })

    begin
        result = client.query(q)
    rescue DLException => e
        puts JSON.pretty_generate(e.detail)
        exit(1)
    else
        puts JSON.pretty_generate(result)
        puts "create_table succeeded!\n"
    end
end
