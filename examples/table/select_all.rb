#! /usr/bin/ruby
#
# Select rows from the given table. Must have read access for the given database.
#
# equivalent SQL:
# SELECT DISTINCT col1, col2
#     FROM my_schema.my_table
#     WHERE col3 LIKE '%hello%'
#     ORDER BY col1 ASC, col2 DESC
#     OFFSET 0 LIMIT 10;
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
    q.select_all()
    q.distinct(true)
    q.from('my_schema.my_table')
    q.where(q.expr(q.column('col3'), '$like', '%hello%'))
    q.order_by([
        q.expr(q.column('col1'), '$asc'),
        q.expr(q.column('col2'), '$desc')
    ])
    q.offset(0)
    q.limit(10)

    begin
        result = client.query(q)
    rescue DLException => e
        puts JSON.pretty_generate(e.detail)
        exit(1)
    else
        puts JSON.pretty_generate(result)
    end
end
