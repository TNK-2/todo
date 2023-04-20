FROM ruby:3.0.0-alpine

ENV LANG="C.UTF-8" \
    PACKAGES="curl-dev build-base alpine-sdk tzdata less ruby-dev nodejs" \
    APP_PATH="/app"

RUN apk update && \
    apk add --no-cache --update $PACKAGES

WORKDIR $APP_PATH

COPY Gemfile Gemfile.lock ./

RUN gem install bundler && \
    bundle install

# Create a new Rails application
RUN rails new . --force --database=sqlite3 --skip-bundle --skip-javascript --skip-git

COPY . ./

RUN bundle install

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
