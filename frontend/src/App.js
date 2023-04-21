import LoginForm from './LoginForm';
import SignupForm from './SignupForm';
import TodoList from './TodoList';
import React, { useState } from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';

function App() {
  const [token, setToken] = useState('');

  const handleLogout = () => {
    setToken('');
    localStorage.removeItem('token');
  };

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<TodoList handleLogout={handleLogout} />} />
        <Route path="/login" element={<LoginForm />} />
        <Route path="/signup" element={<SignupForm />} />
        <Route path="/todo-list" element={<TodoList handleLogout={handleLogout} />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
