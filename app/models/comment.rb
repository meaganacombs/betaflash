class Comment < ActiveRecord::Base
  validates :pin_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true
  
  belongs_to :pin
  belongs_to :user
  
 has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  default_scope -> { order('created_at DESC') }
end
