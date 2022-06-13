import React, { useState, useEffect, useContext, useRef } from "react";
import queryString from 'query-string'
import {
    BrowserRouter as Router,
    Switch,
    Route,
    useLocation,
    Link
} from "react-router-dom";
import { Button, Tooltip, Nav, Form, Col, Modal, Row, OverlayTrigger, Container, CloseButton } from 'react-bootstrap'
import { baseUrl } from '../config'
import { AuthContext } from "../contexts";
import { Calendar, momentLocalizer } from 'react-big-calendar'
import moment from 'moment'
import 'react-big-calendar/lib/css/react-big-calendar.css';
function CalendarView(props) {
    const { search } = useLocation()
    const localizer = momentLocalizer(moment)
    const urlparams = queryString.parse(search)
    const [init, setinit] = useState(false)
    const [query, setQuery] = useState("")
    const [myEventsList, setMyEventsList] = useState([])
    const { user, setUser } = useContext(AuthContext);
    const { userInfo, setUserInfo } = useContext(AuthContext);
    const [show, setShow] = useState(false);
    const [show2, setShow2] = useState(false);
    const handleClose = () => setShow(false);
    const [title, setTitle] = useState("");
    const [description, setDescription] = useState("");
    const [stime, setstime] = useState("");
    const [etime, setetime] = useState("");


    useEffect(() => {
        if (user) {
            if (urlparams.cid && !init) {
                getCalendar()
                setinit(true)
            }
        }
        else{
            if(urlparams.cid && !init && urlparams.api_key){
                getCalendarWithKey()
                setinit(true)
            }
        }
    }, [user, urlparams, init]);


    async function getCalendar() {
        const requestOptions = {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include'
        };
        fetch(`${baseUrl}/api/v1/calendars/${urlparams.cid}`, requestOptions)
            .then(async response => {
                let result = await response.json()
                if (response.status === 200) {
                    if (result.calendar) {
                        let events = result.calendar.events.map(e => ({
                            title: e.title,
                            id: e.id,
                            description: e.description,
                            start: new Date(e.start_time),
                            end: new Date(e.end_time),
                            delete: deleteEvent
                        }));
                        setMyEventsList(events)
                    }
                }
                else {
                    props.alertFunction(`${result.message}`)
                }
            })
            .catch(error => {
                props.alertFunction(error.message)
            })
    }

    async function addEvent(){
        let start_time = moment(stime).toDate().getTime();
        let end_time = moment(etime).toDate().getTime()
        if(start_time > end_time){
            window.alert("start time must be smaller than end time!")
            return
        }
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include',
            body:JSON.stringify({
                "title": title,
                "start_time": start_time,
                "end_time": end_time,
                "description": description
            })
        };
        fetch(`${baseUrl}/api/v1/calendars/${urlparams.cid}/events?action=add`, requestOptions)
            .then(async response => {
                let result = await response.json()
                if (response.status === 200) {
                    props.alertSuccessFunction(result.message)
                }
                else {
                    props.alertFunction(`${result.message}`)
                }
            })
            .catch(error => {
                props.alertFunction(error.message)
            })
        setShow(false)
        setinit(false)
    }

    async function deleteEvent(event_id){
        let userConfirm = window.confirm("are you sure to delete events?")
        if (!userConfirm) return
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include',
            body:JSON.stringify({
                "event_id": event_id
            })
        };
        fetch(`${baseUrl}/api/v1/calendars/${urlparams.cid}/events?action=remove`, requestOptions)
            .then(async response => {
                let result = await response.json()
                if (response.status === 200) {
                    props.alertSuccessFunction(result.message)
                }
                else {
                    props.alertFunction(`${result.message}`)
                }
            })
            .catch(error => {
                props.alertFunction(error.message)
            })
        setShow(false)
        setinit(false)
    }

    async function getCalendarWithKey(){
        const requestOptions = {
            method: 'Get',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${urlparams.api_key}`
            },
            credentials: 'include',
        };
        fetch(`${baseUrl}/api/v1/calendars/${urlparams.cid}`, requestOptions)
            .then(async response => {
                let result = await response.json()
                if (response.status === 200) {
                    if (result.calendar) {
                        let events = result.calendar.events.map(e => ({
                            title: "busy",
                            id: e.id,
                            description: e.description,
                            start: new Date(e.start_time),
                            end: new Date(e.end_time),
                            delete: deleteEvent
                        }));
                        setMyEventsList(events)
                    }
                }
                else {
                    props.alertFunction(`${result.message}`)
                }
            })
            .catch(error => {
                props.alertFunction(error.message)
            })
    }

    return (
        <>
            <div className="App">
                {
                    (user) ?
                        <>
                            <Row>
                                <Col></Col>
                                <Col><h1>Hello, {userInfo.username}</h1></Col>
                                <Col>
                                    <Button variant="secondary" onClick={() => { setShow(true) }}>add event</Button>
                                    <Modal
                                        show={show}
                                        onHide={handleClose}
                                        backdrop="static"
                                        keyboard={false}
                                    >
                                        <Modal.Header closeButton>
                                            <Modal.Title>Add Event</Modal.Title>
                                        </Modal.Header>
                                        <Modal.Body>
                                            <Form>
                                                <Form.Group className="mb-3" controlId="formBasicPassword">
                                                    <Form.Label>Title</Form.Label>
                                                    <Form.Control type="text" value={title} onChange={(e) => { setTitle(e.target.value) }} placeholder="title" />
                                                </Form.Group>

                                                <Form.Group className="mb-3" controlId="formBasicPassword">
                                                    <Form.Label>Description</Form.Label>
                                                    <Form.Control type="text" value={description} onChange={(e) => { setDescription(e.target.value) }} placeholder="description" />
                                                </Form.Group>
                                                <Form.Group>
                                                    <Form.Label>Start Date</Form.Label>
                                                    <Form.Control type="datetime-local" name="start time" onChange={(e)=>{setstime(e.target.value)}}/>
                                                </Form.Group>
                                                <Form.Group>
                                                    <Form.Label>End Date</Form.Label>
                                                    <Form.Control type="datetime-local" name="end time" onChange={(e)=>{setetime(e.target.value)}}/>
                                                </Form.Group>
                                            </Form>
                                        </Modal.Body>
                                        <Modal.Footer>
                                            <Button variant="primary" style={{ float: 'left' }} onClick={addEvent}>
                                                Add
                                            </Button>
                                        </Modal.Footer>
                                    </Modal>
                                    <Button variant="info" onClick={() => { setShow2(true) }}>share calendar</Button>  
                                    <Modal
                                        show={show2}
                                        onHide={()=>{setShow2(false)}}
                                        backdrop="static"
                                        keyboard={false}>
                                        <Modal.Header closeButton>
                                            <Modal.Title>share your calendar</Modal.Title>
                                        </Modal.Header>
                                        <Modal.Body>
                                            <a href={`/calendar?cid=${urlparams.cid}&api_key=${userInfo.auth_token}`}>visitor's link below</a>
                                        </Modal.Body>
                                        <Modal.Footer>
                                        </Modal.Footer>
                                    </Modal>  
                                </Col>
                            </Row>
                        </>
                        : <h1>Party time</h1>
                }
            </div>
            <br />
            <Container>
                <Row>
                    <Col>
                        <Calendar
                            defaultDate={new Date()}
                            localizer={localizer}
                            events={myEventsList}
                            style={{ height: 500 }}
                            components={{ event: Event }}
                            popup
                        />
                    </Col>
                </Row>
            </Container>

        </>
    );
}

function Event(event) {
    const [content,_] = useState(event.event)
    return (
        <OverlayTrigger
          trigger={"click"}
          overlay={<Tooltip><>
          <div>detail:<CloseButton style={{color:"white"}} onClick={()=>{content.delete(content.id)}}/></div>
          <div>{content.description}</div>
          <div>from: {content.start.toLocaleTimeString()}</div>
          <div>until: {content.end.toLocaleTimeString()}</div>
          {/* <div><Button size="sm" variant="secondary">remove</Button></div> */}
          </></Tooltip>}
        >
          <span>{event.title}</span>
        </OverlayTrigger>
    );
  }

export default CalendarView;
