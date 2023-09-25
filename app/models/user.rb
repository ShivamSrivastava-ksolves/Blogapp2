class User < ApplicationRecord


  validates :username, presence:true, length:{ minimum:5, maximum:50}, uniqueness: { uniqueness: "username already exist"}
  validates :username, format: { with: /\A[a-zA-Z0-9_]+\z/ }


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


         after_create do
       stripe_customer = Stripe::Customer.create(email: email)
       stripe_customer_id = stripe_customer.id
       update(stripe_customer_id: stripe_customer_id)
        end



  has_many :posts
  has_one_attached :image
  has_many :comments, as: :commentable


   ROLES = %w{admin editor normal}

   def admin?
    role == 'admin'
   end

   def editor?
    role == 'editor'
   end

   def normal?
    role == 'normal'
   end


end
