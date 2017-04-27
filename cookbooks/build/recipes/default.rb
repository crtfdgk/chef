#
# Cookbook:: build
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'build::install_python3'
include_recipe 'build::python_packages'
