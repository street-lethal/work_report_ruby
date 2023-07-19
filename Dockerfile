FROM ruby:3-alpine3.17

RUN apk add curl
RUN apk update && apk add --no-cache build-base gcompat
RUN bundle config set --local path 'vendor/bundle'
COPY Gemfile* .
RUN bundle install
