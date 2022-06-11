import React, { useState, useEffect, useContext, useRef } from "react";
import queryString from 'query-string'
import {
    BrowserRouter as Router,
    Switch,
    Route,
    useLocation,
    Link
} from "react-router-dom";
import { Button, Tooltip, Nav, Form, Col, Modal, Row, OverlayTrigger, Container, Table } from 'react-bootstrap'
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
    const [show, setShow] = useState(false);
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
                            description: e.description,
                            start: new Date(e.start_time),
                            end: new Date(e.end_time)
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
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include',
            body:JSON.stringify({
                "title": title,
                "start_time": moment(stime).toDate().getTime(),
                "end_time": moment(etime).toDate().getTime(),
                "description": description
            })
        };
        fetch(`${baseUrl}/api/v1/calendars/${urlparams.cid}/events`, requestOptions)
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

    return (
        <>
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
            <div className="App">
                {
                    (user) ?
                        <>
                            <Row>
                                <Col></Col>
                                <Col><h1>Hello, {user}</h1></Col>
                                <Col><br /><Button variant="secondary" onClick={() => { setShow(true) }}>add event</Button></Col>
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
          overlay={<Tooltip><div>detail:</div><div>{content.description}</div></Tooltip>}
        >
          <span>{event.title}</span>
        </OverlayTrigger>
    );
  }

export default CalendarView;
