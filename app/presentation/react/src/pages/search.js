import React, { useState, useEffect } from "react";
import queryString from 'query-string'
import {
    BrowserRouter as Router,
    Switch,
    Route,
    useLocation,
    Link
} from "react-router-dom";
import { Button, Alert, Nav, Form, Col, InputGroup, Row, FormControl, Container, Table } from 'react-bootstrap'
import { baseUrl } from '../config'



function Search(props) {
    const { search } = useLocation()
    const urlparams = queryString.parse(search)
    const [init, setinit] = useState(false)
    const [query, setQuery] = useState("")
    const [data, setData] = useState([])


    useEffect(() => {
        console.log(urlparams.query)
        console.log(process.env)
        if (urlparams.query) {
            PostTest(urlparams.query)
            setQuery(urlparams.query)
        }
    }, [init]);

    async function PostTest(keyword) {
        if (!keyword) {
            // alert("query con not be null!")
            props.alertFunction("query con not be null!")
            return
        }
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ keyword: keyword })
        };
        props.setLoading(true)
        try {
            fetch(baseUrl + '/api/v1/paper', requestOptions)
                .then(async response => {
                    let result = await response.json()
                    props.setLoading(false)
                    if (result.result == false) props.alertFunction(result.error)
                    else {
                        setData(result.paper)
                        props.alertSuccessFunction("Searching results as follows!")
                    }
                })
        } catch (e) {
            console.log(e.message)
        }
    }

    return (
        <>

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
                                    <Button variant="outline-primary" onClick={() => { PostTest(query) }}>Search</Button>
                                </Col>
                            </Row>
                        </Form>
                    </Col>
                    <Col></Col>

                </Row>
                <Row>
                    <Table striped bordered hover size="sm" style={{ width: '100%', margin: "auto", marginTop: "1%" }}>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Title</th>
                                <th>Lead Author</th>
                                <th>Organization</th>
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
                                <td width="10%">{self.author}</td>
                                <td width="15%" overflow="hidden">{self.organization}</td>
                                <td width="10%"><a href={self.paper_link} target="_blank">Scopus link</a></td>
                                {/* <td width="10%">{self.citedby}<br/><a href={self.citedby_link} target="_blank">Detail</a></td> */}
                                <td width="10%"><Link to={`/citedResult/?query=${self.eid}`}>{self.citedby}</Link></td>
                            </tr>)}
                        </tbody>
                    </Table>
                </Row>
            </Container>

        </>
    );
}

export default Search;
