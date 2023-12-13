
# Project Overview

## This Rails application is designed to provide user authentication, CRUD operations for a User model, and dynamic management of custom fields associated with users. Users can sign up and sign in using traditional credentials or through social logins. The User model includes standard fields such as Name, Email, Password, Mobile number, and additional customizable custom fields.
 

## Features
``` Sign Up and Sign In with Social Login: ```

1. Easy Authentication:
   - Seamlessly sign up and sign in using your email and password.
   - Social login options are available for Github.
2. User CRUD Operations:
   - Create, Read, Update, and Delete operations for the User model.
   - Standard user fields include Name, Email, Password, and Mobile number.
3. Manage Custom Fields:
   - Define and manage custom fields to tailor your profile.
   - Customize your experience with fields like FieldName, InputType, and default value.

### Gems Used
1. Devise: Gem for flexible authentication solution for Rails.
2. Omniauth: Gem for standardizing multi-provider authentication utilizing OAuth.
3. omniauth-github: GitHub strategy for OmniAuth.
4. omniauth-rails_csrf_protection: Middleware to protect OmniAuth against CSRF attacks in Rails applications.
5. dotenv-rails: Gem to load environment variables from a .env file into ENV in development.

### Getting Started
1. Clone the repository: `git clone https://github.com/sandeepsaini98/infistack-task.git` 
2. Install dependencies: `bundle install`
3. Set up the database: `rails db:migrate`
4. Create a .env file in the project root and configure it with the required environment variables, especially for OAuth credentials.

5. Start the Rails server: `rails server`
6. Access the application at http://localhost:3000.

### Documentation:

- Devise:   https://github.com/heartcombo/devise
- Omniauth: https://github.com/omniauth/omniauth
- Medium:   https://medium.com/@kaileegray/adding-omniauth-to-rails-web-app-2491392787fa


### Contributing
Feel free to contribute by opening issues or creating pull requests. Please follow the project's coding standards and guidelines.

### Acknowledgments
Special thanks to the creators and contributors of Devise, Omniauth, and other gems used in this project.
