FROM iron/ruby

ENV APP_NAME bank_ror

WORKDIR /usr/$APP_NAME

ADD . /usr/$APP_NAME

ENTRYPOINT ["rails", "s"]
