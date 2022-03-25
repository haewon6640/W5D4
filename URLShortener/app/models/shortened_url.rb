# == Schema Information
#
# Table name: shortened_urls
#
#  id        :bigint           not null, primary key
#  user_id   :integer
#  long_url  :string           not null
#  short_url :string
#
class ShortenedUrl < ApplicationRecord

    validates :short_url, uniqueness: true
    validates :long_url, presence: true

    belongs_to :submitter,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    has_many :visits,
        primary_key: :id,
        foreign_key: :url_id,
        class_name: :Visit

    has_many :visitors,
        through: :visits,
        source: :visitors

    def self.random_code
        url = SecureRandom::urlsafe_base64
        while self.exists?(short_url: url)
            url = SecureRandom::urlsafe_base64
        end
        "https://#{url}.eu"
    end

    def self.generate(user,long_url)
        url = self.random_code
        self.create!({:user_id => user.id, 
            :long_url => long_url,:short_url => url})
    end
end
