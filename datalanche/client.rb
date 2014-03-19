# -*- coding: utf-8 -*-

require "rubygems"
require "json"
require "net/http"
require "uri"
#require "../../datalanche/exception"


class DLClient
    def initialize(key, secret, host = nil, port = nil, verify_ssl = true)
        @auth_key = key
        @auth_secret = secret
        @client = Net::HTTP::Post
        @url = 'https://api.datalanche.com'
        @verify_ssl = verify_ssl
        if host != nil
            @url = 'https://' + host
        end

        if port != nil
            @url = @url + ':' + str(port)
        end
    end

    def key(key)
        @auth_key = key
    end

    def secret(secret)
        @auth_secret = secret
    end

    def get_debug_info(r)
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

    def query(q = nil)
        if q == nil
            raise Exception('query == nil')
        end

        params = {}
        params = q.params

        url = @url

        if params.has_key?('database')
            url = url + '/' + URI.parse(str(params['database']))
            params.delete('database')
        end

        url = URI.parse(url + '/query')

        req = @client.new(url.path, initheader = {
                                                    'Accept-Encoding'=>'gzip',
                                                    'Content-Type'=>'application/json',
                                                    'User-Agent'=>'Datalanche Ruby Client'
                                                 } )
        req.basic_auth(@auth_key, @auth_secret)
        req.use_ssl = @verify_ssl
        req.form_data(Json.dump(params))

        res = https.request(req)

        result = Hash.new
        debug_info = self.get_debug_info(res)

#        try: the exception handling will be implemented later after the HTTP OBJECT is done.!!
        result['data'] = r.json(object_pairs_hook = Hash.new)            
#        except Exception as e: exception handdling will be done after HTTP OBJECT
            #result['data'] = None

        result['response'] = debug_info['response']
        result['request'] = debug_info['request']

        if not 200 <= res.status_code < 300
            raise DLException(r.status_code, result['data'], debug_info)
        end

        return result
    end
end
