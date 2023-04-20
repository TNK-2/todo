FROM ruby:3.0.0-alpine

RUN apk update && apk add build-base nodejs yarn postgresql-dev tzdata sqlite-dev

WORKDIR /app

COPY Gemfile* ./

RUN apk add --no-cache --virtual .build-deps \
        build-base \
        linux-headers \
 && gem install bundler -v '2.2.22' \
 && bundle install \
 && apk del .build-deps

# Install missing libraries
RUN apk add --no-cache sqlite-dev libc6-compat

COPY . .

CMD ["rails", "s", "-b", "0.0.0.0"]
