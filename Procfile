web:     bundle exec rails server -p $PORT
scheduler: VERBOSE=TRUE QUEUE=* bundle exec rake environment resque:scheduler
worker: VERBOSE=TRUE QUEUE=* bundle exec rake environment resque:work 