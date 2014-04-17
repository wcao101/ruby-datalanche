# -*- coding: utf-8 -*-

require "rubygems"
require "json"
require "net/http"
require "net/https"
require "zlib"
require "uri"
require_relative "./query"
require_relative "./exception"

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

    def get_debug_info(res,req)
        info = Hash.new

        info['request'] = Hash.new
        info['request']['method'] = req['method']
        info['request']['url'] = req['url']
        info['request']['headers'] = req['headers']
        info['request']['body'] = req['body']

        info['response'] = Hash.new
        info['response']['http_status'] = res.code # r.status_code
        info['response']['message'] = res.message
        info['response']['http_version'] = res.http_version

        return info
    end

    def query(q = nil)
        if q == nil
            raise Exception('query == nil')
        end

        url = @url

        if q.params.has_key?('database')
            url = url + '/' + q.params['database']
            q.params.delete('database')
        end

        url = URI.parse(url + '/query')

        header = {
                   # 'Accept-Encoding'=>'gzip', # will be resumed after method of decompression of gzip found
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

        result = Hash.new
        req_info = Hash.new

        req_info['headers'] = header
        req_info['url'] = url
        req_info['method'] = req.method
        req_info['body'] = req.body

        debug_info = self.get_debug_info(res,req_info)


        begin
            result['data'] = JSON.parse(res.body)
        rescue  # in case the server does not return a body
            result['data'] = nil
        end

        result['response'] = debug_info['response']
        result['request'] = debug_info['request']


        status_code = res.code.to_i 
        if not (200 <= status_code and status_code < 300)
            raise DLException.new(res.code, result['data'], debug_info),"Http request error: "
        end
        return result

    end
end
