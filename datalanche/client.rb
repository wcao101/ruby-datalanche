# -*- coding: utf-8 -*-

require "rubygems"
require "json"
#require "requests" will be done when implementing HTTP REQUEST
#from requests.auth import HTTPBasicAuth
require "url"
require "./exception"


class DLClient
    def initialize(key = '', secret = '', host = None, port = None, verify_ssl = True)
        @auth_key = key
        @auth_secret = secret
        @client = requests.Session()
        @url = 'https://api.datalanche.com'
        @verify_ssl = verify_ssl
        if host != nil
            @url = 'https://' + host
        end

        if port != nil
            @url = self.url + ':' + str(port)
        end
    end

    def self.key(key)
        @auth_key = key
    end

    def self.secret(secret)
        @auth_secret = secret
    end

    def self.get_debug_info(r)
        info = Hash.new

        info['request'] = Hash.new
        info['request']['method'] = r.request.method
        info['request']['url'] = r.request.url
        info['request']['headers'] = r.request.headers
        info['request']['body'] = r.request.body

        info['response'] = Hash.new
        info['response']['http_status'] = r.status_code
        info['response']['headers'] = r.headers

        return info
    end

    def self.query(q = None)
        if q == None
            raise Exception('query == None')
        end

        params = Hash.new(q.params)

        url = @url

        if params.has_key?('database')
            url = url + '/' + urllib.quote_plus(str(params['database']))
            params.delete['database']
        end

        url = url + '/query'
        
        r = @client.post(
            url = url,
            #auth = HTTPBasicAuth(self.auth_key, self.auth_secret), # ALL HTTP OBJECT is commented out before the file able to be compiled.
            headers = {
                'Accept-Encoding'=>'gzip',
                'Content-Type'=>'application/json',
                'User-Agent'=>'Datalanche Python Client'
            },
            data = json.dumps(params),
            verify = @verify_ssl
        )

        result = Hash.new
        debug_info = self.get_debug_info(r)

#        try: the exception handling will be implemented later after the HTTP OBJECT is done.!!
        result['data'] = r.json(object_pairs_hook = Hash.new)            
#        except Exception as e: exception handdling will be done after HTTP OBJECT
            #result['data'] = None

        result['response'] = debug_info['response']
        result['request'] = debug_info['request']

        if not 200 <= r.status_code < 300
            raise DLException(r.status_code, result['data'], debug_info)
        end

        return result
    end
end
