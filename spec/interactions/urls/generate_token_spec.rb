RSpec.describe(Urls::GenerateToken) do
  subject(:run) { described_class.run! }

  let(:existing_url) { create(:url) }

  it('generates a valid token') do
    token = run
    expect(token).to be_present
    expect(token.length).to eq(described_class::TOKEN_SIZE)
  end

  it('tries to create another if token already exists') do
    allow(SecureRandom).to receive(:base58).and_return(existing_url.token, 'vldToken47')

    expect(run).to eq('vldToken47')
    expect(SecureRandom).to have_received(:base58).twice
  end

  it('raises an error if cannot find non-existing token before max attempts') do
    allow(SecureRandom).to receive(:base58).and_return(existing_url.token)

    expect { run }.to raise_error('max token attempts exceeded')
  end

end
