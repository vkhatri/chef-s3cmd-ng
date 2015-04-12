s3cmd-ng Cookbook
================

[![Build Status](https://travis-ci.org/vkhatri/chef-s3md-ng.svg?branch=master)](https://travis-ci.org/vkhatri/chef-s3cmd-ng)

This is a [Chef] cookbook to manage [s3cmd] using LWRP.

This cookbook allows to manage different s3cmd config files, sync a directory or sync a s3 file and it can be extracted to a directory.


## Repository

https://github.com/vkhatri/chef-s3cmd-ng


## Cookbook Dependencies

- apt
- yum-epel


## Recipes

- `s3cmd::default`      - default recipe (used for run_list)

- `s3cmd::install`      - install s3cmd


## Attributes

* `default['s3cmd']['setup_epel']` (default: `true`): whether to setup epel repository using cookbook yum-epel

* `default['s3cmd']['user']` (default: `root`): s3cmd default user, used in lwrp

* `default['s3cmd']['group']` (default: `root`): s3cmd default group, used in lwrp

* `default['s3cmd']['mode']` (default: `0750`): s3cmd file/directories permission

* `default['s3cmd']['umask']` (default: `0027`): s3cmd file/directories umask

* `default['s3cmd']['manage_sync_dir']` (default: `true`): whether to manage s3 sync dir, used in lwrp `dir`

* `default['s3cmd']['template_source']` (default: `s3cfg.conf.erb`): s3cmd config file template name for lwrp `s3cmd_cfg`

* `default['s3cmd']['template_cookbook']` (default: `15`): s3cmd config file template cookbook name for lwrp `s3cmd_cfg`

* `default['s3cmd']['download_dir']` (default: `/tmp`): s3 download location for lwrp `s3cmd_file`

* `default['s3cmd']['file']` (default: `nil`): s3cmd default config file location for lwrp `s3cmd_cfg`

* `default['s3cmd']['binary']` (default: `/usr/bin/s3cmd`): s3cmd binary command location, used by lwrp `s3cmd_dir` and `s3cmd_file`

* `default['s3cmd']['config']['S3CMD_OPTION']` (default: `S3CMD_OPTION_VALUE`): s3cmd config file attributes for lwrp `s3cmd_cfg`, check lwrp resource file for more details


## LWRP Resources

- `s3cmd_cfg`: create s3cmd config file
- `s3cmd_file`: s3 get file resource which also supports tar file extract
- `s3cmd_dir`: s3 sync directory resource


## LWRP s3cmd_cfg


LWRP `s3cmd_cfg` is used to create/delete s3cmd config file.

**Create a s3cmd config file**

    s3cmd_cfg "foo" do
      access_key "aws s3 access key"
      secret_key "aws s3 secret key"
      file "file location"
      user "user name"
      group "group name"
      region "aws region name, e.g. Singapore"
      option "value" ..
    end

**Create a s3cmd config file from a databag**

    s3cmd_cfg "foo" do
      file "file location"
      user "user name"
      group "group name"
      databag "databag name for aws access/secret key"
      databag_item "databag item name to load access_key & secret_key"
      databag_secret "encrypted databag secret if any"
      bucket_location "aws region name, e.g. Singapore"
      option "value" ..
    end


**Delete a s3cmd config file**

    s3cmd_cfg "foo" do
      action :delete
    end


**LWRP Options**

Parameters:

- *file (default: `node['s3cmd']['file']`)* - s3cmd config file location
- *user (default: `node['s3cmd']['user']`)* - s3cmd config file user
- *group (default: `node['s3cmd']['group']`)* - s3cmd config file group
- *mode (default: `node['s3cmd']['mode']`)* - s3cmd config file mode
- *template_source (default: `node['s3cmd']['template_source']`)* - s3cmd config file template source
- *template_cookbook (default: `node['s3cmd']['template_cookbook']`)* - s3cmd config file template cookbook
- *databag (default: `node['s3cmd']['databag']`)* - data bag for `access_key` and `secret_key`
- *databag_item (default: `node['s3cmd']['databag_item']`)* - data bag item
- *databag_secret (default: `node['s3cmd']['databag_secret']`)* - encrypted data bag secret


- *access_key (default: `node['s3cmd']['config']['access_key']`)* - s3cmd config access_key
- *secret_key (default: `node['s3cmd']['config']['secret_key']`)* - s3cmd config secret_key
- *bucket_location (default: `node['s3cmd']['config']['bucket_location']`)* - s3cmd config bucket_location / aws region
- *S3CMD_OPTION (default: `DEFAULT_VALUE`)* - s3cmd config option



## LWRP s3cmd_dir


LWRP `s3cmd_dir` is a wrapper for `s3cmd sync`.

**Create a s3cmd sync dir resource**

    s3cmd_dir "foo" do
      s3cfg_file "s3cmd config file"
      s3_url "s3 bucket url"
      user "user name"
      group "group name"
      s3cmd_options "--option value --option value .. if any"
      sync_dir "local dir to sync s3 url to"
      verify_file "verify file, raie exception is missing"
      mode "dirs / files mode"
      umask "user umask"
      manage_sync_dir "whether to manage local sync dir"
    end

**Delete a s3cmd sync dir**

    s3cmd_dir "foo" do
      action :delete
    end

**LWRP Options**

Parameters:

- *s3cfg_file (default: `nil`, required: `true`)* - s3cmd config file location
- *s3_url (default: `nil`, required: `true`)* - s3 bucket location to sync to `sync_dir`
- *s3cmd_options (default: `nil`)* - s3cmd options for `s3cmd sync`
- *sync_dir (default: `nil`, required: `true`)* - sync s3 url to this location
- *verify_file (default: `nil`)* - verify file / location in `sync_dir` after `s3cmd sync`, raise exception is missing
- *user (default: `node['s3cmd']['user']`)* - `sync_dir` file user ownership
- *group (default: `node['s3cmd']['group']`)* - `sync_dir`file group ownership
- *mode (default: `node['s3cmd']['mode']`)* - `sync_dir` file permissions
- *umask (default: `node['s3cmd']['umask']`)* - sync_dir user exec umask
- *manage_sync_dir (default: `node['s3cmd']['manage_sync_dir']`)* - whether to manage directory `sync_dir`
- *s3_binary (default: `node['s3cmd']['binary']`)* - s3cmd command location



## LWRP s3cmd_file


LWRP `s3cmd_dir` is a wrapper for `s3cmd sync`.

**Create a s3cmd sync dir resource**

    s3cmd_file "foo" do
      s3cfg_file "s3cmd config file"
      s3_url "s3 bucket file url"
      user "user name"
      group "group name"
      s3cmd_options "--option value --option value .. if any"
      download_dir "local dir to download s3 file"
      manage_download_dir true # whether to manage download_dir
      extract_dir "untar a tar file to this location"
      extract true # whether to extract a tar file
      mode "dirs / files mode"
      umask "user umask"
    end

**Delete a s3cmd file**

    s3cmd_file "foo" do
      s3_url "s3 bucket file url"
      download_dir "download location"
      extract_dir "directory location" # delete extract directory if specified
      action :delete
    end

**LWRP Options**

Parameters:

- *s3cfg_file (default: `nil`, required: `true`)* - s3cmd config file location
- *s3_url (default: `nil`, required: `true`)* - s3 file location for `s3cmd get`
- *s3cmd_options (default: `nil`)* - s3cmd options for `s3cmd get`
- *download_dir (default: `node['s3cmd']['download_dir']`)* - download s3 file here
- *extract (default: `false`)* - whether to extract a tar file
- *extract_dir (default: `node['s3cmd']['download_dir']`)* - extract s3 tar file here
- *user (default: `node['s3cmd']['user']`)* - files user ownership
- *group (default: `node['s3cmd']['group']`)* - files group ownership
- *mode (default: `node['s3cmd']['mode']`)* - files permissions
- *umask (default: `node['s3cmd']['umask']`)* - files user exec umask
- *manage_download_dir (default: `node['s3cmd']['manage_sync_dir']`)* - whether to manage directory `download_dir`
- *s3_binary (default: `node['s3cmd']['binary']`)* - s3cmd command location



## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests (`rake`), ensuring they all pass
6. Write new resource/attribute description to `README.md`
7. Write description about changes to PR
8. Submit a Pull Request using Github


## Copyright & License

Authors:: Virender Khatri and [Contributors]

<pre>
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
</pre>


[Chef]: https://www.chef.io/
[s3cmd]: https://github.com/s3tools/s3cmd
[Contributors]: https://github.com/vkhatri/chef-s3cmd/graphs/contributors
