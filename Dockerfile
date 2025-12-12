# STAGE 1: Build the binary
FROM golang:1.22-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the module files and download dependencies
COPY go.mod ./
RUN go mod download

# Copy the source code and build the application
COPY . .
RUN go build -o /hello-app

# STAGE 2: Create the small runtime image
FROM alpine:latest

# Copy only the compiled binary from the builder stage
COPY --from=builder /hello-app /hello-app

# Run the binary
CMD ["/hello-app"]
