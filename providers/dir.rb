#
# Cookbook Name:: s3cmd-ng
# Provider:: dir
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

def whyrun_supported?
  true
end

action :create do
  directory "syncdir_#{new_resource.sync_dir}" do
    path new_resource.sync_dir
    user new_resource.user
    group new_resource.group
    mode new_resource.mode
    only_if { new_resource.manage_sync_dir }
  end

  d = execute "s3sync_#{new_resource.name}" do
    user new_resource.user
    group new_resource.group
    umask new_resource.umask
    command "#{new_resource.s3_binary} sync #{new_resource.s3_url} #{new_resource.sync_dir} --config #{new_resource.s3cfg_file} #{new_resource.s3cmd_options}"
    creates ::File.exist?(new_resource.sync_dir, new_resource.verify_file) if new_resource.verify_file
  end

  new_resource.updated_by_last_action(true) if d.updated?
end

action :delete do
  d = directory "syncdir_#{new_resource.sync_dir}" do
    path new_resource.sync_dir
    action :delete
  end

  new_resource.updated_by_last_action(true) if d.updated?
end
