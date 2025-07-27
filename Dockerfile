# Use a minimal Alpine-based Ruby image
FROM ruby:3.3.0-alpine

# Set the working directory inside the container
WORKDIR /app

# Install Node.js and npm (using apk for Alpine Linux)
# These are needed for JavaScript assets and Tailwind CSS compilation
RUN apk add --no-cache nodejs npm

# Install Node.js, npm, and build tools (using apk for Alpine Linux)
RUN apk add --no-cache nodejs npm build-base libffi-dev

# Install Node.js, npm, build tools, and PostgreSQL development libraries
RUN apk add --no-cache nodejs npm build-base libffi-dev postgresql-dev

# Copy Gemfile and Gemfile.lock first to leverage Docker cache
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN bundle install --jobs $(nproc) --retry 3

# Copy the rest of your application code
COPY . .

# Optional: Precompile assets (usually for production, not for dev with Tailwind JIT)
# If your app relies heavily on sprockets precompilation, you might uncomment this for production builds.
# For development with Tailwind JIT, it's often not needed as Tailwind compiles on the fly.
# RUN bundle exec rails assets:precompile

# CMD and ENTRYPOINT are now managed by docker-compose.yml for web and css services
