FROM ruby:alpine
RUN apk update \
  && gem install httparty
COPY emojis.json /srv/emojis.json
COPY run.rb /srv/run.rb
WORKDIR /srv
CMD ruby ./run.rb
