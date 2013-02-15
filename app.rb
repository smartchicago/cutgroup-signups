class CutgroupSignups < Sinatra::Base
  get "/" do
    halt 404, "not here."
  end
      
  post "/signup" do
    halt 401 unless params['HandshakeKey'] && params['HandshakeKey'] == ENV['WUFOO_HANDSHAKE_KEY']
    
    # Input format:
    # {
    #   "Field1"=>"first-field-awesome", "Field2"=>"second-field-better", 
    #   "CreatedBy"=>"public", "DateCreated"=>"2013-02-14 19:23:10", 
    #   "EntryId"=>"1", "IP"=>"69.245.247.117", "HandshakeKey"=>"123456789"
    # }

    begin
      s3 = AWS::S3.new
      bucket = s3.buckets["cutgroup.smartchicagoapps.org"]    # FIXME: set as env var
      signup_file = bucket.objects['assets/js/signups.json']  # FIXME: set as env var
    
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