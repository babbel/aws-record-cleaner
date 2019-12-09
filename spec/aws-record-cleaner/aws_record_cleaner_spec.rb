require 'spec_helper'

RSpec.describe AwsRecordCleaner::DbCleaner do

  it "deletes all DB records created during block execution" do
    test_model1, test_model2, another_model1 = nil, nil, nil
    described_class.initialize_model_tracking
    described_class.cleaning do
      test_model1 = TestModel.new(id: '123').tap(&:save!)
      test_model2 = TestModel.new(id: '231').tap(&:save!)
      another_model1 = TestModel2.new(id: '321').tap(&:save!)
    end

    expect(TestModel.find(id: test_model1.id)).to be_nil
    expect(TestModel.find(id: test_model2.id)).to be_nil
    expect(TestModel2.find(id: another_model1.id)).to be_nil
  end

end
