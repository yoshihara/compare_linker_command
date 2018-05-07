# CompareLinkerCommand

次のことを自動で行うコマンドです。

1. bundle update
2. Create PR
3. Compare Linker

オプションでPR番号を指定することで、既存のPRに対してCompareLinkerのみ実行することができます。

## Installation

```console
$ gem install compare_linker_command
```

## Usage

### normal:

```consome
$ create_pr_with_compare_linker \
  --github-access-token YOUR_TOKEN \
  --repo-name ORG/REPOSITORY \
  --pr-body-file FILE_CONTAINING_PR_DESCRIPTION_CONTENT(optional)
```

### Compare Linker only:

```consome
$ create_pr_with_compare_linker \
  --github-access-token YOUR_TOKEN \
  --repo-name ORG/REPOSITORY \
  --pr-number TARGET_PR_NUMBER
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/compare_linker_command. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

