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
function RegisterAccount(props) {
    const { search } = useLocation()
    const urlparams = queryString.parse(search)
    const history = useHistory();
    const [init, setinit] = useState(false)
    const [account, setAccount] = useState("")
    const [email, setEmail] = useState("")
    const [password, setPassword] = useState("")
    const { setUser } = useContext(AuthContext);

    useEffect(() => {

    }, []);

    async function createAccount(event){
        // todo:  call login api
        event.preventDefault()
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ username: account, password:password ,email:email})
        };
        fetch(baseUrl+'/api/v1/auth/register', requestOptions)
        .then(async response =>{
            let result = await response.json()
            console.log(result)
            if (response.status == 200){
                props.alertSuccessFunction(result.message)
                setTimeout(()=>{
                    history.push('/login')
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
            props.alertFunction(error.message)
        })
    }

    return (
        <>

            <div className="App">
                <h1>Create Account</h1>
            </div>
            <br />
            <Container>
                <Row>
                    <Col></Col>
                    <Col>
                        <Form onSubmit={(e)=>{createAccount(e)}}>
                            <Form.Group className="mb-3" controlId="formBasicAccount">
                                <Form.Label>Account</Form.Label>
                                <Form.Control type="text" value={account} onChange={(e)=>{setAccount(e.target.value)}} placeholder="Enter username" />
                            </Form.Group>

                            <Form.Group className="mb-3" controlId="formBasicEmail">
                                <Form.Label>E-mail</Form.Label>
                                <Form.Control type="email" value={email} onChange={(e)=>{setEmail(e.target.value)}} placeholder="Enter email" />
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

export default RegisterAccount;
