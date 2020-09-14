FROM ruby:2.7.1
# nodeのバージョン6以上であること
RUN curl -SL https://deb.nodesource.com/setup_12.x | bash && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -  && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt update -qq && apt install -y nodejs yarn mariadb-client

# 日本語対応
ENV LANG C.UTF-8

RUN mkdir /music-server
WORKDIR /music-server
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install
COPY . /music-server

# cp -rp /usr/local/bundle/gems vendor/bundle

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# サイトマップ生成
RUN bundle exec rails runner SitemapGenerator.generate_all

# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
