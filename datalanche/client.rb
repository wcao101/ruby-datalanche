# -*- coding: utf-8 -*-

require "rubygems"
require "json"
require "requests"
require "collections"
require "urllib"
#from .exception import DLException
#from requests.auth import HTTPBasicAuth

class DLClient(object):
    def initialize(key = '', secret = '', host = None, port = None, verify_ssl = True):
        @auth_key = key
        @auth_secret = secret
        @client = requests.Session()
        @url = 'https://api.datalanche.com'
        @verify_ssl = verify_ssl
        if host != nil:
            @url = 'https://' + host
        if port != nil:
            @url = self.url + ':' + str(port)

    def key(key):
        @auth_key = key

    def secret(secret):
        @auth_secret = secret

    def get_debug_info(r):
        @info = {}
      ########## stops here. Need to continue
        info['request'] = {}
        info['request']['method'] = r.request.method
        info['request']['url'] = r.request.url
        info['request']['headers'] = r.request.headers
        info['request']['body'] = r.request.body

        info['response'] = collections.OrderedDict()
        info['response']['http_status'] = r.status_code
        info['response']['headers'] = r.headers

        return info

