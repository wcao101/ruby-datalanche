#! /usr/bin/ruby
## equivalent SQL:
# CREATE TABLE my_schema.my_table(
#     col1 uuid NOT NULL,
#     col2 timestamptz,
#     col3 text DEFAULT 'default_text' NOT NULL,
#     col4 varchar(50)
# );
#
#
# COMMIT;

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
    q.create_table('my_schema.my_table')
    q.description('my_table optional description text')
    q.columns({
        'col1' => {
            'data_type' => 'uuid',
            'description' => 'col1 description text',
            'not_null' => true
        },
        'col2' => {
            'data_type' => 'timestamptz',
            'description' => 'col2 description text',
            'default_value' => nil,
            'not_null' => false
        },
        'col3' => {
            'data_type' => 'text',
            'description' => 'col3 description text',
            'default_value' => 'default text',
            'not_null' => true
        },
        'col4' => {
            'data_type' => {'varchar' => [50],},
            'description' => 'col4 description text'
        }
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
