require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do 
  let!(:luke) { create(:user, email: "luke@luke.com" ) }
  let!(:jude) { create(:user, email: "jude@jude.com" ) }

  describe "signed-in user can follow and unfollow other users" do
    before { sign_in luke }
    visit user_path(jude)
    click_on "Follow"
    expect(page).not_to have_button("Follow")
    expect(page).to have_button("Unfollow")

  end
end