FROM ruby:3.2-slim

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    libpq-dev \
    libyaml-dev \
    nodejs \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

WORKDIR /app

COPY Gemfile ./
RUN bundle install

COPY . .

RUN bundle exec rails assets:precompile RAILS_ENV=production SECRET_KEY_BASE=placeholder

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
