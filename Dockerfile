FROM ruby:2.3

WORKDIR /usr/app

COPY Gemfile /usr/app/Gemfile
COPY Gemfile.lock /usr/app/Gemfile.lock
RUN bundle install

COPY . /usr/app
