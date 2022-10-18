require 'rails_helper'

RSpec.describe LikesController, type: :controller do 
  let(:user) { create(:user)}
  
  before { sign_in user }
  
  describe '#create' do
    it "add a like to a post" do
      post = Post.create(title: "dsdsa", body: "dassda", user_id: user.id)
      like = user.likes.create(post_id: post.id)
      expect(post.reload.likes).to eq([like])
    end
  end
  describe '#destroy' do
    it "remove a like from a post" do
      post = Post.create(title: "dsdsa", body: "dassda", user_id: user.id)
      like = user.likes.create(post_id: post.id)
      like.destroy
      expect(post.reload.likes).to eq([])
    end
  end
end
