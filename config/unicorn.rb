worker_processes 2
working_directory "/home/anime/text/current"

listen "/var/run/unicorn/unicorn_text.sock"
pid "/var/run/unicorn/unicorn_text.pid"

preload_app true