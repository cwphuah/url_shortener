# URL Shortener

A simple URL shortener application built with Ruby on Rails. It is currently deployed on https://url-shortener-csai.onrender.com/.

## Table of Contents

- [Installation](#installation)
- [Dependencies](#dependencies)
- [Usage](#usage)
- [Development](#development)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)

## Installation

To get started with the application, follow these steps:

1. **Clone the repository**:
    ```sh
    git clone https://github.com/yourusername/url_shortener.git
    cd url_shortener
    ```
2. **Install dependencies**:
    ```sh
    bundle install
    ```
3. **Set up the database**:
    ```sh
    rails db:create
    rails db:migrate
    ```
4. **Start the Rails server**:
    ```sh
    rails server
    ```
5. **Visit the application**: Open your browser and go to `http://localhost:3000`.

## Dependencies

The project relies on the following dependencies:

- Ruby: Version specified in .ruby-version
- Rails: As the framework used to build this application
- PostgreSQL: For database management
- Bootstrap: For styling

## Usage

To use the URL shortener, follow these steps:
1. Create a new shortened URL:
    - Navigate to the homepage
    - Enter the original URL you want to shorten
    - Click "Shorten URL"
2. View the shortened URL:
    - All shortened URLS will be displayed on the homepage
    - Click on the shortened URL to be redirected to the original URL
3. View report:
    - Click on the "View Report" button to view usage of the shortened URLs

## Deployment

The application can be deployed to Render. Follow these steps to deploy:

1. **Create a Render account**:
   - Go to [Render](https://render.com) and sign up for an account.

2. **Create a new Web Service**:
   - Click on the "New" button and select "Web Service". You will need to create a Web Service and a PostgreSQL instance for this to work. Alternatively, you can configure the database.yml to use SQLite instead.

3. **Connect your GitHub repository**:
   - Connect your GitHub account to Render and select the `url_shortener` repository.

4. **Configure the service**:
   - Set the build and start commands:
     - **Build Command**: `bundle install; bundle exec rake assets:precompile; bundle exec rake assets:clean; rails db:migrate`
     - **Start Command**: `bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}`

5. **Set environment variables**:
   - Add the necessary environment variables, such as database credentials and the master key.

6. **Deploy the application**:
   - Click "Create Web Service" to deploy your application.

7. **Visit the deployed application**:
   - Open your browser and go to the URL provided by Render.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
