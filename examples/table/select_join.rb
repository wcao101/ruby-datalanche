#! /usr/bin/ruby
#
# Join multiple tables and retrieve the rows. Must have read access for the given database.
#
# equivalent SQL:
# SELECT * FROM t1
#     JOIN t2 ON t1.c1 = t2.c1
#     JOIN t3 ON t1.c1 = t3.c1;
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
    q.select_all()
    q.from(q.expr(
        q.table('my_schema.t1'),
        '$join', q.table('my_schema.t2'), '$on', q.column('my_schema.t1.col1'), '=', q.column('my_schema.t2.col1'),
        '$join', q.table('my_schema.t3'), '$on', q.column('my_schema.t1.col1'), '=', q.column('my_schema.t3.col1')
    ))

    begin
        result = client.query(q)
    rescue DLException => e
        puts JSON.pretty_generate(e.detail)
        exit(1)
    else
        puts JSON.pretty_generate(result)
    end
end
