class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :participants, :dependent => :destroy
  validates :name, presence: true
  validates_format_of :email, :with => /.upenn.edu/, :message => "please use a .upenn.edu email"
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }  
  validates :school, presence: true
  validates :graduation, presence: true

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  #validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment :avatar, :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"] }
  has_attached_file :asset, styles: {thumb: "100x100#"}
end
