class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :vacancy

  # рекурсивная ссылка на самого себя
  # комментарий верхнего уровня - не имееет parent, поэтому ставим optional.
  belongs_to :parent,  class_name: 'Comment', optional: true
  has_many   :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  accepts_nested_attributes_for :replies

  def self.upvote(id)
    comment = find(id)
    comment.update_attributes(rank: comment.rank + 1)
  end
end
