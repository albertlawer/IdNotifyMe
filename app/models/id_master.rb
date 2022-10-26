class IdMaster < ApplicationRecord
    belongs_to :user, class_name: "User", primary_key: "id", foreign_key: "user_id"
    validates :id_type_id, presence: true
    validates :name_on_id, presence: true
    validates :id_number, presence: true
    validates :issue_date, presence: true
    validates :exipry_date, presence: true
    validates :user_id, presence: true
    validates :front_image, presence: true
    validates :back_image, presence: true
end
