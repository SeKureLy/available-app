import React, { useState, useEffect } from "react";
import { Tree, TreeNode } from 'react-organizational-chart';
import styled, { css } from 'styled-components'

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

  useEffect(() => {
      GetTest()
  }, [init]);

  async function GetTest(loading = true) {

    const requestOptions = {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
        credentials: 'include'
    };
    if(loading) props.setLoading(true)
    try {
        fetch(baseUrl + '/search/citationtree', requestOptions)
            .then(async response => {
                let result = await response.json()
                if (result.result == false) props.alertFunction(result.error)
                else {
                    setTree(result)
                    props.alertSuccessFunction("Searching results as follows!")
                    if(loading) props.setLoading(false)
                }
            })
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
        {TreeRoot(tree)}
      </div>
    </>
  );
}

export default CitationTree;
