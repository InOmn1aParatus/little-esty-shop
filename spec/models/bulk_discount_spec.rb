require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'relationships' do
    it { should belong_to(:merchant) }  
    it { should validate_presence_of(:pct_discount) }
    it { should validate_numericality_of(:pct_discount) }
    it { should validate_presence_of(:qty_threshold) }
    it { should validate_numericality_of(:qty_threshold) }
  end
end