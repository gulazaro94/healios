RSpec.describe(Urls::Access) do
  context('with a valid token') do
    let(:url) { create(:url) }

    it('creates the url') do
      accessed_url = described_class.run!(token: url.token)
      expect(accessed_url.reload).to eq(url)
      expect(accessed_url.access_count).to eq(url.access_count + 1)
    end
  end

  context('with an invalid token') do
    it('fails') do
      outcome = described_class.run(token: 'invalidtoken')
      expect(outcome).to be_invalid
      expect(outcome.errors).to include(:token)
    end
  end
end
