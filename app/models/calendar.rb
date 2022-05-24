# frozen_string_literal: true

module Available
  # Behaviors of the currently logged in account
  class Calendar
    attr_reader :id, :title, :share_id, # basic info
                :owner, :collaborators, :documents, :policies # full details

    def initialize(calendar_info)
      process_attributes(calendar_info['attributes'])
    #   process_relationships(calendar_info['relationships'])
    #   process_policies(calendar_info['policies'])
    end

    private

    def process_attributes(attributes)
      @id = attributes['id']
      @title = attributes['title']
      @share_id = attributes['share_id']
    end

    # def process_relationships(relationships)
    #   return unless relationships

    #   @owner = Account.new(relationships['owner'])
    #   @collaborators = process_collaborators(relationships['collaborators'])
    #   @documents = process_documents(relationships['documents'])
    # end

    # def process_policies(policies)
    #   @policies = OpenStruct.new(policies)
    # end

    # def process_documents(documents_info)
    #   return nil unless documents_info

    #   documents_info.map { |doc_info| Document.new(doc_info) }
    # end

    # def process_collaborators(collaborators)
    #   return nil unless collaborators

    #   collaborators.map { |account_info| Account.new(account_info) }
    # end
  end
end
