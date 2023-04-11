import React, { useState } from 'react';

function LoginForm() {
  const [user, setUser] = useState({
    email: '',
    password: '',
  });

  const handleChange = (event) => {
    setUser({ ...user, [event.target.name]: event.target.value });
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
  
    const response = await fetch('http://localhost:3000/api/v1/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ "email": user.email, "password": user.password }),
    });
  
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
  
    const data = await response.json();
    console.log(data); // APIからのレスポンスをログに出力する
  };

  return (
    <form onSubmit={handleSubmit}>
      <label>
        Email:
        <input
          type="text"
          name="email"
          value={user.email}
          onChange={handleChange}
        />
      </label>
      <br />
      <label>
        Password:
        <input
          type="password"
          name="password"
          value={user.password}
          onChange={handleChange}
        />
      </label>
      <br />
      <input type="submit" value="Login" />
    </form>
  );
}

export default LoginForm;
