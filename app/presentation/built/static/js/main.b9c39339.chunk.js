(this["webpackJsonpview-app"]=this["webpackJsonpview-app"]||[]).push([[0],{103:function(e,t,n){},104:function(e,t,n){"use strict";n.r(t);var c=n(0),r=n.n(c),i=n(19),a=n.n(i),s=(n(65),n(11)),j=n(16),l=n(8),A=n(112),o=n(111),d=n(113),h=n(6),b=n.n(h),u=n(12),O=n(34),x=n.n(O),p=n(106),f=n(107),g=n(55),y=n(110),w=n(56),m=n(108),S=n(109),k="https://paperdeep.herokuapp.com",v=n(1);var E,B=function(e){var t=Object(l.f)().search,n=x.a.parse(t),r=Object(c.useState)(!1),i=Object(s.a)(r,2),a=i[0],A=(i[1],Object(c.useState)("")),o=Object(s.a)(A,2),d=o[0],h=o[1],O=Object(c.useState)([]),E=Object(s.a)(O,2),B=E[0],I=E[1];function T(e){return F.apply(this,arguments)}function F(){return F=Object(u.a)(b.a.mark((function t(n){var c;return b.a.wrap((function(t){for(;;)switch(t.prev=t.next){case 0:if(n){t.next=3;break}return e.alertFunction("query con not be null!"),t.abrupt("return");case 3:c={method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({keyword:n})},e.setLoading(!0);try{fetch(k+"/search",c).then(function(){var t=Object(u.a)(b.a.mark((function t(n){var c;return b.a.wrap((function(t){for(;;)switch(t.prev=t.next){case 0:return t.next=2,n.json();case 2:c=t.sent,e.setLoading(!1),0==c.result?e.alertFunction(c.error):(I(c),e.alertSuccessFunction("Searching results as follows!"));case 5:case"end":return t.stop()}}),t)})));return function(e){return t.apply(this,arguments)}}())}catch(r){console.log(r.message)}case 6:case"end":return t.stop()}}),t)}))),F.apply(this,arguments)}return Object(c.useEffect)((function(){console.log(n.query),console.log(Object({NODE_ENV:"production",PUBLIC_URL:"",WDS_SOCKET_HOST:void 0,WDS_SOCKET_PATH:void 0,WDS_SOCKET_PORT:void 0,FAST_REFRESH:!0})),n.query&&(T(n.query),h(n.query))}),[a]),Object(v.jsxs)(v.Fragment,{children:[Object(v.jsx)("div",{className:"App",children:Object(v.jsx)("h1",{children:"Paper Search"})}),Object(v.jsx)("br",{}),Object(v.jsxs)(p.a,{children:[Object(v.jsxs)(f.a,{children:[Object(v.jsx)(g.a,{}),Object(v.jsx)(g.a,{xs:8,children:Object(v.jsx)(y.a,{children:Object(v.jsxs)(f.a,{children:[Object(v.jsx)(g.a,{sm:"9",children:Object(v.jsx)(w.a,{type:"text",placeholder:"Search Study Fields",value:d,onChange:function(e){h(e.target.value)}})}),Object(v.jsx)(g.a,{sm:"3",children:Object(v.jsx)(m.a,{variant:"outline-primary",onClick:function(){T(d)},children:"Search"})})]})})}),Object(v.jsx)(g.a,{})]}),Object(v.jsx)(f.a,{children:Object(v.jsxs)(S.a,{striped:!0,bordered:!0,hover:!0,size:"sm",style:{width:"100%",margin:"auto",marginTop:"1%"},children:[Object(v.jsx)("thead",{children:Object(v.jsxs)("tr",{children:[Object(v.jsx)("th",{children:"#"}),Object(v.jsx)("th",{children:"Title"}),Object(v.jsx)("th",{children:"Lead Author"}),Object(v.jsx)("th",{children:"Organization"}),Object(v.jsx)("th",{children:"Paper Link"}),Object(v.jsx)("th",{children:"Citedby"})]})}),Object(v.jsx)("tbody",{children:B.map((function(e,t){return Object(v.jsxs)("tr",{children:[Object(v.jsx)("td",{width:"3%",children:t}),Object(v.jsx)("td",{children:e.title}),Object(v.jsx)("td",{width:"10%",children:e.author}),Object(v.jsx)("td",{width:"15%",overflow:"hidden",children:e.organization}),Object(v.jsx)("td",{width:"10%",children:Object(v.jsx)("a",{href:e.paper_link,target:"_blank",children:"Scopus link"})}),Object(v.jsx)("td",{width:"10%",children:Object(v.jsx)(j.b,{to:"/citedResult/?query=".concat(e.eid),children:e.citedby})})]},t)}))})]})})]})]})},I=n(35),T=n(7),F=n(36),C=(n.p,F.a.div(E||(E=Object(I.a)(["\n  padding: 5px;\n  border-radius: 8px;\n  display: inline-block;\n  border: 1px solid red;\n"])))),Q=function(e){return e?Object(v.jsx)(T.a,{lineWidth:"2px",lineColor:"green",lineBorderRadius:"10px",label:Object(v.jsx)(C,{children:Object(v.jsx)("a",{href:e.content.link,target:"_blank",children:e.content.NodeName})}),children:e.next.map((function(e){return R(e)}))}):Object(v.jsx)(v.Fragment,{})},R=function e(t){if(t)return Object(v.jsx)(v.Fragment,{children:Object(v.jsx)(T.b,{label:Object(v.jsx)(C,{children:Object(v.jsx)("a",{href:t.content.link,target:"_blank",children:t.content.NodeName})}),children:t.next.map((function(t){return e(t)}))})})};var M,L=function(e){var t=Object(c.useState)(!1),n=Object(s.a)(t,2),r=n[0],i=(n[1],Object(c.useState)("")),a=Object(s.a)(i,2),j=(a[0],a[1],Object(c.useState)([])),l=Object(s.a)(j,2),A=(l[0],l[1],Object(c.useState)(null)),o=Object(s.a)(A,2),d=o[0],h=o[1];function O(){return O=Object(u.a)(b.a.mark((function t(){var n;return b.a.wrap((function(t){for(;;)switch(t.prev=t.next){case 0:n={method:"GET",headers:{"Content-Type":"application/json"},credentials:"include"};try{fetch(k+"/search/citationtree",n).then(function(){var t=Object(u.a)(b.a.mark((function t(n){var c;return b.a.wrap((function(t){for(;;)switch(t.prev=t.next){case 0:return t.next=2,n.json();case 2:0==(c=t.sent).result?e.alertFunction(c.error):(h(c),e.alertSuccessFunction("Searching results as follows!"));case 4:case"end":return t.stop()}}),t)})));return function(e){return t.apply(this,arguments)}}())}catch(c){console.log(c.message)}case 2:case"end":return t.stop()}}),t)}))),O.apply(this,arguments)}return Object(c.useEffect)((function(){!function(){O.apply(this,arguments)}()}),[r]),Object(v.jsx)(v.Fragment,{children:Object(v.jsxs)("div",{className:"App",children:[Object(v.jsx)("h1",{children:"CitationTree"}),Q(d)]})})};var q=function(){var e=F.a.div(M||(M=Object(I.a)(["\n  padding: 5px;\n  border-radius: 8px;\n  display: inline-block;\n  border: 1px solid red;\n"]))),t=function(){return Object(v.jsxs)(T.a,{lineWidth:"2px",lineColor:"green",lineBorderRadius:"10px",label:Object(v.jsx)(e,{children:"Root"}),children:[Object(v.jsx)(T.b,{label:Object(v.jsx)(e,{children:"Child 1"}),children:Object(v.jsx)(T.b,{label:Object(v.jsx)(e,{children:"Grand Child"})})}),Object(v.jsx)(T.b,{label:Object(v.jsx)(e,{children:"Child 2"}),children:Object(v.jsxs)(T.b,{label:Object(v.jsx)(e,{children:"Grand Child"}),children:[Object(v.jsx)(T.b,{label:Object(v.jsx)(e,{children:"Great Grand Child 1"})}),Object(v.jsx)(T.b,{label:Object(v.jsx)(e,{children:"Great Grand Child 2"})})]})}),Object(v.jsxs)(T.b,{label:Object(v.jsx)(e,{children:"Child 3"}),children:[Object(v.jsx)(T.b,{label:Object(v.jsx)(e,{children:"Grand Child 1"})}),Object(v.jsx)(T.b,{label:Object(v.jsx)(e,{children:"Grand Child 2"})})]})]})};return Object(v.jsx)(v.Fragment,{children:Object(v.jsxs)("div",{className:"App",children:[Object(v.jsx)("h1",{children:"CitationTree"}),Object(v.jsx)(t,{})]})})};var J=function(e){var t=Object(l.f)().search,n=x.a.parse(t),r=Object(c.useState)(!1),i=Object(s.a)(r,2),a=i[0],A=i[1],o=Object(c.useState)(""),d=Object(s.a)(o,2),h=(d[0],d[1]),O=Object(c.useState)([]),y=Object(s.a)(O,2),w=y[0],m=y[1],E=Object(c.useState)(null),B=Object(s.a)(E,2),I=B[0],T=B[1],F=Object(c.useState)(null),C=Object(s.a)(F,2),Q=C[0],R=C[1];function M(e){return L.apply(this,arguments)}function L(){return L=Object(u.a)(b.a.mark((function t(n){var c,r,i=arguments;return b.a.wrap((function(t){for(;;)switch(t.prev=t.next){case 0:if(c=!(i.length>1&&void 0!==i[1])||i[1],n){t.next=4;break}return alert("query con not be null!"),t.abrupt("return");case 4:r={method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({keyword:n})},c&&e.setLoading(!0);try{fetch(k+"/search",r).then(function(){var t=Object(u.a)(b.a.mark((function t(n){var r;return b.a.wrap((function(t){for(;;)switch(t.prev=t.next){case 0:return t.next=2,n.json();case 2:0==(r=t.sent).result?e.alertFunction(r.error):m(r),c&&e.setLoading(!1);case 5:case"end":return t.stop()}}),t)})));return function(e){return t.apply(this,arguments)}}())}catch(a){console.log(a.message)}case 7:case"end":return t.stop()}}),t)}))),L.apply(this,arguments)}function q(){return q=Object(u.a)(b.a.mark((function t(){var n,c,r=arguments;return b.a.wrap((function(t){for(;;)switch(t.prev=t.next){case 0:if(n=!(r.length>0&&void 0!==r[0])||r[0],I){t.next=4;break}return alert("originPaper con not be null!"),t.abrupt("return");case 4:c={method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({pid:I.publication_id})},console.log(c),n&&e.setLoading(!0);try{fetch(k+"/search/publication",c).then(function(){var t=Object(u.a)(b.a.mark((function t(c){var r;return b.a.wrap((function(t){for(;;)switch(t.prev=t.next){case 0:return t.next=2,c.json();case 2:0==(r=t.sent).result?e.alertFunction(r.error):(R(r[0]),e.alertSuccessFunction("Searching results as follows!")),n&&e.setLoading(!1);case 5:case"end":return t.stop()}}),t)})));return function(e){return t.apply(this,arguments)}}())}catch(i){console.log(i.message)}case 8:case"end":return t.stop()}}),t)}))),q.apply(this,arguments)}function J(){return(J=Object(u.a)(b.a.mark((function t(n,c){return b.a.wrap((function(t){for(;;)switch(t.prev=t.next){case 0:return e.setLoading(!0),t.next=3,M(c,!1);case 3:return t.next=5,G(c,!1);case 5:e.setLoading(!1),h(c);case 7:case"end":return t.stop()}}),t)})))).apply(this,arguments)}function G(e){return U.apply(this,arguments)}function U(){return U=Object(u.a)(b.a.mark((function t(n){var c,r,i=arguments;return b.a.wrap((function(t){for(;;)switch(t.prev=t.next){case 0:if(c=!(i.length>1&&void 0!==i[1])||i[1],n){t.next=4;break}return alert("query con not be null!"),t.abrupt("return");case 4:r={method:"POST",headers:{"Content-Type":"application/json"},credentials:"include",body:JSON.stringify({eid:n})},c&&e.setLoading(!0);try{fetch(k+"/db/eid",r).then(function(){var t=Object(u.a)(b.a.mark((function t(n){var r;return b.a.wrap((function(t){for(;;)switch(t.prev=t.next){case 0:return t.next=2,n.json();case 2:0==(r=t.sent).result?e.alertFunction(r.error):T(r),c&&e.setLoading(!1);case 5:case"end":return t.stop()}}),t)})));return function(e){return t.apply(this,arguments)}}())}catch(a){console.log(a.message)}case 7:case"end":return t.stop()}}),t)}))),U.apply(this,arguments)}return Object(c.useEffect)((function(){console.log(n.query),!a&&n.query&&(!function(e,t){J.apply(this,arguments)}("",n.query),A(!0)),I&&function(){q.apply(this,arguments)}(!0)}),[a,I]),Object(v.jsxs)(v.Fragment,{children:[Object(v.jsx)("br",{}),Object(v.jsx)("div",{className:"App",children:Object(v.jsx)("h1",{children:"Cited Papers of"})}),Object(v.jsx)("br",{}),Object(v.jsxs)(p.a,{children:[Object(v.jsxs)(f.a,{children:[Object(v.jsx)(g.a,{}),I?Object(v.jsx)(g.a,{xs:10,children:Object(v.jsx)("h2",{children:Object(v.jsx)("a",{href:I.paper_link,target:"_blank",children:I.title})})}):"",Object(v.jsx)(g.a,{})]}),Q?Object(v.jsxs)(v.Fragment,{children:[Object(v.jsxs)(f.a,{children:[Object(v.jsx)(g.a,{}),Object(v.jsxs)(g.a,{children:[Object(v.jsx)("b",{children:"Citation Count"})," : ",Q.citation_count]}),Object(v.jsxs)(g.a,{children:[Object(v.jsx)("b",{children:"View Count"})," : ",Q.views_count]}),Object(v.jsxs)(g.a,{children:[Object(v.jsx)("b",{children:"publication year"})," : ",Q.publication_year]}),Object(v.jsx)(g.a,{})]}),Object(v.jsxs)(f.a,{children:[Object(v.jsx)(g.a,{}),Object(v.jsxs)(g.a,{children:[Object(v.jsx)("b",{children:"Publication"})," : ",Q.source_title]}),Object(v.jsxs)(g.a,{children:[Object(v.jsx)("b",{children:"journal impact"})," : ",Q.journal_impact]}),Object(v.jsx)(g.a,{})]})]}):Object(v.jsx)(v.Fragment,{}),Object(v.jsxs)(f.a,{children:[Object(v.jsx)(g.a,{}),I?Object(v.jsx)(g.a,{xs:10,children:Object(v.jsx)("center",{children:Object(v.jsx)("h3",{children:Object(v.jsx)(j.b,{to:"/citationTree",children:"Citation Tree"})})})}):"",Object(v.jsx)(g.a,{})]}),Object(v.jsx)(f.a,{children:Object(v.jsxs)(S.a,{striped:!0,bordered:!0,hover:!0,size:"sm",style:{width:"85%",margin:"auto",marginTop:"1%"},children:[Object(v.jsx)("thead",{children:Object(v.jsxs)("tr",{children:[Object(v.jsx)("th",{children:"#"}),Object(v.jsx)("th",{children:"Title"}),Object(v.jsx)("th",{children:"Lead Author"}),Object(v.jsx)("th",{children:"Organization"}),Object(v.jsx)("th",{children:"Paper Link"}),Object(v.jsx)("th",{children:"Citedby"})]})}),Object(v.jsx)("tbody",{children:w.map((function(e,t){return Object(v.jsxs)("tr",{children:[Object(v.jsx)("td",{width:"3%",children:t}),Object(v.jsx)("td",{children:e.title}),Object(v.jsx)("td",{width:"15%",children:e.author}),Object(v.jsx)("td",{width:"15%",overflow:"hidden",children:e.organization}),Object(v.jsx)("td",{width:"10%",children:Object(v.jsx)("a",{href:e.paper_link,target:"_blank",children:"Scopus link"})}),Object(v.jsx)("td",{width:"10%",children:e.citedby})]},t)}))})]})})]})]})},G=n(58),U=n.n(G);n(103);var D=function(){var e=Object(c.useState)(!1),t=Object(s.a)(e,2),n=t[0],r=t[1],i=Object(c.useState)(!1),a=Object(s.a)(i,2),h=a[0],b=a[1],u=Object(c.useState)(!1),O=Object(s.a)(u,2),x=O[0],p=O[1];function f(e){b(e),setTimeout((function(){b(null)}),3e3)}function g(e){p(e),setTimeout((function(){p(null)}),5e3)}return Object(v.jsxs)(v.Fragment,{children:[Object(v.jsx)("link",{rel:"stylesheet",href:"https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css",integrity:"sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk",crossOrigin:"anonymous"}),Object(v.jsx)(j.a,{children:Object(v.jsx)(U.a,{active:n,spinner:!0,text:"Loading...",children:Object(v.jsxs)("div",{style:{height:"100vh"},children:[Object(v.jsxs)(A.a,{bg:"dark",variant:"dark",children:[Object(v.jsxs)(A.a.Brand,{href:"/",children:[Object(v.jsx)("img",{alt:"",src:"data:image/jpeg;base64,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",width:"30",height:"30",className:"d-inline-block align-top"})," ","PaperDeep"]}),Object(v.jsxs)(o.a,{children:[Object(v.jsx)(o.a.Item,{children:Object(v.jsx)(j.b,{to:"/",style:{color:"white"},children:"Search"})}),"\xa0\xa0",Object(v.jsx)(o.a.Item,{children:Object(v.jsx)(j.b,{to:"/citedResult",style:{color:"white"},children:"CitedResult"})}),"\xa0\xa0",Object(v.jsx)(o.a.Item,{children:Object(v.jsx)(j.b,{to:"/citationTree",style:{color:"white"},children:"CitationTree"})}),"\xa0\xa0",Object(v.jsx)(o.a.Item,{children:Object(v.jsx)(j.b,{to:"/beta",style:{color:"white"},children:"Beta"})})]})]}),Object(v.jsx)("br",{}),h?Object(v.jsx)(d.a,{variant:"danger",style:{marginLeft:"20%",marginRight:"20%"},children:h}):"",x?Object(v.jsx)(d.a,{variant:"info",style:{marginLeft:"20%",marginRight:"20%"},children:x}):"",Object(v.jsxs)(l.c,{children:[Object(v.jsx)(l.a,{path:"/citedResult",children:Object(v.jsx)(J,{setLoading:r,alertFunction:f,alertSuccessFunction:g})}),Object(v.jsx)(l.a,{path:"/citationTree",children:Object(v.jsx)(L,{setLoading:r,alertFunction:f,alertSuccessFunction:g})}),Object(v.jsx)(l.a,{path:"/beta",children:Object(v.jsx)(q,{setLoading:r,alertFunction:f,alertSuccessFunction:g})}),Object(v.jsx)(l.a,{path:"/",children:Object(v.jsx)(B,{setLoading:r,alertFunction:f,alertSuccessFunction:g})})]})]})})})]})},H=function(e){e&&e instanceof Function&&n.e(3).then(n.bind(null,114)).then((function(t){var n=t.getCLS,c=t.getFID,r=t.getFCP,i=t.getLCP,a=t.getTTFB;n(e),c(e),r(e),i(e),a(e)}))};a.a.render(Object(v.jsx)(r.a.StrictMode,{children:Object(v.jsx)(D,{})}),document.getElementById("root")),H()},65:function(e,t,n){}},[[104,1,2]]]);
//# sourceMappingURL=main.b9c39339.chunk.js.map