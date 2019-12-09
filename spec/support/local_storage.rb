require 'aws-record'

module LocalStorage
  def self.create_tables!
    migration = Aws::Record::TableMigration.new(TestModel, client: TestModel.dynamodb_client)
    migration.create!(
      provisioned_throughput: {
        read_capacity_units: 1,
        write_capacity_units: 1
      }
    )
    migration.wait_until_available

    migration2 = Aws::Record::TableMigration.new(TestModel2, client: TestModel2.dynamodb_client)
    migration2.create!(
      provisioned_throughput: {
        read_capacity_units: 1,
        write_capacity_units: 1
      }
    )
    migration2.wait_until_available
  end

  def self.drop_tables!
    migration = Aws::Record::TableMigration.new(TestModel, client: TestModel.dynamodb_client)
    migration.delete!

    migration2 = Aws::Record::TableMigration.new(TestModel2, client: TestModel2.dynamodb_client)
    migration2.delete!
  end
end
