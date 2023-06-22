# Use the official Flutter Docker image as the base image
FROM cirrusci/flutter

# Set the working directory inside the container
WORKDIR /book_store

# Copy the pubspec.yaml and pubspec.lock files to the container
COPY pubspec.yaml pubspec.lock ./

# Run Flutter pub get to fetch the app dependencies
RUN flutter pub get

# Copy the entire project to the container
COPY . .

# Install PHP and required extensions
RUN apt-get update && apt-get install -y php7.4-cli php7.4-mysql

# Set the command to run PHP server when the container starts
CMD ["php", "-S", "0.0.0.0:8080", "-t", "lib/server"]

