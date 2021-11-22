import React, { useState, useEffect } from "react";
import { Tree, TreeNode } from 'react-organizational-chart';
import styled, { css } from 'styled-components'

import { Button, Navbar, Nav } from 'react-bootstrap'
import logo from './../logo.svg';
import { baseUrl } from '../config'
const testTreeData = {
  content:{NodeName:"paper1",eid:"",paper_link:""},
  next:
  [
    {
      content:{NodeName:"paper2",eid:""},
      next:[
        {
          content:{NodeName:"paper4",eid:""},
          next:[
            {
              content:{NodeName:"paper5",eid:""},
              next:[
                {
                  content:{NodeName:"paper4",eid:""},
                  next: []
                }
              ]
            },
            {
              content:{NodeName:"paper6",eid:""},
              next:[
                
              ]
            }
          ]
        }
      ]
    },
    {
      content:{NodeName:"paper3",eid:""},
      next:[

      ]
    }
  ]
}
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

const StyledTreeExample = () => (
  <Tree
    lineWidth={'2px'}
    lineColor={'green'}
    lineBorderRadius={'10px'}
    label={<StyledNode>Root</StyledNode>}
  >
    <TreeNode label={<StyledNode>Child 1</StyledNode>}>
      <TreeNode label={<StyledNode>Grand Child</StyledNode>} />
    </TreeNode>
    <TreeNode label={<StyledNode>Child 2</StyledNode>}>
      <TreeNode label={<StyledNode>Grand Child</StyledNode>}>
        <TreeNode label={<StyledNode>Great Grand Child 1</StyledNode>} />
        <TreeNode label={<StyledNode>Great Grand Child 2</StyledNode>} />
      </TreeNode>
    </TreeNode>
    <TreeNode label={<StyledNode>Child 3</StyledNode>}>
      <TreeNode label={<StyledNode>Grand Child 1</StyledNode>} />
      <TreeNode label={<StyledNode>Grand Child 2</StyledNode>} />
    </TreeNode>
  </Tree>
);
function CitationTree(props) {
  const [init, setinit] = useState(false)
  const [query, setQuery] = useState("")
  const [data, setData] = useState([])
  const [tree, setTree] = useState(null)

  useEffect(() => {
      GetTest()
  }, [init]);

  async function GetTest() {

    const requestOptions = {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
        credentials: 'include'
    };
    try {
        fetch(baseUrl + '/search/citationtree', requestOptions)
            .then(async response => {
                let result = await response.json()
                if (result.result == false) props.alertFunction(result.error)
                else {
                    setTree(result)
                    props.alertSuccessFunction("Searching results as follows!")
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
