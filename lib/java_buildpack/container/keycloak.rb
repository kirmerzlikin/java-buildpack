# Cloud Foundry Java Buildpack
# Copyright 2013-2017 the original author or authors.
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

require 'java_buildpack/container'
require 'java_buildpack/logging/logger_factory'
require 'java_buildpack/util/class_file_utils'
require 'java_buildpack/util/file_enumerable'
require 'java_buildpack/util/qualify_path'
require 'java_buildpack/util/ratpack_utils'
require 'pathname'
require 'set'
require 'tmpdir'

module JavaBuildpack
  module Container

    class Keycloak < JavaBuildpack::Component::BaseComponent
      include JavaBuildpack::Util
      
      # Creates an instance
      #
      # @param [Hash] context a collection of utilities used the component
      def initialize(context)
        @logger        = JavaBuildpack::Logging::LoggerFactory.instance.get_logger Keycloak
        super(context)
      end

      def detect
        supports? ? 'Keycloak detected. OK' : nil
      end

      def supports?
        true
      end

      # (see JavaBuildpack::Component::BaseComponent#compile)
      def compile; end

      # (see JavaBuildpack::Component::BaseComponent#release)
      def release
        @droplet.java_opts.add_system_property 'jboss.http.port', '$PORT'
        @droplet.java_opts.add_system_property 'java.net.preferIPv4Stack', 'true'
        @droplet.java_opts.add_system_property 'io.undertow.disable-file-system-watcher', 'true'

        [
          @droplet.environment_variables.as_env_vars,
          @droplet.java_home.as_env_var,
          @droplet.java_opts.as_env_var,
          'exec',
          qualify_path(@droplet.root + 'bin/standalone.sh', @droplet.root),
          '--server-config',
          'standalone-ha.xml',
          '-b',
          '0.0.0.0'
        ].flatten.compact.join(' ')
      end

    end

  end
end
