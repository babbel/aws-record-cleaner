require_relative 'db_cleaner/initialize_model_tracking'

module AwsRecordCleaner
  module DbCleaner

    class << self
      def initialize_model_tracking
        InitializeModelTracking.initialize_tracking
      end

      def cleaning
        @@records_for_deletion = []
        yield
      ensure
        clean_all_records
      end

      def register_record_for_deletion(record)
        @@records_for_deletion << record
      end

      def clean_all_records
        @@records_for_deletion.each(&:delete!)
      end
    end

  end
end
