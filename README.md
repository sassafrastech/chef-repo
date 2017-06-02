Sassafras Chef Recipes
======================

## Initial Setup

```
bundle install
berks install
cp nodes/sample_host.json nodes/mynode.json # Then fill in values
```

## Working with Vagrant

```
vagrant up --provider virtualbox
bundle exec knife solo prepare vagrant@localhost -i .vagrant/machines/default/virtualbox/private_key -p 2222
bundle exec knife solo cook vagrant@localhost -i .vagrant/machines/default/virtualbox/private_key -p 2222 nodes/mynode.json
```

## Working with Other Host

```
bundle exec knife solo prepare root@1.2.3.4
bundle exec knife solo cook root@1.2.3.4 nodes/mynode.json
```

## Testing with test-kitchen

### CI testing

Test-kitchen is a tool where you can automatically provision a server with these cookbooks and run the tests for them. The configuration in `.kitchen.yml` works with DigitalOcean.

First you need to obtain a DigitalOcean access token here: https://cloud.digitalocean.com/settings/applications. Then you need to find IDs of the SSH keys you added to your account: https://cloud.digitalocean.com/ssh_keys. You can obtain these IDs with the following command:

```
$ curl -X GET https://api.digitalocean.com/v2/account/keys -H "Authorization: Bearer <YOUR_DIGITALOCEAN_ACCESS TOKEN>"
```

When you've obtained both your access token and your key IDs you can run the tests like this:

```
$ export DIGITALOCEAN_ACCESS_TOKEN=<YOUR DIGITALOCEAN ACCESS TOKEN>
$ export DIGITALOCEAN_SSH_KEY_IDS=<YOUR DIGITALOCEAN SSH KEY ID>
$ bin/kitchen test
```

This command boots up a Droplet in your DigitalOcean account, provisions it with Chef, runs the tests and destroys the Droplet.

### Testing while developing

If you want to keep the Droplet running and do testing while making changes you can use the `kitchen verify` command instead of the `kitchen test` command to verify your changes:

```
$ bin/kitchen verify
```

## Resources and original authors

* This repo derived from https://github.com/intercity/chef-repo
* Most of the cookbooks that are used in this repository are installed from the [Opscode Community Cookbooks](http://community.opscode.com).
* The `rails` and `bluepill` configuration is based off the cookbooks by [jsierles](https://github.com/jsierles) at https://github.com/jsierles/chef_cookbooks
