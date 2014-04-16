class SiteConfig < ActiveRecord::Base
  attr_accessible :lock_version, :captcha_pub_key, :captcha_priv_key, :name, :time_zone, :start_date, :number_of_days  
  attr_accessor :tz_offset
end
