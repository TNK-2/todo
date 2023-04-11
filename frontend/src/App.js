import React, { useState } from 'react';
import LoginForm from './LoginForm';
import SignupForm from './SignupForm';

function App() {
  const [isLoginForm, setIsLoginForm] = useState(true);

  const handleSignupClick = () => {
    setIsLoginForm(false);
  };

  const handleLoginClick = () => {
    setIsLoginForm(true);
  };

  return (
    <div>
      <h1>Welcome to my app</h1>
      {isLoginForm ? (
        <>
          <LoginForm />
          <p>
            Don't have an account yet?{' '}
            <button onClick={handleSignupClick}>Signup</button>
          </p>
        </>
      ) : (
        <>
          <SignupForm />
          <p>
            Already have an account?{' '}
            <button onClick={handleLoginClick}>Login</button>
          </p>
        </>
      )}
    </div>
  );
}

export default App;
