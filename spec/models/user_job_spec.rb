require 'spec_helper'

describe JobsUser do
  it { is_expected.to validate_presence_of(:years) }
end
