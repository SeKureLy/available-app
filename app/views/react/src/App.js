import React, { useState,useEffect} from "react";

import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link
} from "react-router-dom";
import {Button, Navbar,Nav} from 'react-bootstrap'
import logo from './logo.jpg';
import Search from './pages/search'
import CitationTree from './pages/citationTree'
import Beta from './pages/beta'
import CitedResult from './pages/citedResult'
import LoadingOverlay from 'react-loading-overlay';

import './App.css';

function App() {
  const [loading,setLoading] = useState(false)

  return (
    <>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossOrigin="anonymous"/>
    <Router> 
    <LoadingOverlay
            active={loading}
            spinner
            text='Loading...'
            >
      <div style={{ height: "100vh"}}>
      <Navbar bg="dark" variant="dark">
        <Navbar.Brand href="/">
          <img
            alt=""
            src={logo}
            width="30"
            height="30"
            className="d-inline-block align-top"
          />{' '}
          PaperDeep
        </Navbar.Brand>
        <Nav>
            <Nav.Item>
              <Link to="/" style={{color: "white"}}>Search</Link>
            </Nav.Item>
            &nbsp;&nbsp;
            <Nav.Item>
              <Link to="/citedResult" style={{color: "white"}}>CitedResult</Link>
            </Nav.Item>
            &nbsp;&nbsp;
            <Nav.Item>
              <Link to="/citationTree" style={{color: "white"}}>CitationTree</Link>
            </Nav.Item>
            &nbsp;&nbsp;
            <Nav.Item>
              <Link to="/beta" style={{color: "white"}}>Beta</Link>
            </Nav.Item>
        </Nav>
      </Navbar>

        {/* A <Switch> looks through its children <Route>s and
            renders the first one that matches the current URL. */}
        <Switch>
          <Route path="/citedResult">
            <CitedResult setLoading={setLoading}/>
          </Route>
          <Route path="/citationTree">
            <CitationTree setLoading={setLoading}/>
          </Route>
          <Route path="/beta">
            <Beta setLoading={setLoading}/>
          </Route>
          <Route path="/">
            <Search setLoading={setLoading}/>
          </Route>
        </Switch>
    </div>
      
      </LoadingOverlay>

    </Router>
    
    </>
  );
}

export default App;
