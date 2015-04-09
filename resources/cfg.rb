#
# Cookbook Name:: s3cmd-ng
# Resource:: cfg
#
# Copyright 2015, Virender Khatri
#
# Licensed under the Apache License, Version 2.0 (the "License")'
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

provides :s3cmd_cfg

actions :create, :delete

default_action :create

attribute :file,            :kind_of => String, :default => node['s3cmd']['file']
attribute :user,            :kind_of => String, :default => node['s3cmd']['user']
attribute :group,           :kind_of => String, :default => node['s3cmd']['group']
attribute :mode,            :kind_of => [String, Integer], :default => node['s3cmd']['mode']
attribute :source,          :kind_of => String, :default => node['s3cmd']['template_source']
attribute :cookbook,        :kind_of => String, :default => node['s3cmd']['template_cookbook']

attribute :databag,         :kind_of => String, :default => nil
attribute :databag_item,    :kind_of => String, :default => nil
attribute :databag_secret,  :kind_of => String, :default => nil

attribute :access_key, :kind_of => String, :default => node['s3cmd']['config']['access_key']
attribute :access_token, :kind_of => String, :default => node['s3cmd']['config']['access_token']
attribute :add_encoding_exts, :kind_of => String, :default => node['s3cmd']['config']['add_encoding_exts']
attribute :add_headers, :kind_of => String, :default => node['s3cmd']['config']['add_headers']
attribute :bucket_location, :kind_of => String, :default => node['s3cmd']['config']['bucket_location']
attribute :ca_certs_file, :kind_of => String, :default => node['s3cmd']['config']['ca_certs_file']
attribute :cache_file, :kind_of => String, :default => node['s3cmd']['config']['cache_file']
attribute :check_ssl_certificate, :kind_of => String, :default => node['s3cmd']['config']['check_ssl_certificate']
attribute :cloudfront_host, :kind_of => String, :default => node['s3cmd']['config']['cloudfront_host']
attribute :default_mime_type, :kind_of => String, :default => node['s3cmd']['config']['default_mime_type']
attribute :delay_updates, :kind_of => String, :default => node['s3cmd']['config']['delay_updates']
attribute :delete_after, :kind_of => String, :default => node['s3cmd']['config']['delete_after']
attribute :delete_after_fetch, :kind_of => String, :default => node['s3cmd']['config']['delete_after_fetch']
attribute :delete_removed, :kind_of => String, :default => node['s3cmd']['config']['delete_removed']
attribute :dry_run, :kind_of => String, :default => node['s3cmd']['config']['dry_run']
attribute :enable_multipart, :kind_of => String, :default => node['s3cmd']['config']['enable_multipart']
attribute :encoding, :kind_of => String, :default => node['s3cmd']['config']['encoding']
attribute :encrypt, :kind_of => String, :default => node['s3cmd']['config']['encrypt']
attribute :expiry_date, :kind_of => String, :default => node['s3cmd']['config']['expiry_date']
attribute :expiry_days, :kind_of => String, :default => node['s3cmd']['config']['expiry_days']
attribute :expiry_prefix, :kind_of => String, :default => node['s3cmd']['config']['expiry_prefix']
attribute :follow_symlinks, :kind_of => String, :default => node['s3cmd']['config']['follow_symlinks']
attribute :force, :kind_of => String, :default => node['s3cmd']['config']['force']
attribute :get_continue, :kind_of => String, :default => node['s3cmd']['config']['get_continue']
attribute :gpg_command, :kind_of => String, :default => node['s3cmd']['config']['gpg_command']
attribute :gpg_decrypt, :kind_of => String, :default => node['s3cmd']['config']['gpg_decrypt']
attribute :gpg_encrypt, :kind_of => String, :default => node['s3cmd']['config']['gpg_encrypt']
attribute :gpg_passphrase, :kind_of => String, :default => node['s3cmd']['config']['gpg_passphrase']
attribute :guess_mime_type, :kind_of => String, :default => node['s3cmd']['config']['guess_mime_type']
attribute :host_base, :kind_of => String, :default => node['s3cmd']['config']['host_base']
attribute :host_bucket, :kind_of => String, :default => node['s3cmd']['config']['host_bucket']
attribute :human_readable_sizes, :kind_of => String, :default => node['s3cmd']['config']['human_readable_sizes']
attribute :ignore_failed_copy, :kind_of => String, :default => node['s3cmd']['config']['ignore_failed_copy']
attribute :invalidate_default_index_on_cf, :kind_of => String, :default => node['s3cmd']['config']['invalidate_default_index_on_cf']
attribute :invalidate_default_index_root_on_cf, :kind_of => String, :default => node['s3cmd']['config']['invalidate_default_index_root_on_cf']
attribute :invalidate_on_cf, :kind_of => String, :default => node['s3cmd']['config']['invalidate_on_cf']
attribute :list_md5, :kind_of => String, :default => node['s3cmd']['config']['list_md5']
attribute :log_target_prefix, :kind_of => String, :default => node['s3cmd']['config']['log_target_prefix']
attribute :max_delete, :kind_of => Integer, :default => node['s3cmd']['config']['max_delete']
attribute :mime_type, :kind_of => String, :default => node['s3cmd']['config']['mime_type']
attribute :multipart_chunk_size_mb, :kind_of => Integer, :default => node['s3cmd']['config']['multipart_chunk_size_mb']
attribute :preserve_attrs, :kind_of => String, :default => node['s3cmd']['config']['preserve_attrs']
attribute :progress_meter, :kind_of => String, :default => node['s3cmd']['config']['progress_meter']
attribute :proxy_host, :kind_of => String, :default => node['s3cmd']['config']['proxy_host']
attribute :proxy_port, :kind_of => Integer, :default => node['s3cmd']['config']['proxy_port']
attribute :put_continue, :kind_of => String, :default => node['s3cmd']['config']['put_continue']
attribute :recursive, :kind_of => String, :default => node['s3cmd']['config']['recursive']
attribute :recv_chunk, :kind_of => Integer, :default => node['s3cmd']['config']['recv_chunk']
attribute :reduced_redundancy, :kind_of => String, :default => node['s3cmd']['config']['reduced_redundancy']
attribute :restore_days, :kind_of => Integer, :default => node['s3cmd']['config']['restore_days']
attribute :secret_key, :kind_of => String, :default => node['s3cmd']['config']['secret_key']
attribute :send_chunk, :kind_of => Integer, :default => node['s3cmd']['config']['send_chunk']
attribute :server_side_encryption, :kind_of => String, :default => node['s3cmd']['config']['server_side_encryption']
attribute :signature_v2, :kind_of => String, :default => node['s3cmd']['config']['signature_v2']
attribute :simpledb_host, :kind_of => String, :default => node['s3cmd']['config']['simpledb_host']
attribute :skip_existing, :kind_of => String, :default => node['s3cmd']['config']['skip_existing']
attribute :socket_timeout, :kind_of => Integer, :default => node['s3cmd']['config']['socket_timeout']
attribute :urlencoding_mode, :kind_of => String, :default => node['s3cmd']['config']['urlencoding_mode']
attribute :use_https, :kind_of => String, :default => node['s3cmd']['config']['use_https']
attribute :use_mime_magic, :kind_of => String, :default => node['s3cmd']['config']['use_mime_magic']
attribute :verbosity, :kind_of => String, :default => node['s3cmd']['config']['verbosity']
attribute :website_endpoint, :kind_of => String, :default => node['s3cmd']['config']['website_endpoint']
attribute :website_error, :kind_of => String, :default => node['s3cmd']['config']['website_error']
attribute :website_index, :kind_of => String, :default => node['s3cmd']['config']['website_index']
