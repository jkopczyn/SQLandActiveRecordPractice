class SpamValidator < ActiveModel::EachValidator
  def validate_each(record, attribute_name, value)
    if record.submitter.submitted_urls.where(
          "created_at > ?", 1.minutes.ago).count > 5
      message = options[:message] || "Too many links in the last minute"
      record.errors[attribute_name] << message
    end
  end
end
