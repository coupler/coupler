# java integration
require 'java'
require 'jruby/core_ext'

# gems/stdlibs
require 'erb'
require 'delegate'
require 'singleton'
require 'logger'
require 'optparse'
require 'rack'
require 'rack/mime'   # This is an attempt to avoid NameError exceptions
require 'sinatra/base'
require 'rack/flash'
require 'sequel'
require 'sequel/extensions/migration'
require 'json'
require 'fastercsv'

# vendored stuff
require File.dirname(__FILE__) + "/coupler/config"

# thread_pool
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'vendor', 'ruby', 'thread_pool', 'lib')) # this won't hurt anything if we're inside a jar
require 'thread_pool'

# quartz
begin
  org.quartz.Job
rescue NameError
  Coupler::Config.require_vendor_libs('quartz')
end

# mysql embedded
begin
  com.mysql.management.MysqldResource
rescue NameError
  # load jar files only if necessary
  Coupler::Config.require_vendor_libs('mysql-connector-mxj')
end

# jdbc/mysql
begin
  com.mysql.jdbc.Driver
rescue NameError
  Coupler::Config.require_vendor_libs('mysql-connector-java')
end

# coupler libs
require File.dirname(__FILE__) + "/coupler/logger"
require File.dirname(__FILE__) + "/coupler/server"
require File.dirname(__FILE__) + "/coupler/database"
require File.dirname(__FILE__) + "/coupler/scheduler"
require File.dirname(__FILE__) + "/coupler/models"
require File.dirname(__FILE__) + "/coupler/comparators"
require File.dirname(__FILE__) + "/coupler/jobs"
require File.dirname(__FILE__) + "/coupler/score_set"
require File.dirname(__FILE__) + "/coupler/extensions"
require File.dirname(__FILE__) + "/coupler/helpers"
require File.dirname(__FILE__) + "/coupler/runner"
require File.dirname(__FILE__) + "/coupler/base"
