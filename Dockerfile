FROM ruby:2.5

RUN bundle config --global frozen 1

EXPOSE 4567
WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["make"]
