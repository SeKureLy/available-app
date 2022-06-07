import React, { useState, useEffect, useContext } from "react";
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
import { AuthContext } from "../contexts";

function Account(props) {
    const { search } = useLocation()
    const urlparams = queryString.parse(search)
    const [init, setinit] = useState(false)
    const [query, setQuery] = useState("")
    const { user, setUser } = useContext(AuthContext);
    const [ calendars, setCalendars ] = useState(null)
    const [ userInfo, setUserInfo ] = useState(null)


    useEffect(() => {
        if(user)displayAccount()
        // return 
    }, [user]);

    async function displayCalendars(){
        // todo:  call get calendars api
        const auth_token = 'Bearer ' + user.auth_token
        const requestOptions = {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': auth_token
            },
            credentials: 'include'
        };
        fetch(baseUrl+'/api/v1/calendars', requestOptions)
        .then(async response =>{
            let result = await response.json()
            console.log(result)

            if (response.status === 200){
                props.alertSuccessFunction(result.message)
                setCalendars(result)
            }
            else{
                props.alertFunction(`${result.message}`)
            }
        })
        .catch(error =>{
            console.log("+++++++++++++++++")
            props.alertFunction(error.message)
        })
    }

    async function displayAccount(){
        // todo:  call get calendars api
        // const auth_token = 'Bearer ' + user.auth_token
        const requestOptions = {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include'
        };
        fetch(baseUrl+'/api/v1/account', requestOptions)
        .then(async response =>{
            let result = await response.json()
            console.log(result)

            if (response.status === 200){
                // props.alertSuccessFunction(result.message)
                // setCalendars(result)
                setUserInfo(result)
            }
            else{
                props.alertFunction(`${result.message}`)
            }
        })
        .catch(error =>{
            console.log("+++++++++++++++++")
            props.alertFunction(error.message)
        })
    }

    return (
        <>

            <div className="App">
                <h1>Account Info</h1>
                {
                    (userInfo)?<>
                        <p>Hello, {user}</p>
                        <p>your email: {userInfo.email}</p>
                    </>:""
                }
                {
                    (calendars)?<p>calendars: {calendars}</p>:"empty calendars"
                }
            </div>
            <br />
            <Container>
                <Row>
                    <Col></Col>
                    <Col></Col>
                    <Col></Col>
                </Row>
            </Container>

        </>
    );
}

export default Account;
