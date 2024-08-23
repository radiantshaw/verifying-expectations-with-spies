require "spec_helper"
require "signup"

describe Signup do
  let(:account_name) { "Example" }
  let(:email) { "user@example.com" }

  let(:signup) { Signup.new(email: email, account_name: account_name) }

  let(:account) { double("account") }
  let(:user) { double("user") }

  before do
    allow(Account).to receive(:create!).and_return(account)
    allow(User).to receive(:create!).and_return(user)
  end

  describe "#save" do
    it "creates an account with one user" do
      expect(signup.save).to be(true)
      expect(Account).to have_received(:create!).with(name: account_name)
      expect(User).to have_received(:create!).with(account: account, email: email)
    end
  end

  describe "#user" do
    it "returns the user created by #save" do
      signup.save

      expect(signup.user).to eq(user)
    end
  end
end
