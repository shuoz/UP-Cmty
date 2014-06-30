class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :participants, :dependent => :destroy
  validates :firstname, :lastname, presence: true
  validates_format_of :email, :with => /.upenn.edu/, :message => "please use a .upenn.edu email"
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :tagline, length: {maximum: 50}


  #has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
  #  :url =>  "/app/assets/images/:style/':avatar_file_name.png'",
  #:default_url => ActionController::Base.helpers.asset_path('missing_:style.png'),
  #  :path => ":root_path/public/assets/'missing_:style.png'"
  #validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  #validates_attachment :avatar, :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"] }
  #validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]
  #do_not_validate_attachment_file_type :avatar
  #has_attached_file :asset, styles: {thumb: "100x100#"}
end
