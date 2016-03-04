set :branch, :master

server "acidtango.com", user: "acid_tango_blog", roles: %w(web app db),
                        primary: true, port: 3333
