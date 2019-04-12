module Fastlane
  module Actions
    module SharedValues
      REMOVE_GIT_TAG_CUSTOM_VALUE = :REMOVE_GIT_TAG_CUSTOM_VALUE
    end

    class RemoveGitTagAction < Action
      def self.run(params)
      
        tagNum = params[:tagNum]
        rmLocalTag = params[:rmLocalTag]
        rmRemoteTag = params[:rmRemoteTag]
        
        command = []
        if rmLocalTag
            command << "git tag -d #{tagNum}"
        end
    
        if rmRemoteTag
            command << "git push origin :#{tagNum}"
        end
        
        result = Actions.sh(command.join('&'))
        UI.success("Successfully remove tag 🚀")
        return result
        
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "删除tag"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "使用当前action来删除本地和远程冲突的tag"
      end

      def self.available_options
        # Define all options your action supports. 
        
        # Below a few examples
        [
            FastlaneCore::ConfigItem.new(key: :tagNum,
                                         description: "输入即将删除的tag",
                                         is_string: true),

            FastlaneCore::ConfigItem.new(key: :rmLocalTag,
                                         description: "是否删除本地tag",
                                         optional:true,
                                         is_string: false,
                                         default_value: true),

            FastlaneCore::ConfigItem.new(key: :rmRemoteTag,
                                         description: "是否删除远程tag",
                                         optional:true,
                                         is_string: false,
                                         default_value: true)
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['REMOVE_GIT_TAG_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["Wild"]
      end

      def self.is_supported?(platform)
        # you can do things like
        # 
        #  true
        # 
        #  platform == :ios
        # 
        #  [:ios, :mac].include?(platform)
        # 

        platform == :ios
      end
    end
  end
end
