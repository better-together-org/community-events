FROM ruby:2.4.10

# Reset sources list to the archived Stretch repositories
RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian stretch main contrib non-free" > /etc/apt/sources.list \
    && echo "deb [check-valid-until=no] http://archive.debian.org/debian-security stretch/updates main contrib non-free" >> /etc/apt/sources.list

# Disable check for valid until and update the package list
RUN apt-get update -o Acquire::Check-Valid-Until=false -qq

# Install necessary packages
RUN apt-get install -y build-essential nodejs imagemagick libvips42 libmariadb-dev

# Create app directory
RUN mkdir /cev
WORKDIR /cev

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile /cev/Gemfile
COPY Gemfile.lock /cev/Gemfile.lock

# Install specific Bundler version, then bundle install
RUN gem install bundler -v 1.16.1

# Copy the main application
COPY . /cev
