class Api::ConferenceController < ApplicationController
  def index
    @mobilePages = MobilePage.find :all, :order => 'position asc'
    @scale = params[:scale].to_f
    @theme = MobileTheme.find :first # TODO - change, get the default
    @formats = Format.find :all
    @default_bio_image = DefaultBioImage.find :first
    @cloudinaryURI = Cloudinary::Utils.cloudinary_url('A').sub(/\/A/,'')
    @partition_val = @cloudinaryURI.sub(/http\:\/\/a[0-9]*\./,'')
  end
  
  def show
    @mobilePages = MobilePage.find :all, :order => 'position asc'
    @scale = params[:scale].to_f
    @theme = MobileTheme.find :first # TODO - change, get the default
    @default_bio_image = DefaultBioImage.find :first
    @formats = Format.find :all
    @cloudinaryURI = Cloudinary::Utils.cloudinary_url('A').sub(/\/A/,'')
    @partition_val = @cloudinaryURI.sub(/http\:\/\/a[0-9]*\./,'')
  end
end
