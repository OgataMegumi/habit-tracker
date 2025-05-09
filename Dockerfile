FROM ruby:3.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /app

COPY ./app/Gemfile ./app/Gemfile.lock ./
RUN gem install bundler && bundle install

COPY ./app /app

CMD ["bash"]
