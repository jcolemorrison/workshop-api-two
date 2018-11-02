FROM node:10.12.0-alpine

ENV AWS_CLI_VERSION 1.16.44

# all things needed for the AWS CLI
RUN apk --no-cache update && \
    apk --no-cache add python py-pip py-setuptools ca-certificates groff less && \
    pip --no-cache-dir install awscli==${AWS_CLI_VERSION}

RUN mkdir -p /usr/src/api

WORKDIR /usr/src/api

# Copy full installed app into the image
COPY . .

# Run any other set up
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
CMD ["node", "."]