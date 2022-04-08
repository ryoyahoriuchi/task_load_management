class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :overview, presence: true, length: { maximum: 255 }

  enum status: {
    not_started: 0,
    underway: 1,
    completed: 2
  }
  
  has_many :task_items, dependent: :destroy
  accepts_nested_attributes_for :task_items, reject_if: :reject_both_blank, allow_destroy: true #proc { |attributes| attributes['item'].blank? }

  def reject_both_blank(attributes)
    if attributes[:id]
      attributes.merge!(_destroy: "1") if attributes[:item].blank?
      !attributes[:item].blank?
    else
      attributes[:item].blank?
    end
  end
end
