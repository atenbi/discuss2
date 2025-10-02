require "rails_helper"
require "ostruct"

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "validations" do
    it "validates presence of username" do
      user = build(:user, username: nil)
      expect(user).not_to be_valid
      expect(user.errors[:username]).to include("can't be blank")
    end

    it "validates uniqueness of username" do
      create(:user, username: "testuser")
      user = build(:user, username: "testuser")
      expect(user).not_to be_valid
      expect(user.errors[:username]).to include("has already been taken")
    end

    it "validates presence of email" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "validates uniqueness of email" do
      create(:user, email: "test@example.com")
      user = build(:user, email: "test@example.com")
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end
  end

  describe "associations" do
    it "has many topics" do
      topic1 = create(:topic, user: user)
      topic2 = create(:topic, user: user)
      expect(user.topics).to include(topic1, topic2)
    end

    it "has many posts" do
      post1 = create(:post, user: user)
      post2 = create(:post, user: user)
      expect(user.posts).to include(post1, post2)
    end
  end

  describe "enums" do
    it "defines state enum with correct values" do
      expect(User.states.keys).to match_array([ "registered", "semiactivated", "activated", "deactivated", "deleted" ])
    end

    it "has registered as default state" do
      new_user = User.new
      expect(new_user.state).to eq("registered")
    end

    it "allows state transitions" do
      user.update(state: "activated")
      expect(user.state).to eq("activated")

      user.update(state: "deactivated")
      expect(user.state).to eq("deactivated")
    end
  end


  describe "callbacks" do
    it "assigns avatar background color before create" do
      user = build(:user, avatar_bg_color: nil)
      user.save
      expect(user.avatar_bg_color).not_to be_nil
      expect(user.avatar_bg_color).to match(/^#[0-9A-F]{6}$/i)
    end

    it "assigns default role after create" do
      user = create(:user)
      expect(user.has_role?(:forum_user)).to be true
    end
  end

  describe "class methods" do
    describe ".generate_unique_username" do
      it "returns the base name when it's unique" do
        username = User.generate_unique_username("unique_user")
        expect(username).to eq("unique_user")
      end

      it "handles names with spaces by replacing them with underscores" do
        username = User.generate_unique_username("John Doe")
        expect(username).to eq("John_Doe")
      end

      it "removes special characters except underscores and hyphens" do
        username = User.generate_unique_username("user@#$%name!")
        expect(username).to eq("username")
      end

      it "handles multiple spaces by replacing with single underscores" do
        username = User.generate_unique_username("user   with   spaces")
        expect(username).to eq("user_with_spaces")
      end

      it "strips leading and trailing whitespace" do
        username = User.generate_unique_username("  trimmed_user  ")
        expect(username).to eq("trimmed_user")
      end

      it "returns 'user' for empty or nil input" do
        expect(User.generate_unique_username("")).to eq("user")
        expect(User.generate_unique_username(nil)).to eq("user")
        expect(User.generate_unique_username("   ")).to eq("user")
      end

      it "appends a number when username already exists" do
        create(:user, username: "existing_user")
        username = User.generate_unique_username("existing_user")
        expect(username).to eq("existing_user1")
      end

      it "increments the number until finding a unique username" do
        create(:user, username: "popular_name")
        create(:user, username: "popular_name1")
        create(:user, username: "popular_name2")

        username = User.generate_unique_username("popular_name")
        expect(username).to eq("popular_name3")
      end

      it "preserves underscores and hyphens in usernames" do
        username = User.generate_unique_username("user_name-test")
        expect(username).to eq("user_name-test")
      end

      it "handles usernames that are only special characters" do
        username = User.generate_unique_username("@#$%^&*()")
        expect(username).to eq("user")
      end
    end

    describe ".from_omniauth" do
      let(:auth_hash) do
        OpenStruct.new(
          uid: "12345",
          provider: "google_oauth2",
          info: OpenStruct.new(
            email: "test@example.com",
            name: "Test User"
          )
        )
      end

      context "when user does not exist" do
        it "creates a new user from omniauth data" do
          expect {
            User.from_omniauth(auth_hash)
          }.to change(User, :count).by(1)

          user = User.last
          expect(user.email).to eq("test@example.com")
          expect(user.username).to eq("Test_User")
          expect(user.provider).to eq("google_oauth2")
          expect(user.uid).to eq("12345")
        end

        it "generates unique username when name conflicts exist" do
          create(:user, username: "Test_User")

          user = User.from_omniauth(auth_hash)
          expect(user.username).to eq("Test_User1")
        end

        it "handles empty or missing name gracefully" do
          auth_hash.info.name = nil

          user = User.from_omniauth(auth_hash)
          expect(user.username).to eq("user")
        end
      end

      context "when user already exists" do
        it "returns existing user if already exists" do
          existing_user = create(:user, email: "test@example.com", provider: "google_oauth2", uid: "12345")

          expect {
            User.from_omniauth(auth_hash)
          }.not_to change(User, :count)

          expect(User.from_omniauth(auth_hash)).to eq(existing_user)
        end
      end
    end
  end
end
