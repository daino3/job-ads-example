require 'spec_helper'

describe 'subscriptions#create' do
  include FixtureLoader

  let(:account) { JSON.parse(load_fixture('valid_params.json')).with_indifferent_access[:account] }
  let(:user) { User.create(account).first }

end
