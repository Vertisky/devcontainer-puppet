ARG BASE_VERSION=v1.2.1
ARG PDK_VERSION=3.0.0.0

FROM puppet/pdk:${PDK_VERSION} as pdk

FROM etma/devcontainer-kube:ubuntu-${BASE_VERSION}
ARG VERSION
ARG COMMIT
ARG BUILD_DATE
ARG BASE_VERSION
ARG PDK_VERSION

LABEL \
    org.opencontainers.image.title="DevContainer for Puppet" \
    org.opencontainers.image.description="Ubuntu Puppet image for dev containers." \
    org.opencontainers.image.url="https://github.com/vertisky/devcontainers-puppet" \
    org.opencontainers.image.documentation="https://github.com/vertisky/devcontainers-puppet" \
    org.opencontainers.image.source="https://github.com/vertisky/devcontainers-puppet" \
    org.opencontainers.image.vendor="vertisky" \
    org.opencontainers.image.authors="etma@vertisky.com" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.version=$VERSION \
    org.opencontainers.image.revision=$COMMIT \
    org.opencontainers.image.created=$BUILD_DATE

COPY --from=pdk /opt/puppetlabs /opt/puppetlabs

ENV PATH="${PATH}:/opt/puppetlabs/pdk/private/git/bin"
ENV PDK_DISABLE_ANALYTICS=true
ENV LANG=C.UTF-8

ENTRYPOINT ["/opt/puppetlabs/pdk/bin/pdk"]