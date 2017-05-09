############## DOCKERFILE ####################
#
# This is our dockerfile -- it installs the dev/test groups, as well as
# utilities to make those groups run nicely. You'll build this one directly
# through docker-compose, e.g.:
#
# 1. $ docker-compose build
# 2. $ docker-compose up
#
# We use this image for local development.
#
FROM ruby:2.3.3-slim

# Optionally set a maintainer name to let people know who made this image.
MAINTAINER Andrew Ek <andrew.ek@paymentspring.com>

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - nodejs: Compile assets
# - libpq-dev: Use Postgres
# - git
#
# When installing, -qq suppresses prompts, and -y answers "yes" to prompts
RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev git-all --fix-missing --no-install-recommends

# Install plugins for Pronto to run
RUN apt-get install cmake -qq -y
RUN apt-get install pkg-config -qq -y

# Provide SSL 1.2 Support
RUN apt-get install --only-upgrade openssl -qq -y
RUN apt-get install --only-upgrade libssl-dev -qq -y

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV INSTALL_PATH /app
RUN mkdir -p $INSTALL_PATH

ENV RAILS_ENV production
ENV RACK_ENV production
# We should set the SECRET KEY BASE as an environment variable upon deployment
# ENV SECRET_KEY_BASE ed8025eb5b7bdf6194c5d8d059ac9fce39fa8d60f38fa0e03be42d6d17a2103c3f0bec6e8c60db189bd915e0da50ca8a200cdafe4fe20c0b4bdf8b734f4dbc5b

# This sets the context of where commands will be run in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

# Ensure gems are cached and only get updated when they change. This will
# drastically decrease build times when your gems do not change.
COPY Gemfile Gemfile

# Copy in the application code from your work station at the current directory
# over to the working directory.
COPY . .

# Install Dependencies
RUN bundle install --local --deployment --without test development

# The default command that gets ran will be to start the Puma server.
CMD bundle exec puma -C config/puma.rb
