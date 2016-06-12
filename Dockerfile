FROM ruby:2.3

RUN apt-get update && \
    apt-get install -y libpq-dev postgresql-server-dev-9.4

RUN mkdir -p /usr/app/log

WORKDIR /usr/app

COPY Gemfile /usr/app/Gemfile
COPY Gemfile.lock /usr/app/Gemfile.lock
RUN bundle install

RUN cp /usr/share/zoneinfo/America/New_York /etc/localtime
COPY . /usr/app

CMD ["clockwork", "lib/schedule.rb"]

