require 'rails_helper'

RSpec.describe CommentsController, type: :controller do 
  let(:user) { create(:user)}
  
  before { sign_in user }
  
  
  describe "#new" do 
    let!(:post) { create(:post, user: user) }
    let!(:comments) { build(:comment, post: post) }
    it 'assigns a new comment' do
      expect(comments).to be_a_new(Comment)
    end 
  end

  describe '#create' do
    it "create 2 comments" do
      post = Post.create(title: "dsdsa", body: "dassda", user_id: user.id)
      comment1 = post.comments.create!(:body => "first comment")
      comment2 = post.comments.create!(:body => "second comment")
      expect(post.reload.comments).to eq([comment1, comment2])
    end
  end
  describe '#destroy' do
    it "destroy 2 comments" do
      post = Post.create(title: "dsdsa", body: "dassda", user_id: user.id)
      comment1 = post.comments.create!(:body => "first comment")
      comment2 = post.comments.create!(:body => "second comment")
      comment1.destroy
      comment2.destroy
      expect(post.reload.comments).to eq([])
    end
  end
end
