# Use the n8n image as the base
FROM docker.n8n.io/n8nio/n8n

ARG PGPASSWORD
ARG PGHOST
ARG PGPORT
ARG PGDATABASE
ARG PGUSER
# Add an argument for custom modules
ARG CUSTOM_MODULES

ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_DATABASE=$PGDATABASE
ENV DB_POSTGRESDB_HOST=$PGHOST
ENV DB_POSTGRESDB_PORT=$PGPORT
ENV DB_POSTGRESDB_USER=$PGUSER
ENV DB_POSTGRESDB_PASSWORD=$PGPASSWORD
ENV N8N_LOG_LEVEL=debug
ENV N8N_ENCRYPTION_KEY=W0rAjnjtd6

# Install dependencies with root privileges
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3 \
    python3-pip \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install custom modules globally
RUN npm install -g $CUSTOM_MODULES

# Switch back to the node user
USER node

# Set working directory
WORKDIR /home/node/.n8n

CMD ["n8n", "worker"] 
