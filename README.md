# Jungle

A mini e-commerce application built with Rails 6.1 and Ruby 3.1.1, used to work with improving a full-stack application with integration and E2E tests.
Before working with this project, I had no previous experience with using Ruby to build an actual app, so this was mostly to familiarize myself
with the Rails framework as well as improve myself by learning a new language.

## Improvements

The following features or improvements were implemented by [me](https://github.com/sachieko) specifically during this project:

1. The display of money for the cart, products, and orders were all standardized to $xx.xx rather than $xx. Fixed rounding cut off.
2. The display for a user visiting the cart without any items in it.
3. The sold out badge displaying on items that have no quantity and disabling the add to cart buttons were added.
4. The order details page was built, layout designed, and functionality implemented. The MVP required non-logged in users to still post orders without inputting an email, but the framework for restricting orders to only those who created them is set up.
5. Basic http authorization for admin pages added.
6. The about page was added, and new items were added to the nav bar such as signed in users, logout, etc
7. The ability for admins to create and add products to categories was implemented
8. The user authentication pages, process, and functionality with appropriate active record models.
9. Rspec tests were implemented for products and users, and any bugs caught by them were fixed.
10. Cypress tests for home page, product details, and adding to cart (along with checking if the item is in the cart) were implemented.

I have plans to also add the ability to send an email receipt to users who are registered, with details of their order listed for them along with their order id.

## Setup

1. Run `bundle install` to install dependencies. Note that ImageMagick / Libmagick may have issues installing and require your intervention.
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rails db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env vars
8. Run `bin/rails s -b 0.0.0.0` to start the server

## Testing

When Rspec is set up, you should be able to just use `bin/rspec` to run the existing tests. These should pass after you install with `bundle install`.

## Database

If Rails is complaining about authentication to the database, uncomment the user and password fields from `config/database.yml` in the development and test sections, and replace if necessary the user and password `development` to an existing database user.

## Stripe Testing

Use Credit Card #4111 1111 1111 1111 for testing success scenarios, yes this differs from what stripe is using but this has its own testing config.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

- Rails 6.1 [Rails Guide](http://guides.rubyonrails.org/v6.1/)
- Bootstrap 5
- PostgreSQL 9.x
- Stripe
- Imagemagick / Libmagick
