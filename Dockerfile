FROM ruby:3.0.1

RUN apt-get update -qq \
    && apt-get install -y nodejs

RUN mkdir /myapp
WORKDIR /myapp
COPY . /myapp

RUN bundle install
ENV RAILS_ENV=production

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3001

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
