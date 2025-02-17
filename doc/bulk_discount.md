# Bulk Discounts

## Table of Contents

- [Brief](#brief)
- [Database Schema](#database-schema)
- [Tools Used](#tools-used)
- [Contributors](#contributors)
- [Special Notes](#special-notes)
- [Learning Goals](#learning-goals)
- [Setup](#setup)
- [Rubric](#rubric)
- [User Stories](#user-stories)
- [Project Outline](#project-outline)
- [Extensions](#extensions)

## Brief

**Bulk Discounts** was a 1-week solo project designed as an extension to the *Little Esty Shop* project. Students had the option of building off of legacy code from the previous project or beginning with a starter repo from Turing. I opted to build off of Legacy code because I had a greater understanding of the setup than I would have with a different repository.

## Database Schema

[![Screen-Shot-2021-08-10-at-7-19-08-PM.png](https://i.postimg.cc/y8nq61HM/Screen-Shot-2021-08-10-at-7-19-08-PM.png)](https://postimg.cc/hXJZpqhs)

## Tools Used

| Development | Testing       | Gems          |
|   :----:    |    :----:     |    :----:     |
| Ruby 2.7.2  | RSpec         | SimpleCov     |
| Rails       |               | Pry           |
| HTML5       |               | Capybara      |
| CSS3        |               | ShouldaMatcher|
| VSCode      |               | Launchy       |
| Github      |               |               |

## Contributors

👤  **Matt Kragen** *Primary Contributor*
- [GitHub](https://github.com/matt-kragen)
- [LinkedIn](https://www.linkedin.com/in/mattkragen/)

👤  **Amanda McGuire** *Legacy Contributor*
- [GitHub](https://github.com/amcguire17)
- [LinkedIn](https://www.linkedin.com/in/amanda-e-mcguire/)

👤  **Carina Sweet** *Legacy Contributor*
- [GitHub](https://github.com/chsweet)
- [LinkedIn](https://www.linkedin.com/in/carina-h-sweet/)

👤  **Ezzedine Alwafai** *Legacy Contributor*
- [GitHub](https://github.com/ealwafai)
- [LinkedIn](https://www.linkedin.com/in/ezzedine-alwafai/)

## Special Notes

The GitHub API function was removed from the app for the purposes of testing new functions within the Bulk Discounts project requirements. This code is still available inside of the views folder and can be placed into `application.html.erb` as a header or footer to achieve its original purpose.

## Learning Goals
- Write migrations to create tables and relationships between tables
- Implement CRUD functionality for a resource using forms (form_tag or form_with), buttons, and links
- Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
- Use built-in ActiveRecord methods to join multiple tables of data, make calculations, and group data based on one or more attributes
- Write model tests that fully cover the data logic of the application
- Write feature tests that fully cover the functionality of the application

## Setup
This project is an extension of Little Esty Shop. Students have two options for setup:

If your Little Esty Shop project is complete, you can use it as a starting point for this project. If you are not the repo owner, fork the project to your account. If you are the repo owner, you can work off the repo without forking, just make sure your teammates have a chance to fork before pushing any commits to your repo
If your Little Esty Shop project is not complete, fork this repo as a starting point for this project.

## Rubric

|                          | Feature Completeness                                                              | Rails                                                                                                                                                                        | ActiveRecord                                                                                                                                                                                                              | Testing and Debugging                                                                                                                                                                                                                                        |
|--------------------------|-----------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 4: Exceptional           | One or more additional extension features complete.                               | Students implement strategies not discussed in class and can defend their design decisions (callbacks, scopes, application_helper view methods are created, etc)             | ActiveRecord helpers are utilized whenever possible. ActiveRecord is used in a clear and effective way to read/write data including the use of grouping, aggregating, and joining. Very little Ruby is used to process data.	 | Very clear Test-Driven Development. Test files are extremely well organized and nested. Students can point to multiple examples of edge case testing that are not included in the user stories.                                                              |
| 3: Passing               | Bulk discount is 100% complete                                                    | Students use the principles of MVC to effectively organize code with only 1 - 2 infractions. Routes and Actions mostly follow RESTful conventions                            | ActiveRecord helpers are utilized most of the time. ActiveRecord grouping, aggregating, and joining is used to process data at least once. Queries are functional and accurate.	                                          | 100% coverage for models. 98% coverage for features. Tests are well-written and meaningful. All tests passing. TDD Process is clear throughout commits. Some sad path and edge case testing. Tests utilize within blocks to target specific areas of a page. |
| 2: Passing with Concerns | One to two of the completion criteria for Bulk Discount features are not complete | Students utilize MVC to organize code, but cannot defend some of their design decisions. 3 or more infractions are present. RESTful conventions are only sometimes followed. | Ruby is used to process data that could use ActiveRecord instead. Some instances where ActiveRecord helpers are not utilized. Some queries not accurately implemented.	                                                   | Feature test coverage between 90% and 98%, or model test coverage below 100%, or tests are not meaningfully written or have an unclear objective, or tests do not utilize within blocks. Missing sad path or edge case testing.                              |
| 1: Failing               | More than two of the completion criteria for Bulk Discount feature is incomplete  | Students do not effectively organize code using MVC.	                                                                                                                        | Ruby is used to process data more often than ActiveRecord. Many cases where ActiveRecord helpers are not utilized.	                                                                                                       | Below 90% coverage for either features or models. TDD was not used.                                                                                                                                                                                          |



## Project Outline

### Bulk Discounts are subject to the following criteria:

- Bulk discounts should have a percentage discount as well as a quantity threshold
- Bulk discounts should belong to a Merchant
- A Bulk discount is eligible for all items that the merchant sells. Bulk discounts for one merchant should not affect items sold by another merchant
- Merchants can have multiple bulk discounts
  - If an item meets the quantity threshold for multiple bulk discounts, only the one with the greatest percentage discount should be applied
- Bulk discounts should apply on a per-item basis
  - If the quantity of an item ordered meets or exceeds the quantity threshold, then the percentage discount should apply to that item only. Other items that did not meet the quantity threshold will not be affected.
  - The quantities of items ordered cannot be added together to meet the quantity thresholds, e.g. a customer cannot order 1 of Item A and 1 of Item B to meet a quantity threshold of 2. They must order 2 or Item A and/or 2 of Item B

## Examples

### Example 1

- Merchant A has one Bulk Discount
  - Bulk Discount A is 20% off 10 items
- Invoice A includes two of Merchant A’s items
  - Item A is ordered in a quantity of 5
  - Item B is ordered in a quantity of 5

In this example, no bulk discounts should be applied.

### Example 2

- Merchant A has one Bulk Discount
  - Bulk Discount A is 20% off 10 items
- Invoice A includes two of Merchant A’s items
  - Item A is ordered in a quantity of 10
  - Item B is ordered in a quantity of 5

In this example, Item A should be discounted at 20% off. Item B should not be discounted.

### Example 3

- Merchant A has two Bulk Discounts
  - Bulk Discount A is 20% off 10 items
  - Bulk Discount B is 30% off 15 items
- Invoice A includes two of Merchant A’s items
  - Item A is ordered in a quantity of 12
  - Item B is ordered in a quantity of 15

In this example, Item A should discounted at 20% off, and Item B should discounted at 30% off.

### Example 4

- Merchant A has two Bulk Discounts
  - Bulk Discount A is 20% off 10 items
  - Bulk Discount B is 15% off 15 items
- Invoice A includes two of Merchant A’s items
  - Item A is ordered in a quantity of 12
  - Item B is ordered in a quantity of 15

In this example, Both Item A and Item B should discounted at 20% off. Additionally, there is no scenario where Bulk Discount B can ever be applied.

### Example 5

- Merchant A has two Bulk Discounts
  - Bulk Discount A is 20% off 10 items
  - Bulk Discount B is 30% off 15 items
- Merchant B has no Bulk Discounts
- Invoice A includes two of Merchant A’s items
  - Item A1 is ordered in a quantity of 12
  - Item A2 is ordered in a quantity of 15
- Invoice A also includes one of Merchant B’s items
  - Item B is ordered in a quantity of 15

In this example, Item A1 should discounted at 20% off, and Item A2 should discounted at 30% off. Item B should not be discounted.

## User Stories
### Merchant Bulk Discounts Index

```
As a merchant
When I visit my merchant dashboard
Then I see a link to view all my discounts
When I click this link
Then I am taken to my bulk discounts index page
Where I see all of my bulk discounts including their
percentage discount and quantity thresholds
And each bulk discount listed includes a link to its show page
[X] Complete
```
```
As a merchant
When I visit the discounts index page
I see a section with a header of "Upcoming Holidays"
In this section the name and date of the next 3 upcoming US holidays are listed.

Use the Next Public Holidays Endpoint in the [Nager.Date API](https://date.nager.at/swagger/index.html)
[ ] Complete
```
```
Merchant Bulk Discount Create

As a merchant
When I visit my bulk discounts index
Then I see a link to create a new discount
When I click this link
Then I am taken to a new page where I see a form to add a new bulk discount
When I fill in the form with valid data
Then I am redirected back to the bulk discount index
And I see my new bulk discount listed
[X] Complete
```
```
Merchant Bulk Discount Delete

As a merchant
When I visit my bulk discounts index
Then next to each bulk discount I see a link to delete it
When I click this link
Then I am redirected back to the bulk discounts index page
And I no longer see the discount listed
[X] Complete
```
```
Merchant Bulk Discount Show

As a merchant
When I visit my bulk discount show page
Then I see the bulk discount's quantity threshold and percentage discount
[X] Complete
```
```
Merchant Bulk Discount Edit

As a merchant
When I visit my bulk discount show page
Then I see a link to edit the bulk discount
When I click this link
Then I am taken to a new page with a form to edit the discount
And I see that the discounts current attributes are pre-poluated in the form
When I change any/all of the information and click submit
Then I am redirected to the bulk discount's show page
And I see that the discount's attributes have been updated
[X] Complete
```
```
Merchant Invoice Show Page: Total Revenue and Discounted Revenue

As a merchant
When I visit my merchant invoice show page
Then I see the total revenue for my merchant from this invoice (not including discounts)
And I see the total discounted revenue for my merchant from this invoice which includes bulk discounts in the calculation
[X] Complete
```
```
Merchant Invoice Show Page: Link to applied discounts

As a merchant
When I visit my merchant invoice show page
Next to each invoice item I see a link to the show page for the bulk discount that was applied (if any)
[X] Complete
```
```
Admin Invoice Show Page: Total Revenue and Discounted Revenue

As an admin
When I visit an admin invoice show page
Then I see the total revenue from this invoice (not including discounts)
And I see the total discounted revenue from this invoice which includes bulk discounts in the calculation
[X] Complete
```

## Extensions

- When an invoice is pending, a merchant should not be able to delete or edit a bulk discount that applies to any of their items on that invoice.
- When an Admin marks an invoice as “completed”, then the discount percentage should be stored on the invoice item record so that it can be referenced later
- Merchants should not be able to create/edit bulk discounts if they already have a discount in the system that would prevent the new discount from being applied (see example 4)
- Holiday Discount Extensions

```
Create a Holiday Discount

As a merchant,
when I visit the discounts index page,
In the Holiday Discounts section, I see a `create discount` button next to each of the 3 upcoming holidays.
When I click on the button I am taken to a new discount form that has the form fields auto populated with the following:

Discount name: <name of holiday> discount
Percentage Discount: 30
Quantity Threshold: 2

I can leave the information as is, or modify it before saving.
I should be redirected to the discounts index page where I see the newly created discount added to the list of discounts.
```
```
View a Holiday Discount

As a merchant (if I have created a holiday discount for a specific holiday),
when I visit the discount index page,
within the `Upcoming Holidays` section I should not see the button to 'create a discount' next to that holiday,
instead I should see a `view discount` link.
When I click the link I am taken to the discount show page for that holiday discount.
```
