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
    const [myEventsList, setMyEventsList] = useState([])
    const { user, setUser } = useContext(AuthContext);

    useEffect(() => {
        if(user){
            getCalendar()
        }
    }, []);


    async function getCalendar(){
        // todo:  call get calendars api
        // const auth_token = 'Bearer ' + user.auth_token
        const requestOptions = {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include'
        };
        fetch(baseUrl+'/api/v1/calendars/1', requestOptions)
        .then(async response =>{
            let result = await response.json()
            console.log(result)

            if (response.status === 200){
                if(result.calendar){
                    let events = result.calendar.events.map(e => ({
                        title: e.title,
                        start: new Date(e.start_time*1000),
                        end: new Date(e.end_time*1000)
                    }));
                    setMyEventsList(events)
                }
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
                {
                    (user) ? <h1>Hello, {user}</h1> : <h1>Party time</h1>
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
                        />
                    </Col>
                </Row>
            </Container>

        </>
    );
}

export default CalendarView;
