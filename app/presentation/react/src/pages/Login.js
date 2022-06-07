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
    // const [init, setinit] = useState(false)
    const [account, setAccount] = useState("")
    const [password, setPassword] = useState("")
    const { user, setUser } = useContext(AuthContext);

    useEffect(() => {

    }, []);

    function login(event){
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
            if (response.status == 200){
                props.alertSuccessFunction(`Welcome, ${result.account.username}`)
                // const account = {username: result.account.username, email:result.account.email}
                console.log(account)
                setUser(result.account.username)
                setTimeout(()=>{
                    history.push('/Account')
                },3000)
            }
            else{
                props.alertFunction(`${result.message}`)
                setTimeout(()=>{
                    window.location.reload()
                },3000)
            }
        })
        .catch(error =>{
            props.alertFunction("unknown error")
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
                            <Form.Group className="mb-3">
                                <Form.Label>Account</Form.Label>
                                <Form.Control type="text" value={account} onChange={(e)=>{setAccount(e.target.value)}} placeholder="Enter username" />
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
