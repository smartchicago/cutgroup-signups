class CutgroupSignups < Sinatra::Base
  get "/" do
    halt 404, "not here."
  end
      
  post "/signup" do
    halt 401 unless params['HandshakeKey'] && params['HandshakeKey'] == ENV['WUFOO_HANDSHAKE_KEY']
    
    begin
      s3 = AWS::S3.new
      bucket = s3.buckets[ENV['AWS_SIGNUP_BUCKET']]
      signup_file = bucket.objects[ENV['AWS_SIGNUP_FILE_KEY']]
    
      ward = params["Field31"]  # The number of the ward
      json = JSON.parse(signup_file.read)
    
      json[ward.to_s] ||= 0
      json[ward.to_s] += 1
    
      signup_file.write json.to_json

      201
    rescue StandardError => se
      puts "error: #{se.inspect}"
    end      
  end  
end