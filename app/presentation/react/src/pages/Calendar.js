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
import { Calendar, momentLocalizer } from 'react-big-calendar'
import moment from 'moment'
import 'react-big-calendar/lib/css/react-big-calendar.css';
function CalendarView(props) {
    const { search } = useLocation()
    const localizer = momentLocalizer(moment)
    const urlparams = queryString.parse(search)
    const [init, setinit] = useState(false)
    const [query, setQuery] = useState("")
    const [myEventsList, setMyEventsList] = useState([
        {title : "test", start : moment(), end : moment(), allDay : false},
        {title : "test", start : moment(), end : moment(), allDay : true}
    ])
    const { user, setUser } = useContext(AuthContext);

    return (
        <>

            <div className="App">
                {
                    (user) ? <h1>Hello, {user}</h1> : <h1>Party time</h1>
                }
            </div>
            <br />
            <Container>
                <Row>
                    <Col>
                        <Calendar
                            localizer={localizer}
                            events={myEventsList}
                            startAccessor="start"
                            endAccessor="end"
                            style={{ height: 500 }}
                        />
                    </Col>
                </Row>
            </Container>

        </>
    );
}

export default CalendarView;
