# frozen_string_literal: true

server '54.95.190.19', user: 'app', roles: %w[app db web]
set :ssh_options, keys: '~/.ssh/id_rsa'
