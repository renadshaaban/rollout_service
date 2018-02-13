FROM ruby:2.4
WORKDIR /api
ADD Gemfile Gemfile.lock /api/
ADD vendor/cache/ /api/vendor/cache/
ADD . /api
RUN bundle install --deployment
EXPOSE 80