#
# Cookbook Name:: s3cmd-ng
# Provider:: file
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

def s3_file_name
  new_resource.s3_url.split('/').reverse[0]
end

def s3_file_path
  ::File.join(new_resource.download_dir, s3_file_name)
end

action :create do
  # file_name = new_resource.s3_url.split('/').reverse[0]
  fail "directory #{new_resource.download_dir} does not exists" unless ::File.exist?(new_resource.download_dir)
  # file_download_path = ::File.join(new_resource.download_dir, file_name)

  f = execute "s3file_#{s3_file_path}" do
    cwd new_resource.download_dir
    user new_resource.user
    group new_resource.group
    umask new_resource.umask
    command "#{new_resource.s3_binary} get #{new_resource.s3_url} --config #{new_resource.s3cfg_file} #{new_resource.s3cmd_options}"
    creates s3_file_path unless new_resource.force
    notifies :run, "execute[extract_s3_file_#{new_resource.name}]", :immediately if new_resource.extract
  end

  x = execute "extract_#{new_resource.name}" do
    user new_resource.user
    group new_resource.group
    umask new_resource.umask
    cwd new_resource.download_dir
    command "tar -xzf #{s3_file_name} -C #{new_resource.extract_dir}"
    creates ::File.join(new_resource.extract_dir, new_resource.verify_file) if new_resource.verify_file
    # extract only if extract directory is specified
    only_if { new_resource.extract }
    action :nothing
  end

  new_resource.updated_by_last_action(true) if f.updated? || x.updated?
end

action :delete do
  f = file "s3file_#{s3_file_path}" do
    path s3_file_path
    action :delete
  end
  d = directory "extract_#{new_resource.extract_dir}" do
    path new_resource.extract_dir
    action :delete
  end
  new_resource.updated_by_last_action(true) if f.updated? || d.updated?
end
