class App < ActiveRecord::Base
  before_create :rehash_token
  has_many :file_sources, :dependent => :destroy
  has_many :profiles, :dependent => :destroy

  validates :name, presence: true, uniqueness: true

  private

  def rehash_token
    while true
      random_token = SecureRandom.urlsafe_base64
      break unless App.where(:token => random_token).exists?
    end

    self.token = random_token
  end
end
