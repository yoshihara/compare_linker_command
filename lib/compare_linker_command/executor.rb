require "compare_linker"
require "git"
require "octokit"

module CompareLinkerCommand
  class Executor
    def initialize(current_dir, params)
      @current_dir = current_dir
      @repo_name = params[:repo_name]
      @pr_body = params[:pr_body_file] ? File.read(params[:pr_body_file]) : ""
      @token = params[:token]

      # TODO: local/remoteをここで生成する
    end

    def exec
      branch_name    = "bundle_update_" + Date.today.strftime("%Y_%m_%d")
      commit_message = "bundle update " + Date.today.strftime("%Y.%m.%d")
      pr_title       = commit_message

      $stdout.puts "Stash"
      $stdout.puts `git stash`

      local = Git.open(@current_dir)

      $stdout.puts "Checkout master & pull"
      local.branch("master").checkout()
      local.pull()

      $stdout.puts "Create '#{branch_name}' branch in local"
      local.branch(branch_name).checkout()

      $stdout.puts "Exec bundle update..."
      $stdout.puts `bundle update`
      $stdout.puts "bundle update Done."
      $stdout.puts
      $stdout.puts "Commit as '#{commit_message}'"
      local.add(["Gemfile", "Gemfile.lock"])
      local.commit(commit_message)

      $stdout.print "Push '#{branch_name}' to origin ? (Ctrl-C for Cancel) :"
      $stdin.gets

      $stdout.puts "Push to remote"
      local.push("origin", branch_name)

      remote = Octokit::Client.new(access_token: @token)

      $stdout.print "Create PR ? (Ctrl-C for Cancel) :"
      $stdin.gets

      $stdout.puts "Create PR"
      pr = remote.create_pull_request(@repo_name, "master", branch_name, pr_title, @pr_body)

      $stdout.puts "#{pr[:html_url]} was created."

      $stdout.print "Exec compare linker ? (Ctrl-C for Cancel) :"
      $stdin.gets

      run_compare_linker(pr.number)

      $stdout.puts "All Done."
    end

    def run_compare_linker(pr_number)
      $stdout.puts "Exec compare_linker"
      compare_linker = CompareLinker.new(@repo_name, pr_number)
      compare_linker.formatter = CompareLinker::Formatter::Markdown.new
      comment = compare_linker.make_compare_links.to_a.join("\n")
      compare_linker.add_comment(@repo_name, pr_number, comment)
    end
  end
end
