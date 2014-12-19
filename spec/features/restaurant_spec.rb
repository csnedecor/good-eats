require 'rails_helper'

feature 'Restaurants' do
  # As a user
  # I want to see all of the restaurants
  # So I can decide which ones to learn more about
  #
  # Acceptance Criteria:
  # * I see a title to let me know I'm on the right page
  # * I see all of the restaurants listed

  it 'displays all the restaurants on homepage' do
    restaurant1 = Restaurant.create(name: "Dumpling King", address: "31 Harrison Ave", city: "Boston", state: "MA", zip_code: "02500")
    restaurant2 = Restaurant.create(name: "Other Restaurant", address: "3 Essex St", city: "Portola Valley", state: "CA", zip_code: "94028")

    visit '/'

    expect(page).to have_content "Good Eats"
    expect(page).to have_content "Dumpling King"
    expect(page).to have_content "Other Restaurant"
  end

  it 'displays all the restaurants on restaurants index page' do
    restaurant1 = Restaurant.create(name: "Dumpling King", address: "31 Harrison Ave", city: "Boston", state: "MA", zip_code: "02500")
    restaurant2 = Restaurant.create(name: "Other Restaurant", address: "3 Essex St", city: "Portola Valley", state: "CA", zip_code: "94028")

    visit '/restaurants'

    expect(page).to have_content "Good Eats"
    expect(page).to have_content "Dumpling King"
    expect(page).to have_content "Other Restaurant"
  end

  it 'creates a new restaurant' do
    visit '/restaurants/new'
    fill_in 'restaurant_name', with: "Dumpling King"
    fill_in "Address", with: "31 Harrison Ave"
    fill_in "City", with: "Boston"
    fill_in "State", with: "MA"
    fill_in "restaurant_zip_code", with: "02500"
    fill_in "Description", with: "Amazing dumplings, and cheap, too."
    fill_in "Category", with: "Chinese"
    click_on "Submit Restaurant"

    expect(page).to have_content "Successfully created restaurant"
    expect(page).to have_content "Dumpling King"
    expect(page).to have_content "31 Harrison Ave"
    expect(page).to have_content "Boston"
    expect(page).to have_content "MA"
    expect(page).to have_content "02500"
    expect(page).to have_content "Amazing dumplings, and cheap, too"
    expect(page).to have_content "Chinese"
  end

  it 'does not create new restaurant if user does not enter required information' do
    visit '/restaurants/new'

    click_on "Submit Restaurant"

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Address can't be blank"
    expect(page).to have_content "City can't be blank"
    expect(page).to have_content "State can't be blank"
    expect(page).to have_content "Zip code can't be blank"
  end
end
