class Task < ApplicationRecord
    validates :content, presence: true, length: {maximum:255}

    validates :status, presence: true, inclusion: { in: ["todo", "done"] }
    STATUSES = [:todo, :done]

    belongs_to :user

end