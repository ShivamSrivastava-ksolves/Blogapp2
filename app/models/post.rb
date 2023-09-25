class Post < ApplicationRecord
  is_impressionable
  paginates_per 5


  validates :title, presence:true, length:{ minimum:5, maximum:50}
  validates :description, presence:true, length:{ minimum:5, maximum:2000}
  validates :keywords, presence:true

  belongs_to :user

  has_many :comments, as: :commentable
  has_many :likes, dependent: :destroy

  validates :like, numericality: { greater_than_or_equal_to: 0 }



  mount_uploader :avatar, AvatarUploader

  #   before_create :randomize_id
#   private
#  def randomize_id
#    begin
#      self.id = SecureRandom.random_number
#      (1_000_000_000)
#    end while User.where(id: self.id).exists?

#  end

end
