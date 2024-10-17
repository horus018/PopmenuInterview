# README

This project is intended to solve the levels of the interview challenge for Popmenu

# 🌟 Rails Project Setup and Implementation

- **🔧 Created and ran migrations for** `Menu` **and** `MenuItem`:
  - **🍽️ `Menu`** has a **🔑 name** and multiple **🍽️ `MenuItems`**
  - **🍽️ `MenuItem`** has a **🔑 name** and **💰 price**
  - Command: `rails generate model Menu name:string`
  - Command: `rails generate model MenuItem name:string price:decimal menu:references`
  
- **📦 Created and updated models** to define **🔗 relationships** and **✅ validations**.

- **🔄 Populated controllers** for **🍽️ Menu** and **🍽️ MenuItem**:
  - Command: `rails generate controller Menus`
  - Command: `rails generate controller MenuItems`
  
- **🛤️ Populated routes** to handle **RESTful actions**:
  - Added routes for **🍽️ Menu** and **🍽️ MenuItem** in `config/routes.rb`.

- **🔍 Installed RSpec for testing:**
  - Command: `bundle exec rails generate rspec:install`
  - Command: `bundle exec rspec` to run tests.

- **⚙️ Ran database setup and migrations:**
  - Command: `bundle exec rails db:create` (for creating the **🗄️ database**)
  - Command: `bundle exec rails db:migrate` (for applying **📜 migrations**)

- **🔄 Ran migrations for the test database:**
  - Command: `RAILS_ENV=test bundle exec rails db:migrate`

- **📦 Installed dependencies:**
  - Command: `bundle install`