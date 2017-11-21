# server-based syntax
# ======================
server "lyman-hall.dreamhost.com", user: "blythi", roles: [:app, :web, :db]

set :ssh_options, {
    forward_agent: true
}
