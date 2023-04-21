import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

function TodoList() {
  const [todos, setTodos] = useState([]);
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');
  const navigate = useNavigate();

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const response = await fetch('http://localhost:3000/api/v1/todos', {
        headers: {
          Authorization: `Bearer ${localStorage.getItem('token')}`,
        },
      });
      if (response && response.status === 401) {
        navigate('/login');
      }
      const data = await response.json();
      setTodos(data);
    } catch (error) {
      navigate('/login');
    }
  };

  const createTodo = async () => {
    try {
      const response = await fetch('http://localhost:3000/api/v1/todos', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${localStorage.getItem('token')}`,
        },
        body: JSON.stringify({ title, description, completed: false }),
      });
      if (response.ok) {
        setTitle('');
        setDescription('');
        fetchData();
      } else {
        alert('エラーが発生しました。もう一度お試しください。');
      }
    } catch (error) {
      alert('エラーが発生しました。もう一度お試しください。');
    }
  };

  return (
    <div>
      <h1>Todo List</h1>
      <div>
        <input
          type="text"
          placeholder="タイトル"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
        />
        <input
          type="text"
          placeholder="詳細"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
        />
        <button onClick={createTodo}>作成</button>
      </div>
      <ul>
        {todos.length === 0 ? (
          <p>Todoが存在しません。</p>
        ) : (
          todos.map((todo) => <li key={todo.id}>{todo.title} : {todo.description}</li>)
        )}
      </ul>
    </div>
  );
}

export default TodoList;
