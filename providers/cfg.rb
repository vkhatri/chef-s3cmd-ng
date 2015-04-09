#
# Cookbook Name:: s3cmd-ng
# Provider:: cfg
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

def user_home_cfg
  case new_resource.user
  when 'root'
    "/root/#{new_resource.name}"
  else
    node['etc']['passwd'][new_resource.user] ? "#{node['etc']['passwd'][new_resource.user]['dir']}/#{new_resource.name}" : "/home/#{new_resource.user}/#{new_resource.name}"
  end
end

def s3cfg_file
  file = new_resource.file || user_home_cfg
  fail "unable to determine file location for #{new_resource.user} s3cfg file resource #{new_resource.name}" unless file
  file
end

action :create do
  if new_resource.databag
    fail 'missing databag item attribute databag_item' unless new_resource.databag_item

    if new_resource.databag_secret
      secret = Chef::EncryptedDataBagItem.load_secret(new_resource.databag_secret)
      databag = data_bag_item(new_resource.databag, new_resource.databag_item, secret)
    else
      databag = data_bag_item(new_resource.databag, new_resource.databag_item)
    end

    fail "data bag or data bag key item does not exists, databag #{new_resource.databag} must have an item #{new_resource.key_name}" unless databag
    fail "databag #{new_resource.databag} item #{new_resource.databag_item} must have attribute access_key" unless databag['access_key']
    fail "databag #{new_resource.databag} item #{new_resource.databag_item} must have attribute secret_key" unless databag['secret_key']

    new_resource.access_key = databag['access_key']
    new_resource.secret_key = databag['secret_key']
  else
    fail "missing attribute access_key for resource #{new_resource.name}" unless new_resource.access_key
    fail "missing attribute secret_key for resource #{new_resource.name}" unless new_resource.secret_key
  end

  r = template s3cfg_file do
    path new_resource.file || s3cfg_file
    source new_resource.source
    cookbook new_resource.cookbook
    owner new_resource.user
    group new_resource.group
    mode new_resource.mode
    variables(:access_key   => new_resource.access_key,
              :access_token   => new_resource.access_token,
              :add_encoding_exts   => new_resource.add_encoding_exts,
              :add_headers   => new_resource.add_headers,
              :bucket_location   => new_resource.bucket_location,
              :ca_certs_file   => new_resource.ca_certs_file,
              :cache_file   => new_resource.cache_file,
              :check_ssl_certificate   => new_resource.check_ssl_certificate,
              :cloudfront_host   => new_resource.cloudfront_host,
              :default_mime_type   => new_resource.default_mime_type,
              :delay_updates   => new_resource.delay_updates,
              :delete_after   => new_resource.delete_after,
              :delete_after_fetch   => new_resource.delete_after_fetch,
              :delete_removed   => new_resource.delete_removed,
              :dry_run   => new_resource.dry_run,
              :enable_multipart   => new_resource.enable_multipart,
              :encoding   => new_resource.encoding,
              :encrypt   => new_resource.encrypt,
              :expiry_date   => new_resource.expiry_date,
              :expiry_days   => new_resource.expiry_days,
              :expiry_prefix   => new_resource.expiry_prefix,
              :follow_symlinks   => new_resource.follow_symlinks,
              :force   => new_resource.force,
              :get_continue   => new_resource.get_continue,
              :gpg_command   => new_resource.gpg_command,
              :gpg_decrypt   => new_resource.gpg_decrypt,
              :gpg_encrypt   => new_resource.gpg_encrypt,
              :gpg_passphrase   => new_resource.gpg_passphrase,
              :guess_mime_type   => new_resource.guess_mime_type,
              :host_base   => new_resource.host_base,
              :host_bucket   => new_resource.host_bucket,
              :human_readable_sizes   => new_resource.human_readable_sizes,
              :ignore_failed_copy   => new_resource.ignore_failed_copy,
              :invalidate_default_index_on_cf   => new_resource.invalidate_default_index_on_cf,
              :invalidate_default_index_root_on_cf   => new_resource.invalidate_default_index_root_on_cf,
              :invalidate_on_cf   => new_resource.invalidate_on_cf,
              :list_md5   => new_resource.list_md5,
              :log_target_prefix   => new_resource.log_target_prefix,
              :max_delete   => new_resource.max_delete,
              :mime_type   => new_resource.mime_type,
              :multipart_chunk_size_mb   => new_resource.multipart_chunk_size_mb,
              :preserve_attrs   => new_resource.preserve_attrs,
              :progress_meter   => new_resource.progress_meter,
              :proxy_host   => new_resource.proxy_host,
              :proxy_port   => new_resource.proxy_port,
              :put_continue   => new_resource.put_continue,
              :recursive   => new_resource.recursive,
              :recv_chunk   => new_resource.recv_chunk,
              :reduced_redundancy   => new_resource.reduced_redundancy,
              :restore_days   => new_resource.restore_days,
              :secret_key   => new_resource.secret_key,
              :send_chunk   => new_resource.send_chunk,
              :server_side_encryption   => new_resource.server_side_encryption,
              :signature_v2   => new_resource.signature_v2,
              :simpledb_host   => new_resource.simpledb_host,
              :skip_existing   => new_resource.skip_existing,
              :socket_timeout   => new_resource.socket_timeout,
              :urlencoding_mode   => new_resource.urlencoding_mode,
              :use_https   => new_resource.use_https,
              :use_mime_magic   => new_resource.use_mime_magic,
              :verbosity   => new_resource.verbosity,
              :website_endpoint   => new_resource.website_endpoint,
              :website_error   => new_resource.website_error,
              :website_index   => new_resource.website_index)
  end
  new_resource.updated_by_last_action(true) if r.updated?
end

action :delete do
  r = file s3cfg_file do
    action :delete
  end
  new_resource.updated_by_last_action(true) if r.updated?
end
