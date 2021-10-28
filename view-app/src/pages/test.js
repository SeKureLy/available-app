import React, { useState, useEffect } from "react";

import {
    BrowserRouter as Router,
    Switch,
    Route,
    Link
} from "react-router-dom";
import { Button, Navbar, Nav } from 'react-bootstrap'
import logo from './../logo.svg';

function Test() {
    const [test1, settest1] = useState(null)

    useEffect(() => {
        PostTest()
        GetTest()
    },[test1]);

    async function PostTest() {
        const requestOptions = {
            method: 'POST',
            headers: { 
                'Content-Type': 'application/json' },
            body: JSON.stringify({ test_url: 'github.com/qqq/www' })
        };
        fetch('http://localhost:9292/project', requestOptions)
            .then(async response => {
                let result = await response.text()
                console.log(result)
                // settest1(result)
            })
    }

    async function GetTest() {
        var result = await fetch('http://localhost:9292/project/www/qqq');
        var content = await result.text()
        console.log(content)
    }
    return (
        <>
            <div className="App">
                <h1>Test1</h1>
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

export default Test;
