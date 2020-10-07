RSpec.describe(Urls::Create) do
  context('with valid inputs') do
    let(:inputs) { { url: 'http://onsport.com.br' } }

    it('creates the url') do
      url = described_class.run!(inputs)
      expect(url).to be_persisted
      expect(url.url).to eq('http://onsport.com.br')
      expect(url.token).to be_present
      expect(url.access_count).to eq(0)
    end
  end

  context('with invalid inputs') do
    let(:inputs) { { url: 'invalid url' } }

    it('fails') do
      outcome = described_class.run(inputs)
      expect(outcome).to be_invalid
      expect(outcome.errors).to include(:url)
    end
  end

end
