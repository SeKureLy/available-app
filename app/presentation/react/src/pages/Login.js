import React, { useState, useEffect, useContext } from "react";
import queryString from 'query-string'
import {
    BrowserRouter as Router,
    Switch,
    Route,
    useLocation,
    useHistory
} from "react-router-dom";
import { Button, Form, Col, InputGroup, Row, FormControl, Container, Table } from 'react-bootstrap'
import { baseUrl } from '../config'
import { AuthContext } from "../contexts";
function Login(props) {
    const { search } = useLocation()
    const urlparams = queryString.parse(search)
    const history = useHistory();
    const [init, setinit] = useState(false)
    const [account, setAccount] = useState("")
    const [password, setPassword] = useState("")
    const { setUser } = useContext(AuthContext);

    useEffect(() => {

    }, []);

    async function login(event){
        // todo:  call login api
        event.preventDefault()
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ username: account, password:password })
        };
        fetch(baseUrl+'/api/v1/auth/login', requestOptions)
        .then(async response =>{
            let result = await response.json()
            console.log(result)
            props.alertSuccessFunction(`Welcome, ${result.account}`)
            setUser(result.account)
            setTimeout(()=>{
                history.push('/')
            },3000)
        })
        .catch(error =>{
            console.log("login fail")
            props.alertFunction("login fail")
        })
    }

    return (
        <>

            <div className="App">
                <h1>Available</h1>
            </div>
            <br />
            <Container>
                <Row>
                    <Col></Col>
                    <Col>
                        <Form onSubmit={(e)=>{login(e)}}>
                            <Form.Group className="mb-3" controlId="formBasicEmail">
                                <Form.Label>Account</Form.Label>
                                <Form.Control type="text" value={account} onChange={(e)=>{setAccount(e.target.value)}} placeholder="Enter email" />
                                <Form.Text className="text-muted">
                                    We'll never share your email with anyone else.
                                </Form.Text>
                            </Form.Group>

                            <Form.Group className="mb-3" controlId="formBasicPassword">
                                <Form.Label>Password</Form.Label>
                                <Form.Control type="password" value={password} onChange={(e)=>{setPassword(e.target.value)}} placeholder="Password" />
                            </Form.Group>
                            <Button variant="primary" type="submit">
                                Submit
                            </Button>
                        </Form>
                    </Col>
                    <Col></Col>
                </Row>
            </Container>

        </>
    );
}

export default Login;
