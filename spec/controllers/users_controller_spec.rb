require 'rails_helper'

RSpec.describe UsersController, type: :controller do 
  let(:user) { create(:user)}
  
  before { sign_in user }
  
  
  describe '#index' do
    let(:all_users) { User.all }

    subject { get :index }

    it 'renders template index' do 
      expect(subject).to render_template(:index)
    end

    it 'asigns all users' do 
      subject
      expect(assigns(:users)).to eq all_users
    end
  end

  describe '#show' do
    let!(:post) { create(:post, user: user) }
    #let!(:comments) { create(:comment, post: post) }
    
    subject { get :show, params: {id: user.id } }
    
    it "renders show template" do
      expect(subject).to render_template :show
    end

    it "assigns correct user" do
      subject
      expect(assigns(:user)).to eq user
    end
  end

  describe '#update' do
    subject { process :update, method: :patch, params: params }

    let(:user) { create(user: user) }

    let(:params) { photo: "index.jpg" }

    it 'update a post' do
      expect { subject }.to change { user.reload.photo }.from(user.photo).to(params[:photo])
    end

    # it 'redirect to post page' do
    #   subject
    #   expect(response).to redirect_to post_path(Post.last)
    # end

    # context 'when post params are invalid' do
    #   let(:params) { {id: post.id, post: { title: nil } } }
      
    #   it { is_expected.to render_template(:edit) }

    #   it 'assigns record with errors' do
    #     subject
    #     expect(assigns(:post).errors).to_not be_empty
    #   end
    # end
  end


  describe "#add_photo" do
    subject { get :add_photo }
  
    it { is_expected.to render_template :add_photo }

    it 'assigns add photo' do
      subject
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "#following" do
    it "folowing" do
      expect(assigns(:title)).to eq("Following")
    end
  end
end 