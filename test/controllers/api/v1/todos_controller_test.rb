class Api::V1::TodosControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = FactoryBot.create(:user)
    token = JsonWebToken.encode(user_id: @user.id)
    @headers = { 'Authorization' => "Bearer #{token}" }
    @todo = FactoryBot.create(:todo, user: @user)
  end

  test "should get index" do
    get api_v1_todos_url, headers: @headers
    assert_response :success
  end

  test "should get show" do
    get api_v1_todo_url(@todo), headers: @headers
    assert_response :success
  end

  test "should create todo" do
    assert_difference('Todo.count') do
      post api_v1_todos_url, headers: @headers, params: { todo: { title: "Test Todo" } }
    end
    assert_response :success
  end

  test "should update todo" do
    patch api_v1_todo_url(@todo), headers: @headers, params: { todo: { title: "Updated Todo", description: "updated description", completed: true } }
    assert_response :success
  end

  test "should destroy todo" do
    assert_difference('Todo.count', -1) do
      delete api_v1_todo_url(@todo.id), headers: @headers
    end
    assert_response :success
  end
end
