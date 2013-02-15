class CutgroupSignups < Sinatra::Base
  get "/" do
    halt 404, "not here."
  end
  
  post "/signup" do
    # TODO: sniff access token from params to ensure it's legit
    
    # s3 = AWS::S3.new
    # bucket = s3.buckets("cutgroup.smartchicagoapps.org")    # FIXME: set as env var
    # signup_file = bucket.objects['assets/js/signups.json']  # FIXME: set as env var
    
    params.inspect

  end  
end