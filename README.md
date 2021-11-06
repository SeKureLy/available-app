# PaperDeep  
PublicationOrm.create(publicationId: 84979828304,journalImpact:3.5,viewsCount:1,citationCount:2,publicationYear:2000,sourceTitle:"IEEE")
## front-end
### set-up
* install nvm
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
```
reopen terminal and install nodejs
```
nvm install --lts
```
open project,init npm and download packages
```
cd app/views/react
npm init
npm i
```
if npm i fail
```
npm i react-loading-overlay --legacy-peer-deps
```
### Develop when building front-end
```
cd app/views/react
npm run start
```

### Develop when building back-end
```
rackup || bundle exec rackup
```
### Develop End, build react as static files
```
npm run build
```
this command will build the view-app static code to app/views/built

## Overview
When you are drowning in enormous papers, PaperDeep advances paper search, recommending the  most relevant and significant ones.

## Features (developing)
1. Clustering of papers
2. Automatically recommend impactful papers according user’s study field
3. For papers from at least one year ago, base on citations and web of science. Otherwise, base on Conference. 
4. Citation tree : a study path for novices in certain domain
5. Booming paper: Track and report the citation growth of papers
## Domain-Specific Words
* **Title**: title of the paper
* **eid**: paper id in scopus database
* **link**: the paper URL
* **publication name**: the publication of paper (Conference, Jornal)
* **date**: the publication date of paper
* **organization**: the organization of the author
* **citedby**: a citation count of the paper
* **author**: Lead authorname



## Resource
Elsevier Scopus API

## Entities
* paper_info
