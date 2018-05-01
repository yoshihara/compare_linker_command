require "optparse"
require "compare_linker_command/version"

module CompareLinkerCommand
  class Parser
    def self.parse(*args)
      self.new.parse(*args)
    end

    def initialize
      @op = OptionParser.new
      @op.program_name = "create_pr_with_compare_linker"
      @op.version = VERSION
    end

    def parse(argv)
      params = {succeeded: true}

      @op.on("", "--github-access-token TOKEN", "GitHub token for access") do |v|
        params[:token] = v
      end

      @op.on("", "--repo-name NAME", "org/repository for bundle update") do |v|
        params[:repo_name] = v
      end

      @op.on("", "--pr-body-file FILEPATH", "file path of description for bundle update PR") do |v|
        params[:pr_body_file] = v
      end

      error_message = ""

      begin
        @op.parse(argv)
      rescue OptionParser::InvalidOption => e
        error_message << e.message
      end

      unless params[:token]
        error_message << "--github-access-token is required. Abort.\n\n"
      end

      unless params[:repo_name]
        error_message << "--repo-name is required. Abort.\n"
      end

      unless error_message.empty?
        $stderr.puts error_message
        $stderr.puts @op

        params[:succeeded] = false
      end

      params
    end
  end
end
