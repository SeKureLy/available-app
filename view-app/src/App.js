import React, { useState,useEffect} from "react";

import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link
} from "react-router-dom";
import {Button, Navbar,Nav} from 'react-bootstrap'
import logo from './logo.svg';
import Test1 from './pages/test'
import Test2 from './pages/test2'

import './App.css';

function App() {
  return (
    <>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossOrigin="anonymous"/>
    <Router> 
      <div>
      <Navbar bg="dark" variant="dark">
        <Navbar.Brand href="/">
          <img
            alt=""
            src={logo}
            width="30"
            height="30"
            className="d-inline-block align-top"
          />{' '}
          React Bootstrap
        </Navbar.Brand>
        <Nav>
            <Nav.Item>
              <Link to="/" style={{color: "white"}}>test</Link>
            </Nav.Item>
            &nbsp;&nbsp;
            <Nav.Item>
              <Link to="/test2" style={{color: "white"}}>test2</Link>
            </Nav.Item>
        </Nav>
      </Navbar>

        {/* A <Switch> looks through its children <Route>s and
            renders the first one that matches the current URL. */}
        <Switch>
          
          <Route path="/test2">
            <Test2/>
          </Route>
          <Route path="/">
            <Test1/>
          </Route>
        </Switch>
      </div>
    </Router>
    
    </>
  );
}

export default App;
