FROM ruby:2.7.0
# nodeのバージョン6以上であること
RUN curl -SL https://deb.nodesource.com/setup_12.x | bash
# 最新のyarnを取得
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update -qq && apt install -y nodejs yarn

# 日本語対応
ENV LANG C.UTF-8

RUN mkdir /music-catalog
WORKDIR /music-catalog
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install
COPY . /music-catalog

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
