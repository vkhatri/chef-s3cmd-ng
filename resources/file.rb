#
# Cookbook Name:: s3cmd-ng
# Resource:: file
#
# Copyright 2015, Virender Khatri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

provides :s3cmd_file

actions :create, :delete

default_action :create

attribute :s3cfg_file,        :kind_of => String, :required => true, :default => nil
attribute :s3_url,            :kind_of => String, :required => true, :default => nil
attribute :s3cmd_options,     :kind_of => String, :default => nil
attribute :download_dir,      :kind_of => String, :default => node['s3cmd']['download_dir']
attribute :extract_dir,       :kind_of => String, :default => nil
attribute :verify_file,       :kind_of => String, :default => nil
attribute :user,              :kind_of => String, :default => node['s3cmd']['user']
attribute :group,             :kind_of => String, :default => node['s3cmd']['group']
attribute :umask,             :kind_of => [String, Integer], :default => node['s3cmd']['umask']
attribute :mode,              :kind_of => [String, Integer], :default => node['s3cmd']['mode']
attribute :extract,           :kind_of => [TrueClass, FalseClass], :default => false
attribute :force,             :kind_of => [TrueClass, FalseClass], :default => false
attribute :s3_binary,         :kind_of => String, :default => node['s3cmd']['binary']
