require "ostruct"

FactoryBot.define do
  factory :simple_config_data, class: OpenStruct do
    data_key { "path/of/key" }
    data_value { "value of key" }
    url { "http://localhost:8500/v1/kv/#{data_key}" }
    request_method { :get }
    request_headers {
      {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v0.15.4'
      }
    }
    response_status { 200 }
    response_body { '[{"LockIndex":0,"Key":"path/of/key","Flags":0,"Value":"dmFsdWUgb2Yga2V5","CreateIndex":285150,"ModifyIndex":285150}]' }
  end

  factory :nil_config_data, class: OpenStruct do
    data_key { "key" }
    data_value { nil }
    url { "http://localhost:8500/v1/kv/#{data_key}" }
    request_method { :get }
    request_headers {
      {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v0.15.4'
      }
    }
    response_status { 404 }
  end
  
end
