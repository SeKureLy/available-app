import React, { useState, useEffect, useContext } from "react";
import queryString from 'query-string'
import {
    BrowserRouter as Router,
    Switch,
    Route,
    useLocation,
    useHistory
} from "react-router-dom";
import { Button, Alert, Nav, Form, Col, InputGroup, Row, FormControl, Container, Table } from 'react-bootstrap'
import { baseUrl } from '../config'
import { AuthContext } from "../contexts";

function Account(props) {
    const { search } = useLocation()
    const urlparams = queryString.parse(search)
    const history = useHistory();
    const [init, setinit] = useState(false)
    const [query, setQuery] = useState("")
    const { user, setUser } = useContext(AuthContext);
    const [calendars, setCalendars] = useState(null)
    const [userInfo, setUserInfo] = useState(null)


    useEffect(() => {
        if (user) {
            if (!userInfo) displayAccount()
            if (!calendars) displayCalendars()
        }
    }, [user]);

    async function displayCalendars() {
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
        fetch(baseUrl + '/api/v1/calendars', requestOptions)
            .then(async response => {
                let result = await response.json()

                if (response.status === 200) {
                    props.alertSuccessFunction(result.message)
                    setCalendars(result.calendars)
                }
                else {
                    props.alertFunction(`${result.message}`)
                }
            })
            .catch(error => {
                console.log("+++++++++++++++++")
                props.alertFunction(error.message)
            })
    }

    async function displayAccount() {
        // todo:  call get calendars api
        // const auth_token = 'Bearer ' + user.auth_token
        const requestOptions = {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include'
        };
        fetch(baseUrl + '/api/v1/account', requestOptions)
            .then(async response => {
                let result = await response.json()
                console.log(result)

                if (response.status === 200) {
                    setUserInfo(result)
                }
                else {
                    props.alertFunction(`${result.message}`)
                }
            })
            .catch(error => {
                console.log("+++++++++++++++++")
                props.alertFunction(error.message)
            })
    }

    function view(cid) {
        history.push(`/calendar?cid=${cid}`)
    }

    return (
        <>

            <div className="App">
                <h1>Account Info</h1>
                {
                    (userInfo) ? <>
                        <p>Hello, {user}</p>
                        <p>your email: {userInfo.email}</p>
                        <p>API key: {userInfo.auth_token}</p>
                    </> : ""
                }
            </div>
            <br />
            <Container>
                {
                    (calendars) ?
                        <Table>
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th> calendar name</th>
                                    <th>actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                {calendars.map((cal, id) => {
                                    let c = cal.data.attributes
                                    return (
                                        <tr key={id}>
                                            <td>{c.id}</td>
                                            <td>{c.title}</td>
                                            <td>
                                                <Button variant="primary">members</Button>{' '}
                                                <Button variant="secondary" onClick={() => { view(c.id) }}>view</Button>{' '}
                                                <Button variant="danger" onClick={() => { }}>delete</Button>{' '}
                                            </td>
                                        </tr>)
                                })}
                            </tbody>
                        </Table>
                        : "empty calendars"
                }
            </Container>

        </>
    );
}

export default Account;
