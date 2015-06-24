# A stateless Rails API server using JSON Web Tokens for authentication

[![Build Status](https://travis-ci.org/BenBarber/jwt-rails-api.svg?branch=master)](https://travis-ci.org/BenBarber/jwt-rails-api) [![Code Climate](https://codeclimate.com/github/BenBarber/jwt-rails-api/badges/gpa.svg)](https://codeclimate.com/github/BenBarber/jwt-rails-api) [![Test Coverage](https://codeclimate.com/github/BenBarber/jwt-rails-api/badges/coverage.svg)](https://codeclimate.com/github/BenBarber/jwt-rails-api/coverage)

JSON Web Tokens (JWT) are a standardized format for handling authentication between an API and a single page JS application (SPA). 

This application serves as a starting point or foundation for an API that needs to communicate with an SPA and have authentication readily in place.

## Features

* User sign-up
* User sign-in - authenticate with email and password to obtain a JWT access token
* User sign-out - expire any existing JWT access tokens
* Password reset - validated by token through email
* Access current_user within your controllers
* All issued JWT tokens contain a unique user signature

By signing all tokens with a signature unique to each user this gives you the ability to change the user signature which will then expire any active tokens for that user. You could also change the signature for all users which will then force everyone to be signed out.