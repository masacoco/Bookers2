class Book < ApplicationRecord
  belongs_to :user, optional: true
  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book
	has_many :book_comments, dependent: :destroy
	scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_this_week, -> { where(created_at: Time.current.all_week) } #今週
  scope :created_last_week, -> { where(created_at: Time.current.last_week.all_week) } #先週


  acts_as_punchable
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200}

  def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+content)
    else
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end

 end