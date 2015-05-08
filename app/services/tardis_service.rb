class TardisService

  after_create :

  attr_reader :token

  def initialize(params)
    @client_id = CLIENT_ID
    @client_secret = CLIENT_SECRET
    @site_url = SITE_URL
  end

  def generate_token
  end

  private

    def token_check
      # if token = nil?
      # generate_token
    end

end