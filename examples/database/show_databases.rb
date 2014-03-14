#! /usr/bin/ruby
#
# Show all databases you have access to.
#
require "rubygems"
require "json"
require "../../datalanche/client.rb"
# need to look for this module require "sys"

begin

  config = JSON.load(open('../config.json'))

  # Please find your API credentials here: https://www.datalanche.com/account before use
  YOUR_API_KEY = config['api_key']
  YOUR_API_SECRET = config['api_secret']

  puts "the api-key is: " + YOUR_API_KEY + " and api secret is: " + YOUR_API_SECRET

  # #### this region will is about the datalanche module, and will be resumed after
  # module is available
  # and the exception handle will be recovered.
    # client = DLClient(key = YOUR_API_KEY, secret = YOUR_API_SECRET)

    # q = DLQuery()
    # q.show_databases()

    # result = client.query(q)

    # puts json.dumps(result, indent=2)

    # #except DLException as e:
    # puts repr(e)
    # sys.exit(1)

end
