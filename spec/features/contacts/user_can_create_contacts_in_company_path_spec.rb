require 'rails_helper'

describe 'when user visits new company contact page ' do
  scenario 'a user can create new contact by filling out a form' do
    company = Company.create!(name: 'Turing')

    visit company_path(company)
    name = 'Manoj'
    position = 'Hing Manager'
    email = 'manoj.email.com'

    fill_in 'contact[name]', with: name
    fill_in 'contact[position]', with: position
    fill_in 'contact[email]', with: email

    click_on 'Create Contact'

    expect(current_path).to eq(company_path(company))

    expect(page).to have_content(name)
    expect(page).to have_content(position)
    expect(page).to have_content(email)
  end
end
