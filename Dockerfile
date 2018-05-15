FROM owasp/zap2docker-weekly

USER zap
COPY mass-base* /zap/
RUN mkdir /zap/wrk
COPY mass-baseline-default.conf /zap/wrk/mass-baseline-default.conf

USER root
RUN chown zap /zap/mass-base*
