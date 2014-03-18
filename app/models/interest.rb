class Interest < ActiveRecord::Base
  attr_accessible :name, :image, :remote_image_url
  self.per_page = 2

  # attach the image uploader to Interest
  mount_uploader :image, ImageUploader
end
