require 'mongo_mapper'
require 'carrierwave'
require 'carrierwave/validations/active_model'

module CarrierWave
  module MongoMapper
    ##
    # See +CarrierWave::Mount#mount_uploader+ for documentation
    #
    def mount_uploader(column, uploader=nil, options={}, &block)
      key (options[:mount_on] || column), String

      super

      alias_method :read_uploader, :read_attribute
      alias_method :write_uploader, :write_attribute
      public :read_uploader
      public :write_uploader

      include CarrierWave::Validations::ActiveModel

      validates_integrity_of column if uploader_option(column.to_sym, :validate_integrity)
      validates_processing_of column if uploader_option(column.to_sym, :validate_processing)

      after_save :"store_#{column}!"
      before_save :"write_#{column}_identifier"
      after_destroy :"remove_#{column}!"
      before_update :"store_previous_model_for_#{column}"
      after_save :"remove_previously_stored_#{column}"

      class_eval <<-RUBY, __FILE__, __LINE__+1
        def #{column}=(new_file)
          column = _mounter(:#{column}).serialization_column
          send(:"\#{column}_will_change!")
          super
        end
      RUBY
    end
  end # MongoMapper
end # CarrierWave

module MongoMapper
  module Document
    def self.included(base)
      base.class_eval do
        extend CarrierWave::Mount
        extend CarrierWave::MongoMapper
      end
    end
  end
end
