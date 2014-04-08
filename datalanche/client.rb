# -*- coding: utf-8 -*-

require "rubygems"
require "json"
require "net/http"
require "net/https"
require "uri"
require "../../datalanche/query.rb"
#require "../../datalanche/exception"

class DLClient
    def initialize(key, secret, host = nil, port = nil, verify_ssl = true)

        @auth_key = key
        @auth_secret = secret
        @url = 'https://api.datalanche.com'
        @verify_ssl = verify_ssl

        if host != nil
            @url = 'https://' + host
        end

        if port != nil
            @url = @url + ':' + port.to_s()
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
        info['request']['method'] = r #r.request.method
        info['request']['url'] = r #r.request.url
        info['request']['headers'] = r #r.request.headers
        info['request']['body'] = r #r.request.body

        info['response'] = Hash.new
        info['response']['http_status'] = r # r.status_code
        info['response']['headers'] = r # r.headers

        return info
    end

    def query(q = nil)
        if q == nil
            raise Exception('query == nil')
        end
        
        puts "the params are: #{q.params}"

        url = @url

        if q.params.has_key?('database')
            url = url + '/' + URI.parse(str(params['database']))
            q.params.delete('database')
        end

        url = URI.parse(url + '/query')

        header = {
                    'Accept-Encoding'=>'gzip',
                    'Content-Type'=>'application/json',
                    'User-Agent'=>'Datalanche Ruby Client'
                }
        
        req = Net::HTTP::Post.new(url.path, header)
        req.basic_auth @auth_key, @auth_secret
        https = Net::HTTP.new(url.host,url.port)
        https.use_ssl = true
        https.verify_mode = OpenSSL::SSL::VERIFY_NONE
        https.ssl_version = "SSLv3"
        req.body = "#{q.params.to_json}"
        res = https.request(req)
        puts "Response #{res.code} #{res.message}: #{res.body}"


        # req = Net::HTTP::Post.new(url.request_uri)


        # req.post_form(JSON.dump(q.params), header)

        # resp = Net::HTTP.new(url.host, url.port)
        # resp.use_ssl = true
        # resp.ssl_version = "SSLv3"
        # resp.verify_mode = OpenSSL::SSL::VERIFY_NONE
        # response = resp.start {|http| http.request(req)}

        ## test the request body
        puts "the request body is: #{response.body}"

        result = Hash.new
        debug_info = self.get_debug_info(res)

#        try: the exception handling will be implemented later after the HTTP OBJECT is done.!!
        result['data'] = res #res.json(object_pairs_hook = Hash.new)            
#        except Exception as e: exception handdling will be done after HTTP OBJECT
            #result['data'] = None

        result['response'] = debug_info['response']
        result['request'] = debug_info['request']

#        if not 200 <= res.status_code < 300
            # raise DLException(r.status_code, result['data'], debug_info)
 #       end

        return result
    end
end
