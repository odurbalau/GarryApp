class User < ActiveRecord::Base
  attr_accessible :image, :remote_image_url, :crypted_password, :email, :first_name, :last_name, :password_salt, :persistence_token, :username, :password, :password_confirmation
  acts_as_authentic
  
  mount_uploader :image, ImageUploader

  has_many :ratings, :dependent => :destroy
  #has_many :decks, :dependent => :destroy
  #has_many :cards, :dependent => :destroy
  
  #has_many :courses, :dependent => :destroy

end
