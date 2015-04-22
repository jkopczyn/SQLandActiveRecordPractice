class Tagging < ActiveRecord::Base
  validates :shortened_url_id, presence: true
  validates :tag_topic_id, presence: true

  belongs_to :tag_topic,
              foreign_key: :tag_topic_id,
              primary_key: :id,
              class_name:  :TagTopic

  belongs_to :url,
              foreign_key: :shortened_url_id,
              primary_key: :id,
              class_name:  :ShortenedUrl

  def self.create_with_url_and_topic(shortened_url, tag_topic)
    Tagging.create(
      shortened_url_id: shortened_url.id,
      tag_topic_id: tag_topic.id
    )
  end
end
