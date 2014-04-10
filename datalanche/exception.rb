# -*- coding: utf-8 -*-

class DLException < Exception

    attr_reader:status_code 
    attr_reader:body
    attr_reader:debug_info

    def initialize(status_code, body, debug_info)

        @request = debug_info['request']
        @response = debug_info['response']
        @response['body'] = body
        @error_message = body
        @error_type = body
        @status_code = status_code
    end


    def return_exception
        exception = {
            'status_code' => @status_code,
            'error_message' => @error_message,
            'error_type' => @error_type,
            'request' => @request,
            'response' => @response
        }
        return exception
    end
end


