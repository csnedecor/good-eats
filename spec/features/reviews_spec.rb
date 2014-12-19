require 'rails_helper'

feature 'Reviews' do

  it 'creates a new review' do
    restaurant = Restaurant.create(name: "Fancy Restaurant", address: "3 Essex St", city: "Portola Valley", state: "CA", zip_code: "94028")
    visit restaurant_path(restaurant)
    click_on "Write a review"

    fill_in "review_rating", with: 5
    fill_in "review_body", with: "Fancy Restaurant pampered me with moist towlettes and
    warm milk. I will be going back."
    click_on "Submit Review"

    expect(page).to have_content "Successfully posted review"
    expect(page).to have_content restaurant.name
    expect(page).to have_content restaurant.description
    expect(page).to have_content "5"
    expect(page).to have_content "Fancy Restaurant pampered me with moist towlettes and
    warm milk. I will be going back."
  end

  it "displays all reviews on restaurant page" do
    restaurant = Restaurant.create(name: "Fancy Restaurant", address: "3 Essex St", city: "Portola Valley", state: "CA", zip_code: "94028")
    review1 = Review.create(rating: 4, body: "Awesome sauce", restaurant_id: restaurant.id)
    review2 = Review.create(rating: 1, body: "Hated it.", restaurant_id: restaurant.id)

    visit restaurant_path(restaurant)

    expect(page).to have_content "4"
    expect(page).to have_content "Awesome sauce"
    expect(page).to have_content "1"
    expect(page).to have_content "Hated it."
  end

  it "gives an error message if user doesn't supply required information" do
    restaurant = Restaurant.create(name: "Fancy Restaurant", address: "3 Essex St", city: "Portola Valley", state: "CA", zip_code: "94028")
    visit new_restaurant_review_path(restaurant)

    click_on "Submit Review"

    expect(page).to have_content "Rating can't be blank"
    expect(page).to have_content "Body can't be blank"
  end

  it "gives an error message if user supplies invalid information" do
    restaurant = Restaurant.create(name: "Fancy Restaurant", address: "3 Essex St", city: "Portola Valley", state: "CA", zip_code: "94028")
    visit new_restaurant_review_path(restaurant)

    fill_in "review_rating", with: "words"
    fill_in "review_body", with: "Fancy Restaurant pampered me with moist towlettes and
    warm milk. I will be going back."
    click_on "Submit Review"

    expect(page).to have_content "Rating must be between 1 and 5"
    expect(page).to have_content "Rating must be a whole number"
  end
end
