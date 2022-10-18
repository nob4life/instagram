require 'rails_helper'

RSpec.describe PostsController, type: :controller do 
  let(:user) { create(:user)}
  
  before { sign_in user }
  
  
  describe '#index' do
    let(:owned_posts) { create_list(:post, 5, user: user) }

    subject { get :index }

    it 'renders template index' do 
      expect(subject).to render_template(:index)
    end

    it 'asigns user posts' do 
      subject
      expect(assigns(:posts)).to eq owned_posts
    end
  end

  describe '#show' do
    let!(:post) { create(:post, user: user) }
    let!(:comments) { create(:comment, post: post) }
    
    subject { get :show, params: {id: post.id } }
    
    it "renders show template" do
      expect(subject).to render_template :show
    end

    it "assigns correct post" do
      subject
      expect(assigns(:post)).to eq post
    end

    it "assigns correct comment" do
      subject
      expect(assigns(:comments)).to eq post.comments
    end
  end

  describe "#new" do 
    subject { get :new }

    it { is_expected.to render_template :new }

    it 'assigns a new post' do
      subject
      expect(assigns(:post)).to be_a_new(Post)
    end 
  end

  describe "#edit" do 
    let!(:post) { create(:post, user: user) }
    subject { get :edit, params: { id: post.id } }

    it { is_expected.to render_template :edit }

    it 'assigns a new post' do
      subject
      expect(assigns(:post)).to eq(post)
    end
  end


  describe '#create' do
    subject { process :create, method: :post, params: params }

    let(:params) { { post: attributes_for(:post, user: create(:user)) } }

    it 'creates a post' do
      expect { subject }.to change(Post, :count).by(1)
    end

    it 'redirect to post page' do
      subject
      expect(response).to redirect_to post_path(Post.last)
    end

    it 'assigns post to current user' do 
      subject
      expect(assigns(:post).user).to eq user
    end

    context 'when post params are invalid' do
      let(:params) { {post: { title: nil } } }
      
      it { is_expected.to render_template(:new) }

      it 'assigns record with errors' do
        subject
        expect(assigns(:post).errors).to_not be_empty
      end
    end
  end

  describe '#update' do
    subject { process :update, method: :patch, params: params }

    let(:post) { create(:post, user: user) }

    let(:params) { { id: post.id, post: attributes_for(:post, user: create(:user)) } }

    it 'update a post' do
      expect { subject }.to change { post.reload.title }.from(post.title).to(params[:post][:title])
    end

    it 'redirect to post page' do
      subject
      expect(response).to redirect_to post_path(Post.last)
    end

    context 'when post params are invalid' do
      let(:params) { {id: post.id, post: { title: nil } } }
      
      it { is_expected.to render_template(:edit) }

      it 'assigns record with errors' do
        subject
        expect(assigns(:post).errors).to_not be_empty
      end
    end
  end

  describe '#destroy' do 
    let!(:post) { create(:post, user: user) }

    subject { process :destroy, method: :delete, params: { id: post.id } }   
  
    it { is_expected.to redirect_to(:posts) }

    it 'deletes object from DB' do
      expect { subject }.to change(Post, :count).by(-1)
    end
  end
end