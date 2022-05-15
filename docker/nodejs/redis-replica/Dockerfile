FROM redis-base:1.0
LABEL maintainer="james@example.com"
ENV REFRESHED_AT=2016-06-01

ENTRYPOINT [ "redis-server", "--protected-mode no", "--logfile /var/log/redis/redis-replica.log", "--slaveof redis_primary 6379" ]