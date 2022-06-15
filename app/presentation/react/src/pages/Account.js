import React, { useState, useEffect, useContext } from "react";
import queryString from 'query-string'
import {
    BrowserRouter as Router,
    Switch,
    Route,
    useLocation,
    useHistory
} from "react-router-dom";
import { Button, Form, Modal, Container, Table, Row, Col } from 'react-bootstrap'
import { baseUrl } from '../config'
import { AuthContext } from "../contexts";

function Account(props) {
    const { search } = useLocation()
    const urlparams = queryString.parse(search)
    const history = useHistory();
    const [init, setinit] = useState(false)
    const [query, setQuery] = useState("")
    const { user, setUser } = useContext(AuthContext);
    const {calendars, setCalendars} = useContext(AuthContext)
    const { userInfo, setUserInfo } = useContext(AuthContext);
    const [CalendarInfo, setCalendarInfo] = useState(null)
    const [show, setShow] = useState(false);
    const handleClose = () => setShow(false);
    const [memberEmail, setMemberEmail] = useState("")
    const [calendarTitle, setCalendarTitle] = useState("")
    const [guestLink, setGuestLink] = useState("")

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

    function view(calendar) {
        if(calendar.type == 0)history.push(`/calendar?cid=${calendar.id}`)
        else{
            let path = calendar.guesturl.split('calendar?')[1]
            history.push(`/calendar?${path}`)
        }
    }

    async function getRequest(url, api_key= null){
        var requestOptions = {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include'
        };
        if(api_key){
            requestOptions.headers['Authorization'] = `Bearer ${api_key}`
        }
        try{
            let response = await fetch(url, requestOptions)
            let result = await response.json()
            return result
        }
        catch(error){
            props.alertFunction(error.message)
        }
    }

    async function handleShow(cid) {
        let result = await getRequest(baseUrl + `/api/v1/calendars/${cid}`)
        setCalendarInfo(result)
        setShow(true)
    }

    function deleteMember(id) {
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ email: CalendarInfo.calendar.members[id].email }),
            credentials: 'include'
        };
        fetch(baseUrl + `/api/v1/calendars/${CalendarInfo.calendar.id}/members?action=remove`, requestOptions)
            .then(async response => {
                let result = await response.json()
                if (response.status == 200) {
                    props.alertSuccessFunction(`delete member successfully`)
                }
                else {
                    props.alertFunction(`${result.message}`)
                }
            })
            .catch(error => {
                props.alertFunction("unknown error")
            })
        setShow(false)
    }

    function addMember(e) {
        e.preventDefault()
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ email: memberEmail }),
            credentials: 'include'
        };

        fetch(baseUrl + `/api/v1/calendars/${CalendarInfo.calendar.id}/members?action=add`, requestOptions)
            .then(async response => {
                let result = await response.json()
                if (response.status == 200) {
                    props.alertSuccessFunction(`add member successfully`)
                }
                else {
                    props.alertFunction(`${result.message}`)
                }
            })
            .catch(error => {
                props.alertFunction("unknown error")
            })
        setShow(false)
        setMemberEmail("")
    }

    function addCalendar(e) {
        e.preventDefault()
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ title: calendarTitle }),
            credentials: 'include'
        };

        fetch(baseUrl + `/api/v1/calendars`, requestOptions)
            .then(async response => {
                let result = await response.json()
                if (response.status == 200) {
                    props.alertSuccessFunction(`add calendar successfully`)
                    setTimeout(() => {
                        displayCalendars()
                    }, 3000)
                }
                else {
                    props.alertFunction(`${result.message}`)
                }
            })
            .catch(error => {
                props.alertFunction("unknown error")
            })
        setCalendarTitle("")
    }

    async function addGuest(e){
        e.preventDefault()
        // fetch result first
        let qq = guestLink.split('cid=')[1]
        let fetch_cid = qq.split('&')[0]
        let api_key = guestLink.split('api_key=')[1]
        try{
            let result = await getRequest(baseUrl + `/api/v1/calendars/${fetch_cid}`, api_key)
        
        // then create title for guest calendar
        console.log(result.calendar.title)
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ title: result.calendar.title+"@guest", type: 1, guesturl: guestLink}),
            credentials: 'include'
        };
        
        fetch(baseUrl + `/api/v1/calendars`, requestOptions)
            .then(async response => {
                let result = await response.json()
                if (response.status == 200) {
                    props.alertSuccessFunction(`add guest calendar successfully`)
                    setTimeout(() => {
                        displayCalendars()
                    }, 3000)
                }
                else {
                    props.alertFunction(`${result.message}`)
                }
            })
            .catch(error => {
                props.alertFunction("unknown error")
            })
        }catch(e){
            props.alertFunction("add Guest Calendar fail")
            return
        }
    }

    async function getGoogleCalendar(){
        let result = await getRequest(baseUrl + `/api/v1/google/calendar`)
        console.log(result)
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
                                            <tr key={id + 1}>
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
                    <Button variant="secondary" style={{ float: 'left' }} onClick={handleClose}>
                        Close
                    </Button>
                </Modal.Footer>
            </Modal>
            <div className="App">
                <h1>Account Info</h1>
                <br />
                <Row className="justify-content-center">
                    {
                        (userInfo) ? <>
                            <Col md="auto">
                                <Form.Group>
                                    <Form.Control type="title" value={calendarTitle} onChange={(e) => { setCalendarTitle(e.target.value) }} placeholder="New Calendar Title" />
                                </Form.Group>
                            </Col>
                            <Col md="auto">
                                <Button variant="info" onClick={(e) => addCalendar(e)}>Add Calendar</Button>{' '}
                            </Col>
                        </> : ""
                    }
                    <Col md="auto">
                        <Form.Group>
                            <Form.Control type="title" value={guestLink} onChange={(e) => { setGuestLink(e.target.value) }} placeholder="guest url" />
                        </Form.Group>
                    </Col>
                    <Col md="auto">
                        <Button variant="info" onClick={(e) => {addGuest(e) }}>Import guest calendar</Button>{' '}
                    </Col>
                </Row>
                <Row>
                    <Col><Button onClick={getGoogleCalendar}>Fetch Google Calendar</Button></Col>
                </Row>
            </div>
            <br />
            <Container>
                {
                    (calendars) ?
                        <>
                            <h3 className="App">my calendar</h3>
                            <Table>
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th> calendar name</th>
                                        <th> type</th>
                                        <th>actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {calendars.map((cal, id) => {
                                        let c = cal.data.attributes
                                        return (
                                            <tr key={id}>
                                                <td>{id + 1}</td>
                                                <td>{c.title}</td>
                                                <td>{(c.type == 1)?"guest calendar":"my calendar"}</td>
                                                <td>
                                                    <Button variant="primary" onClick={() => { handleShow(c.id) }}>members</Button>{' '}
                                                    <Button variant="secondary" onClick={() => { view(c) }}>view</Button>{' '}
                                                    {/* <Button variant="danger" onClick={() => { }}>delete</Button>{' '} */}
                                                </td>
                                            </tr>)
                                    })}
                                </tbody>
                            </Table>
                        </>
                        : "empty calendars"
                }
            </Container>

        </>
    );
}

export default Account;
