# DigiDocs-API:Microverse Final Capstone Project

> A Ruby On Rails API for booking and managing appointments with doctors.

## About This Project
DigiDocs is a backend service that houses and serves data for booking doctors' appointments. It is an API with its own endpoints that can be interfaced with. A client app can request details of a user, a users' list of appointments, a list of doctors and even send required details to book appointments with a doctor.

## Built With

- Ruby v3.0.0
- Ruby on Rails 6
- PostgreSQL
- RSpec

## Getting Started

To set up a local version of this project, a collection of steps have been put together to help guide you from installations to usage. Simply follow the guide below and you'll be up and running in no time.

### Set up Project

- Install [git](https://git-scm.com/downloads)
- Install [the Ruby programming language](https://ruby-doc.org/downloads/), if you haven't already.
- - Install [the Ruby on Rails MVC Framework](https://rubyonrails.org/), if you haven't already.
- Open Terminal
- Navigate to the preferred location/folder you want the app on your local machine. Use `cd <file-path>` for this.
- Run `git clone https://github.com/Moreneecoder/digidocs-api.git` to download the project source code.
- Now that you have a local copy of the project, navigate to the root of the project folder from your terminal.
- Run `bundle install` to install all dependencies in the Gemfile file.

### Set up Database
- This project uses [postgresql](https://www.postgresql.org/download/), so ensure you have that installed first
- Run the commands below to create and migrate database
```
   rails db:create
   rails db:reset
   rails db:migrate
```

## Running Tests
- Rubocop: This is a tool for checking code quality and ensuring they meet the requirements. Microverse provides a wonderful setup guide for [rubocop here](https://github.com/microverseinc/linters-config/tree/master/ror).

- RSpec: This is a tool for testing the effectiveness of the program's logic at every step. To set up RSpec:
  - run `gem install rspec` in your terminal. This should install rspec globally on your local machine.
  - run `rspec --version`. This should display your rspec version if successfully installed.
  - run `rspec` to see passing and failing tests.

### Usage

- Start server with: `rails server`

- Open [http://localhost:3000/](http://localhost:3000/) in your browser.

### Deployment

While there are a couple of cloud services for deployment, it is recommended to use Heroku for deploying this project. Follow this [heroku official deployment guide](https://devcenter.heroku.com/articles/getting-started-with-rails6#deploy-your-application-to-heroku) to deploy your application to heroku.

## Endpoints
_Base URL_: `https://gentle-taiga-27732.herokuapp.com/`

|Description|Method|Endpoint|
|:---|:---|:---|
|Log in to created account|POST|`api/v1/login`|
|Fetch users list|GET|`/api/v1/users`|
|Create a user|POST|`/api/v1/users`|
|Fetch a single user|GET|`/api/v1/users/:id`|
|Update a single user|PUT|`/api/v1/users/:id`|
|Fetch a user's appointments list|GET|`/api/v1/users/:user_id/appointments`|
|Create a user's appointment|POST|`/api/v1/users/:user_id/appointments`|
|Fetch a user's single appointment|GET|`/api/v1/users/:user_id/appointments/:id`|
|Update a user's single appointment|PUT|`/api/v1/users/:user_id/appointments/:id`|
|Fetch doctors list|GET|`/api/v1/doctors`|
|Create a doctor|POST|`/api/v1/doctors`|
|Fetch a single doctor|GET|`/api/v1/doctors/:id`|
|Update a single doctor|PUT|`/api/v1/doctors/:id`|
|Fetch a doctor's appointments list|GET|`/api/v1/doctors/:doctor_id/appointments`|
|Create a doctor's appointment|POST|`/api/v1/doctors/:doctor_id/appointments`|
|Fetch a doctor's single appointment|GET|`/api/v1/doctors/:doctor_id/appointments/:id`|
|Update a doctor's single appointment|PUT|`/api/v1/doctors/:doctor_id/appointments/:id`|

## Expected Response Status Codes

|Type|Symbol|HTTP status code|
|:---|:---|:---|
|Success|:ok|200|
|Success|:created|201|
|Client Error|:not_found|404|
|Client Error|:forbidden|403|
|Server Error|:unprocessable_entity|500|

## Authors

👤 **Bello Morenikeji Fuad**

- GitHub: [@moreenecoder](https://github.com/Moreneecoder)
- Twitter: [@mo_bello19](https://twitter.com/mo_bello19)
- LinkedIn: [Morenikeji Bello](https://linkedin.com/morenikeji-bello)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Moreneecoder/digidocs-api/issues).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

[Microverse](https://microverse.org)

## 📝 License

This project is [MIT](./LICENSE) licensed.
