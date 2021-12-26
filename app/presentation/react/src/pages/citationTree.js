import React, { useState, useEffect } from "react";
import { Container } from "react-bootstrap";
import { Tree, TreeNode } from 'react-organizational-chart';
import styled, { css } from 'styled-components'
import Faye, { Client } from 'faye'

import { baseUrl } from '../config'


const StyledNode = styled.div`
  padding: 5px;
  border-radius: 8px;
  display: inline-block;
  border: 1px solid red;
`;

const TreeRoot = (data)=>{
  if (!data) return <></>
  return (
  <Tree
    lineWidth={'2px'}
    lineColor={'green'}
    lineBorderRadius={'10px'}
    label={<StyledNode><a href={data.content.link} target="_blank">{data.content.NodeName}</a></StyledNode>}
  >
  {data.next.map((unit)=>{
    return recursiveTree(unit)
  })}
  </Tree>)
}

const recursiveTree = (data) => {
  if (!data) return 
  return (<>
      <TreeNode label={<StyledNode><a href={data.content.link} target="_blank">{data.content.NodeName}</a></StyledNode>}>
      {data.next.map((unit)=>{
        return recursiveTree(unit)
      })}
      </TreeNode>
    
  </>)
}


function CitationTree(props) {
  const [init, setinit] = useState(false)
  const [tree, setTree] = useState(null)
  const [ws, setWs] = useState(null)
  const [client,setClient] = useState(null)

  useEffect(() => {
      if(!init)GetTest(true,true)
      // if(ws){
        

      //   if(client){
      //     console.log("trigger")
      //     console.log(ws.channel_id)
      //     client.subscribe(`/${ws.channel_id}`, function(message) {
      //       console.log('Got a message: ' + message);
      //     });
      //   }
      //   else{
      //     console.log(ws.ws_route)
      //     setClient(new Faye.Client(ws.ws_route));
      //   }
      // }
  }, [init,ws,client]);

  async function GetTest(loading = true,initial=false) {

    const requestOptions = {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
        credentials: 'include'
    };
    if(loading) props.setLoading(true)
    try {
        let response = await fetch(baseUrl + '/api/v1/citationtree', requestOptions)
        let result = await response.json()
        if(initial)setinit(true)
        if (result.result == false){
          // props.alertFunction(result.error)
          console.log(result)
          // setWs(result)
          var c = new Faye.Client(result.ws_route);
          setClient(c)
          c.subscribe(`/${result.channel_id}`, function(message) {
            console.log('Got a message: ' + message);
          });
          console.log(c)
        } 
        else {
            let tree = JSON.parse(result.data)
            setTree(tree)
            props.alertSuccessFunction("Searching results as follows!")
        }
        if(loading) props.setLoading(false)
    } catch (e) {
        console.log(e.message)
    }
}

  return (
    <>
      <div className="App">
        <h1>CitationTree</h1>
        {/* <img src={logo} className="App-logo" alt="logo" /> */}
        {/* <StyledTreeExample /> */}
        <Container style={{overflowX:"scroll",border:"2px solid gray", justifyContent:"center"}}>
          {TreeRoot(tree)}
        </Container>
        
      </div>
    </>
  );
}

export default CitationTree;
