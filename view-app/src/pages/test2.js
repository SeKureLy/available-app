import React, { useState, useEffect } from "react";

import { Button, Navbar, Nav } from 'react-bootstrap'
import logo from './../logo.svg';

function Test2() {
  return (
    <>
      <div className="App">
        <h1>Test2</h1>
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </div>
    </>
  );
}

export default Test2;
