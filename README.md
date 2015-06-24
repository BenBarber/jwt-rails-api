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

The default mailer views are setup using the [Mailgun transactional email templates](https://github.com/mailgun/transactional-email-templates) which are well tested and provide a good foundation for building your emails upon.

## License

The MIT License (MIT)

Copyright (c) 2015 Ben Barber

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.