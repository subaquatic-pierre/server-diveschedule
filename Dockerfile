FROM python:3.8-slim-buster

RUN apt-get -y update \
    && apt-get install -y \
    apt-utils \
    gcc \
    libxml2 \
    libssl1.1 \
    libcairo2 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libgdk-pixbuf2.0-0 \
    shared-mime-info \
    mime-support \
    libpq-dev \
    python-dev \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ------
# Set build args
# ------
ARG DB_NAME
ARG DB_USER
ARG DB_PASSWORD
ARG DB_HOST
ARG DB_PORT
ARG EMAIL_URL
ARG SECRET_KEY
ARG DEBUG
ARG ALLOWED_HOSTS
ARG CSRF_TRUSTED_ORIGINS
ARG AWS_MEDIA_BUCKET_NAME
ARG AWS_STORAGE_BUCKET_NAME
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG DB_ENGINE

ARG SECRET_KEY

# ------
# Environment vars for application
# ------
# ARG COOL
ENV DB_NAME=$DB_NAME
ENV DB_USER=$DB_USER
ENV DB_PASSWORD=$DB_PASSWORD
ENV DB_HOST=$DB_HOST
ENV DB_PORT=$DB_PORT
ENV EMAIL_URL=$EMAIL_URL
ENV SECRET_KEY=$SECRET_KEY
ENV DEBUG=$DEBUG
ENV ALLOWED_HOSTS=${ALLOWED_HOSTS}
ENV CSRF_TRUSTED_ORIGINS=${CSRF_TRUSTED_ORIGINS}
ENV AWS_MEDIA_BUCKET_NAME=$AWS_MEDIA_BUCKET_NAME
ENV AWS_STORAGE_BUCKET_NAME=$AWS_STORAGE_BUCKET_NAME
ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
ENV DB_ENGINE=$DB_ENGINE
ENV CORS_ALLOW_ALL_ORIGINS=$CORS_ALLOW_ALL_ORIGINS
# ------

COPY . /app
WORKDIR /app
RUN pip3 install -r requirements.txt

CMD [ "./scripts/docker_entry_point.sh" ]