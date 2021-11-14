# PaperDeep  
Application that advances researsh article searching and plays a role of literature review assistant for researchers, professionals, graduates and undergraduates.

## Overview
When researchers are drowning in enormous paper mess, they are afraid of omitting any papers relevant to their research topic. Even though Google Scholar, Scopus, Web of Science, etc. with a bunch of fancy and powerful features on their websites can be utilized, researchers still have one simple question: 

### <span style="color:red"> ***So, what are those most relevant papers that I need, and what is the relationship among previous works?*** </span> 

It is a long-standing issue and also an urgent need to build an application that provides precise searching result and categorizes correlated literatures. Therefore, PaperDeep advances paper search, constructs citation trees, provides publication cluster and recommends the most relevant and significant papers.

Paperdeep will pull data from Scopus API, based on user's keywords, to provide 

<span style="color:blue">* Citation Tree</span>

<span style="color:blue">* Paper Cluster</span>

<span style="color:blue">* Publication Cluster</span>

<span style="color:blue">* Recommendation of Masterpiece</span>


## Citation Tree
PaperDeep constructs a literature review map for researchers. This map can also become a study path for novices in a certain domain.

## Paper Cluster
Clusters of papers.
PaperDeep clusters highly relevant papers and then sorts these papers, according to significance metrics (e.g. citations, journal impact), for each user from various kinds of academic disciplines and backgrounds.

# Long-term Goals

## Publication Cluster
Searching result sorted by publication's journal impact and clustered by different field.

## Recommendation of Masterpiece
PaperDeep automatically recommends impactful papers according to user’s study field.

---
---
---
# How to use
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
