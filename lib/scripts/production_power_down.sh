heroku ps:scale web=1 clock=0 sms_worker=0 --remote production
heroku dyno:type free --remote production
