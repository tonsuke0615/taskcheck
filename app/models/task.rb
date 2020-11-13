class Task < ApplicationRecord
  before_validation :set_nameless_name
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  # 検証内容が複雑化した際の可読性を重視して上記の記述
  # 下記の記述だと一行で済む 
  # validates :name, presence: true, length: { maximum: 30 } 
  validate :validate_name_not_including_comma

  belongs_to :user

  scope :recent, -> { order(crestedd_at: :desc)}

  private

  def validate_name_not_including_comma
    errors.add(:name, 'にカンマをいれることはできません') if name&.include?(',')
  end

  def set_nameless_name
    self.name = '名前なし' if name.blank?
  end

end