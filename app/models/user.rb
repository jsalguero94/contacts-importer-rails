class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :csv_files, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :contact_logs, dependent: :destroy
end
