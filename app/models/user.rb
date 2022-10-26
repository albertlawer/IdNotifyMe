class User < ApplicationRecord
    has_many :id_masters, class_name: "IdMaster", primary_key: "id", foreign_key: "user_id"
    validates :fullname, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
end
