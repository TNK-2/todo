require 'rails_helper'

RSpec.describe "Api::V1::Todos", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:todos) { FactoryBot.create_list(:todo, 10, user: user) }
  let(:todo_id) { todos.first.id }
  let(:headers) { { 'Authorization' => JsonWebToken.encode(user_id: user.id) } }

  describe "GET /api/v1/todos" do
    before { get "/api/v1/todos", headers: headers }

    it "returns todos" do
      expect(response.body).not_to be_empty
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/todos/:id" do
    before { get "/api/v1/todos/#{todo_id}", headers: headers }

    context "when the record exists" do
      it "returns the todo" do
        expect(response.body).not_to be_empty
        expect(JSON.parse(response.body)['id']).to eq(todo_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:todo_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
        end
        it "returns a not found message" do
          expect(response.body).to match(/Couldn't find Todo/)
        end
      end
    end

  describe "POST /api/v1/todos" do
    let(:valid_attributes) { { title: "New Todo", description: "New Description", completed: false } }

    context "when the request is valid" do
      before { post "/api/v1/todos", params: { todo: valid_attributes }, headers: headers }
    
      it "creates a todo" do
        expect(JSON.parse(response.body)['title']).to eq('New Todo')
      end
    
      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
    
    context "when the request is invalid" do
      before { post "/api/v1/todos", params: { todo: { title: "New Todo" } }, headers: headers }
    
      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    
      it "returns a validation failure message" do
        expect(response.body).to match(/Validation failed: Description can't be blank, Completed can't be blank/)
      end
    end
  end

  describe "PUT /api/v1/todos/:id" do
    let(:valid_attributes) { { title: "Updated Todo" } }

    context "when the record exists" do
      before { put "/api/v1/todos/#{todo_id}", params: { todo: valid_attributes }, headers: headers }
    
      it "updates the record" do
        expect(response.body).to be_empty
      end
    
      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe "DELETE /api/v1/todos/:id" do
    before { delete "/api/v1/todos/#{todo_id}", headers: headers }
    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end