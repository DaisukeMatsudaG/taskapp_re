class Task < ApplicationRecord
    validates :content, presence: true, length: {maximum:255}
    
    validates :status, presence: true, inclusion: { in: ["todo", "doing","done"] }
    STATUSES = [:todo, :doing, :done]

    belongs_to :user

    #def self.search(keyword)
    #    where(["content like? ", "%#{keyword}%"])
    #  end
end