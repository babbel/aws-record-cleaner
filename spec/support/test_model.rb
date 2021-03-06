require_relative 'dynamodb_config'

class TestModel
  include Aws::Record

  string_attr :id, hash_key: true

  configure_client(DynamodbConfig.client_options)
  set_table_name(DynamodbConfig.table_name_test1)
end
