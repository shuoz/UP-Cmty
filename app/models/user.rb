class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  validates :name, presence: true
  #validates :email, inclusion: { :in => %w(.upenn.edu), :message => "please use a .upenn.edu email" }
  validates :school, presence: true
  validates :graduation, presence: true
end
