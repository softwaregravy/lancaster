# script to prep empty gemset
gem install bundler
rake rails:update:bin
spring binstub --all
# didn't seem to need this one
# bundle binstub guard
