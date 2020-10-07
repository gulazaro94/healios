RSpec.describe(Url) do

  describe('validations') do
    let(:url) { build(:url) }

    it('validates the presence of required attributes') do
      url.assign_attributes(url: nil, token: nil, access_count: nil)

      expect(url).to be_invalid
      expect(url.errors).to include(:url, :token, :access_count)
    end

    it('is valid with a valid url') do
      url.url = 'http://onsport.com.br'
      expect(url).to be_valid
    end

    it('is invalid with an invalid url') do
      url.url = 'http:onsport.com.br'
      expect(url).to be_invalid
      expect(url.errors[:url]).to eq(['is invalid'])
    end

    it('validates token uniqueness') do
      existing_url = create(:url)

      url.token = existing_url.token
      expect(url).to be_invalid
      expect(url.errors[:token]).to eq(['has already been taken'])
    end

    it('validates the length of the url') do
      url.url = 'http://onsport.com.br/' + ('a' * 2048)

      expect(url).to be_invalid
      expect(url.errors[:url]).to eq(["is too long (maximum is 2048 characters)"])
    end
  end

end
