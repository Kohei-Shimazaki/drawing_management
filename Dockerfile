FROM ruby:2.6.5
RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  postgresql-client \
  yarn
WORKDIR /drawing_mgt
COPY Gemfile Gemfile.lock /drawing_mgt/
RUN gem install bundler && bundle install
COPY . /drawing_mgt
