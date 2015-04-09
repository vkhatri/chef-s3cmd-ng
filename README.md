s3cmd-ng Cookbook
================

[![Build Status](https://travis-ci.org/vkhatri/chef-s3md-ng.svg?branch=master)](https://travis-ci.org/vkhatri/chef-s3cmd-ng)

This is a [Chef] cookbook to manage [s3cmd] using LWRP.


## Repository

https://github.com/vkhatri/chef-s3cmd-ng


## Dependencies

- apt
- yum-epel


## Recipes

- `s3cmd::default`      - default recipe (used for run_list)

- `s3cmd::install`      - install s3cmd


## Attributes

>> Cnofig Attributes are yet to be updated here. Kindly check attributes file for available attributes.

* `default['s3cmd']['setup_epel']` (default: `0.6.24`): whether to setup epel repository

* `default['s3cmd']['user']` (default: `nagios`): s3cmd default user, used in lwrp

* `default['s3cmd']['group']` (default: `nagios`): s3cmd default group, used in lwrp

* `default['s3cmd']['mode']` (default: `0750`): s3cmd file/directories permission

* `default['s3cmd']['umask']` (default: `0027`): s3cmd file/directories umask

* `default['s3cmd']['manage_sync_dir']` (default: `false`): whether to manage sync dir

* `default['s3cmd']['template_source']` (default: `5`): s3cmd resources template source file name for s3cfg

* `default['s3cmd']['template_cookbook']` (default: `15`): s3cmd resource template cookbook name

* `default['s3cmd']['download_dir']` (default: `/tmp`): 


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
