# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'openjdk11'

# Configure Neo4j repository
apt_repository 'add_neo4j_repo' do
  uri node['neo4j']['repository_url']
  components ['stable', node['neo4j']['version']]
  keyserver node['neo4j']['keyserver_url']
  distribution false
  trusted true
end

execute 'apt-get update'

# Install Neo4j
package 'neo4j' do
  action :install
end

service 'neo4j.service' do
  action [ :enable, :start ]
end

# Copy startup script
c2d_startup_script 'neo4j'
