class TagTopic < ActiveRecord::Base
  validates :topic, presence: true, uniqueness: true

  has_many :taggings,
            foreign_key: :tag_topic_id,
            primary_key: :id,
            class_name: :Tagging

  has_many :urls,
            through: :taggings,
            source: :url

  def most_popular_link
    urls.sort_by(&:num_clicks).first
  end

end
