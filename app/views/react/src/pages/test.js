import React, { useState, useEffect } from "react";
import queryString from 'query-string'
import { useLocation } from 'react-router-dom'
import { Button, Navbar, Nav, Form, Col, InputGroup, Row, FormControl, Container,Table } from 'react-bootstrap'
import logo from './../logo.svg';

function Test() {
    const { search } = useLocation()
    const urlparams = queryString.parse(search)
    const [init, setinit] = useState(false)
    const [query, setQuery] = useState("")
    const [data, setData] = useState([])


    useEffect(() => {
        console.log(urlparams.query)
        if(urlparams.query){
            PostTest(urlparams.query)
            setQuery(urlparams.query)
        }
    },[init]);

    async function PostTest(keyword) {
        if(!keyword){
            alert("query con not be null!")
            return
        }
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ keyword: keyword })
        };
        try {
            fetch('http://localhost:9292/project', requestOptions)
                .then(async response => {
                    let result = await response.json()
                    // console.log(result)
                    setData(result)
                })
        } catch (e) {
            console.log(e.message)
        }

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
                <h1>Paper Search</h1>
            </div>
            <br />
            <Container>
                <Row>
                    <Col></Col>
                    <Col xs={8}>
                        <Form>
                            <Row>
                                <Col sm="9">
                                    <FormControl type="text" placeholder="Search Study Fields" value={query} onChange={(e) => { setQuery(e.target.value) }} />
                                </Col>
                                <Col sm="3">
                                    <Button variant="outline-primary" onClick={() =>{PostTest(query)}}>Search</Button>
                                </Col>
                            </Row>
                        </Form>
                    </Col>
                    <Col></Col>

                </Row>
                <Row>
                    <Table striped bordered hover size="sm" style={{ width: '85%', margin: "auto", marginTop: "1%"}}>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Title</th>
                                <th>Lead Author</th>
                                {/* <th>Publication</th> */}
                                <th>Paper Link</th>
                                <th>Citedby</th>
                            </tr>
                        </thead>
                        <tbody >
                            {data.map((self, index) => <tr key={index}>
                                <td width="3%">{index}</td>
                                {/* name */}
                                <td>{self.title}</td>
                                {/* type */}
                                <td width="15%">{self.author}</td>
                                {/* <td width="3%" overflow="hidden">{self.publication_name}</td> */}
                                <td width="10%"><a href={self.paper_link} target="_blank">Scopus link</a></td>
                                <td width="10%">{self.citedby}<br/><a href={self.citedby_link} target="_blank">Detail</a></td>
                            </tr>)}
                        </tbody>
                    </Table>
                </Row>
            </Container>
        </>
    );
}

export default Test;
