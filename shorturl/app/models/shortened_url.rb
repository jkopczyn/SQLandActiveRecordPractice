class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true, length: { maximum: 1024 }
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true
  validates :created_at, spam: true

  belongs_to :submitter, foreign_key: :submitter_id, primary_key: :id,
                         class_name: :User

  has_many :visits,
            foreign_key: :shortened_url_id,
            primary_key: :id,
            class_name:  :Visit

  has_many :visitors,
            -> { distinct },
            through: :visits,
            source:  :visitor

  has_many :taggings,
            foreign_key: :shortened_url_id,
            primary_key: :id,
            class_name:  :Tagging

  has_many :tag_topics,
            -> { distinct },
            through: :taggings,
            source:  :tag_topic



  def self.random_code
    loop do
      code = SecureRandom::urlsafe_base64(16)
      return code unless exists?(short_url: code)
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      long_url: long_url,
      short_url: self.random_code,
      submitter_id: user.id
    )
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visitors.where("created_at > ?", 10.minutes.ago).count
  end

end
