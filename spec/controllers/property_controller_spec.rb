require 'spec_helper'

describe 'property_controller' do
  include FixtureLoader

  describe '#delete' do
    let!(:user) { User.create!(stripe_id: 'cus_5zwokvkevI45Hg') }
    let!(:property) { Property.create!(user: user, subscription_type: 'basic')  }

    it 'creates a user' do

    end

  end

end
