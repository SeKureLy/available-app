# require_relative '../../init'
# require_relative '../../config/environment'
require 'json'

module PaperDeep
    module Utilities
        class CreateCitationTree

            
            def initialize(gateway, root_paper)
                @root_paper = root_paper
                @gateway = gateway  # PaperMapper instance
                @content = Hash.new
            end


            def create()
                @tree_content = {
                    content: {NodeName: @root_paper[:title], link: @root_paper[:paper_link], eid: @root_paper[:eid]},
                    next: []
                }


                create_tree(@tree_content, 0)
                return
            end


            def create_tree(subtree, height)
                
                return [] if height == 3

                @gateway.search(subtree[:content][:eid])
                parsed = @gateway.parse.first(3)

                subtree[:next][0] = {
                    content: {NodeName: parsed[0][:title], link: parsed[0][:paper_link], eid: parsed[0][:eid]},
                    next: []
                }
                subtree[:next][1] = {
                    content: {NodeName: parsed[1][:title], link: parsed[1][:paper_link], eid: parsed[1][:eid]},
                    next: []
                }
                subtree[:next][2] = {
                    content: {NodeName: parsed[2][:title], link: parsed[2][:paper_link], eid: parsed[2][:eid]},
                    next: []
                }
                puts "-"*20

                puts subtree
                
                puts "-"*20

                # puts "-"*10 << "Current Tree" << "-"*10
                # puts tree_content
                # puts "-"*10 << "End" << "-"*10

                
                create_tree(subtree[:next][0], height+1)
                create_tree(subtree[:next][1], height+1)
                create_tree(subtree[:next][2], height+1)

            end

            def get_tree()
                puts @tree_content
            end

            # def initialize(str)
            #     @str = str
            # end

            # def middle()
            #     add(@str, 0)
            # end

            # def add(origin_str, num)
            #     return if num > 3
            #     t = origin_str << " success"
            #     add(t, num+1)
            # end

            # def get_str()
            #     @str
            # end
        end 
    end
end





# json_init = JSON.dump({    # string
# content: {NodeName: "Article1", link: "link"},
# next: [
# ]
# })


#                 puts subtree.class

#                 a = Hash.new
#                 a = {content: {a: "b", c: "d"},
#                     next: []}    
#                 subtree[:next][0] = a
#                 subtree[:next][1] = a
#                 subtree[:next][2] = a

#                 # json_content[:next].update({
#                 #     content: {NodeName: "Article", link: "link"},
#                 #     next: [
#                 #     ]
#                 # })

#                 recur(a, height+1)



# puts json_init.class

# json_content = JSON.parse(json_init, symbolize_names: true) # string -> hash

# puts json_content

# recur(json_content, 0)

# puts json_content

