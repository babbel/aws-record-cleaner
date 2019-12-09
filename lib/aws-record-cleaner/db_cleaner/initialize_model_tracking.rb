module AwsRecordCleaner
  module DbCleaner
    module InitializeModelTracking

      module WatchRecordsCreation
        def save(*args)
          super(*args).tap do |create_success|
            AwsRecordCleaner::DbCleaner.register_record_for_deletion(self) if create_success
          end
        end

        def save!(*args)
          super(*args).tap do
            AwsRecordCleaner::DbCleaner.register_record_for_deletion(self)
          end
        end
      end

      def self.initialize_tracking
        watch_already_initialized_models
        watch_models_which_will_be_initialized_in_future
      end

      private_class_method def self.watch_models_which_will_be_initialized_in_future
        Aws::Record.instance_eval do
          singleton_class.send(:alias_method, :base_included, :included)

          def included(model)
            base_included(model)
            model.send(:prepend, WatchRecordsCreation)
          end
        end
      end

      private_class_method def self.watch_already_initialized_models
        @@records_for_deletion = []

        all_dynamo_models.each do |model|
          model.send(:prepend, WatchRecordsCreation)
        end
      end

      private_class_method def self.all_dynamo_models
        @@all_dynamo_models ||=
          ObjectSpace
          .each_object(Class)
          .select { |c| c.included_modules.include? Aws::Record }
      end

    end
  end
end
