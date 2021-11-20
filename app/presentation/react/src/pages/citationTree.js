import React, { useState, useEffect } from "react";
import { Tree, TreeNode } from 'react-organizational-chart';
import styled, { css } from 'styled-components'

import { Button, Navbar, Nav } from 'react-bootstrap'
import logo from './../logo.svg';
const testTreeData = {
  content:{NodeName:"paper1",eid:""},
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

  return (
  <Tree
    lineWidth={'2px'}
    lineColor={'green'}
    lineBorderRadius={'10px'}
    label={<StyledNode>{data.content.NodeName}</StyledNode>}
  >
  {data.next.map((unit)=>{
    return recursiveTree(unit)
  })}
  </Tree>)
}

const recursiveTree = (data) => {
  if (!data) return 
  return (<>
      <TreeNode label={<StyledNode>{data.content.NodeName}</StyledNode>}>
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
function CitationTree() {



  return (
    <>
      <div className="App">
        <h1>CitationTree</h1>
        {/* <img src={logo} className="App-logo" alt="logo" /> */}
        {/* <StyledTreeExample /> */}
        {TreeRoot(testTreeData)}
      </div>
    </>
  );
}

export default CitationTree;
