module ChaskiqRubyClient

  RSpec.describe ChaskiqRubyClient::Config, type: :model do

    let(:chaskiq_config){  ChaskiqRubyClient::Config }

    it "will setup" do
      chaskiq_config.setup do |config|
        config.secret_key = "123445"
      end
      expect(chaskiq_config.secret_key).to_not be_nil
    end

  end
end