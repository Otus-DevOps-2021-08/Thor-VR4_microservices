FROM ruby:2.2-alpine

ENV APP_HOME /app
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN apk --no-cache --update add build-base \
    && bundle install \
    && apk del build-base \
    && rm -rf /var/cache/apk/*

ADD . $APP_HOME

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments

CMD ["puma"]
