class TardisService

  attr_reader :token

  def initialize
    get_or_set_token
  end

  private

    def get_or_set_token
      if $token.nil?
        get_token
      else
        set_token
      end
    end

    def get_token
      authorized_application = OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, :site => SITE_URL)
      @token = authorized_application.client_credentials.get_token
    end

    def set_token
      @token = $token
    end

    def wrap_params(basic_params)
      result_hash = {
        :params => basic_params
      }
    end

end