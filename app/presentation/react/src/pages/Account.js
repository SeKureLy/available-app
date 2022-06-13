import React, { useState, useEffect, useContext } from "react";
import queryString from 'query-string'
import {
    BrowserRouter as Router,
    Switch,
    Route,
    useLocation,
    useHistory
} from "react-router-dom";
import { Button, Form, Modal, Container, Table } from 'react-bootstrap'
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
    const [CalendarInfo, setCalendarInfo] = useState(null)
    const [show, setShow] = useState(false);
    const handleClose = () => setShow(false);
    const [memberEmail, setMemberEmail] = useState("")

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
        fetch(baseUrl + `/api/v1/account/${user}`, requestOptions)
            .then(async response => {
                let result = await response.json()
                if (response.status === 200) {
                    setUserInfo(result)
                }
                else {
                    props.alertFunction(`${result.message}`)
                }
            })
            .catch(error => {
                props.alertFunction(error.message)
            })
    }

    function view(cid) {
        history.push(`/calendar?cid=${cid}`)
    }

    function handleShow(cid){
        const requestOptions = {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include'
        };
        fetch(baseUrl + `/api/v1/calendars/${cid}`, requestOptions)
            .then(async response => {
                let result = await response.json()
                setCalendarInfo(result)
            })
            .catch(error => {
                props.alertFunction(error.message)
            })
        setShow(true)
    }
    function deleteMember(id){
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ email: CalendarInfo.calendar.members[id].email}),
            credentials: 'include'
        };
        fetch(baseUrl+`/api/v1/calendars/${CalendarInfo.calendar.id}/members?action=remove`, requestOptions)
        .then(async response =>{
            let result = await response.json()
            if (response.status == 200){
                props.alertSuccessFunction(`delete member successfully`)
            }
            else{
                props.alertFunction(`${result.message}`)
            }
        })
        .catch(error =>{
          props.alertFunction("unknown error")
        })
        setShow(false)
    }

    function addMember(e){
        e.preventDefault()
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ email: memberEmail}),
            credentials: 'include'
        };

        fetch(baseUrl+`/api/v1/calendars/${CalendarInfo.calendar.id}/members?action=add`, requestOptions)
        .then(async response =>{
            let result = await response.json()
            if (response.status == 200){
                props.alertSuccessFunction(`add member successfully`)
            }
            else{
                props.alertFunction(`${result.message}`)
            }
        })
        .catch(error =>{
          props.alertFunction("unknown error")
        })
        setShow(false)
        setMemberEmail("")
    }

    return (
        <>
            <Modal
                size="lg"
                show={show}
                onHide={handleClose}
                backdrop="static"
                keyboard={false}
            >
                <Modal.Header closeButton>
                    <Modal.Title>Calendar Members</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                {
                    (CalendarInfo && CalendarInfo.calendar) ?
                        <Table>
                            <thead>
                                <tr>
                                    <th>account</th>
                                    <th>email</th>
                                    <th>type</th>
                                    <th>actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                <td>{CalendarInfo.calendar.owner.username}</td>
                                <td>{CalendarInfo.calendar.owner.email}</td>
                                <td>owner</td>
                                <td>
                                </td>
                                </tr>
                                {CalendarInfo.calendar.members.map((member, id) => {
                                    let c = member
                                    return (
                                        <tr key={id+1}>
                                            <td>{c.username}</td>
                                            <td>{c.email}</td>
                                            <td>member</td>
                                            <td>
                                                <Button variant="danger" onClick={() => deleteMember(id)}>delete</Button>{' '}
                                            </td>
                                        </tr>)
                                })}
                            </tbody>
                        </Table>
                        : "empty calendars"
                }
                </Modal.Body>
                <Modal.Footer>
                    <Form.Group>
                        <Form.Control type="email" value={memberEmail} onChange={(e) => { setMemberEmail(e.target.value) }} placeholder="New Member Email" />
                    </Form.Group>
                    <Button variant="primary" onClick={(e) => addMember(e)}>Add member</Button>
                    <Button variant="secondary" style={{float:'left'}} onClick={handleClose}>
                        Close
                    </Button>
                </Modal.Footer>
            </Modal>
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
                                                <Button variant="primary" onClick={() => { handleShow(c.id) }}>members</Button>{' '}
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
