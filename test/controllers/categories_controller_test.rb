require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

	def setup
		@category = Category.create(name: "sports2") # Create category
		@user = User.create(username: "John", email: "john@1.com", password: "password", admin: true)
		# create admin user
	end

	test "should get category index" do 
		get :index
		assert_response :success
	end

	test "should get category new" do
		session[:user_id] = @user.id # Sumulation that @user is logged_in
		get :new
		assert_response :success
	end

	test "should get category show" do
		get(:show, {'id' => @category.id})
		assert_response :success
	end

	test "Should redirect create when admin not logged in" do
		assert_no_difference 'Category.count' do
			post :create, category: {name: "sports"}
		end
		assert_redirected_to categories_path
	end
end
