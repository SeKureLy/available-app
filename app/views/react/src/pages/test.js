import React, { useState, useEffect } from "react";

import { Button, Navbar, Nav, Form, Col, InputGroup, Row, FormControl, Container } from 'react-bootstrap'
import logo from './../logo.svg';

function Test() {
    const [test1, settest1] = useState(null)
    const [query, setQuery] = useState("")

    useEffect(() => {
        PostTest()
        GetTest()
    }, [test1]);

    async function PostTest() {
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
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

    async function Search() {
        console.log(query)
    }
    return (
        <>
            <br />
            <div className="App">
                <h1>Test Search</h1>
            </div>
            <br />
            <Container>
                <Row>
                    <Col></Col>
                    <Col xs={8}>
                        <Form>
                            <Row>
                            <Col sm="9">
                            <FormControl  type="text" placeholder="Search Study Fields" onChange={(e) => { setQuery(e.target.value) }} />
                            </Col>
                            <Col sm="3">
                            <Button variant="outline-primary" onClick={Search}>Search</Button>
                            </Col>
                            </Row>
                        </Form>
                    </Col>
                    <Col></Col>

                </Row>
            </Container>
        </>
    );
}

export default Test;
