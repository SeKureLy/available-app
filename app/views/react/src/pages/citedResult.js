import React, { useState, useEffect } from "react";
import queryString from 'query-string'
import {
    BrowserRouter as Router,
    Switch,
    Route,
    Redirect,
    useLocation,
    Link
  } from "react-router-dom";
import { Button, Navbar, Nav, Form, Col, InputGroup, Row, FormControl, Container,Table } from 'react-bootstrap'
import logo from './../logo.svg';
import { baseUrl } from '../config'


function CitedResult(props) {
    const { search } = useLocation()
    const urlparams = queryString.parse(search)
    const [init, setinit] = useState(false)
    const [query, setQuery] = useState("")
    const [data, setData] = useState([])
    const [originPaper, setOrigin] = useState(null)
    const [Publication, setPublication] = useState(null)

    useEffect(() => {
        console.log(urlparams.query)
        if(!init && urlparams.query){
            reloadnewurl("",urlparams.query)
            setinit(true)
        }
        if(originPaper){
            GetPublicationInfo(true);
        }
    },[init,originPaper]);

    async function PostTest(keyword, loading=true) {
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
        if(loading) props.setLoading(true)
        try {
            fetch(baseUrl+'/search', requestOptions)
                .then(async response => {
                    let result = await response.json()
                    // console.log(result)
                    setData(result)
                    if(loading) props.setLoading(false)
                })
        } catch (e) {
            console.log(e.message)
        }

    }

    async function GetPublicationInfo(loading=true) {
        if(!originPaper){
            alert("originPaper con not be null!")
            return
        }
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ pid: originPaper.publication_id })
        };
        console.log(requestOptions)
        if(loading) props.setLoading(true)
        try {
            fetch(baseUrl+'/search/publication', requestOptions)
                .then(async response => {
                    let result = await response.json()
                    console.log(result)
                    setPublication(result[0])
                    if(loading) props.setLoading(false)
                })
        } catch (e) {
            console.log(e.message)
        }
    }


    async function reloadnewurl(url,eid){
        props.setLoading(true)
        await PostTest(eid,false)
        await GetPaperByEid(eid,false)
        props.setLoading(false)
        setQuery(eid)

    }

    async function GetPaperByEid(keyword, loading=true) {
        if(!keyword){
            alert("query con not be null!")
            return
        }
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ eid: keyword })
        };
        if(loading) props.setLoading(true)
        try {
            fetch(baseUrl+'/db/eid', requestOptions)
                .then(async response => {
                    let result = await response.json()
                    setOrigin(result)
                    console.log(result)
                    if(loading) props.setLoading(false)
                })
        } catch (e) {
            console.log(e.message)
        }
    }

    return (
        <>
            <br />
            <div className="App">
                <h1>Cited Papers of</h1>
            </div>
            <br />
            <Container>
                <Row>
                    <Col></Col>
                    {(originPaper)?
                    <Col xs={10}>
                        <h2><a href={originPaper.paper_link} target="_blank">{originPaper.title}</a></h2>
                    </Col>
                    :""}
                    <Col></Col>

                </Row>
                {(Publication)?
                    <>
                    <Row>
                    <Col></Col>
                    <Col><b>Citation Count</b> : {Publication.citation_count}</Col>
                    <Col><b>View Count</b> : {Publication.views_count}</Col>
                    <Col><b>publication year</b> : {Publication.publication_year}</Col>
                    <Col></Col>
                    </Row>
                    <Row>
                    <Col></Col>
                    <Col><b>Publication</b> : {Publication.source_title}</Col>
                    <Col><b>journal impact</b> : {Publication.journal_impact}</Col>
                    <Col></Col>
                    </Row>
                    </>
                :<></>}
                <Row>
                    <Table striped bordered hover size="sm" style={{ width: '85%', margin: "auto", marginTop: "1%"}}>
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
                                <td width="15%">{self.author}</td>
                                <td width="15%" overflow="hidden">{self.organization}</td>
                                <td width="10%"><a href={self.paper_link} target="_blank">Scopus link</a></td>
                                {/* <td width="10%">{self.citedby}<br/><a href={self.citedby_link} target="_blank">Detail</a></td> */}
                                <td width="10%">{self.citedby}</td>
                            </tr>)}
                        </tbody>
                    </Table>
                </Row>
            </Container>
        </>
    );
}

export default CitedResult;
