module PaperDeep
    class PaperMapper
        def initialize(gh_token, gateway_class = PaperDeep::ScopusAPI)
            @token = gh_token
            @gateway_class = gateway_class
            @gateway = @gateway_class.new(@token)
        end

        def raw_data()
            @data = @gateway.search()
        end

        def parse()
            @data.map do |origin_hash|
              PaperDeep::PaperInfo.new(origin_hash).content
            end
        end
    end
end