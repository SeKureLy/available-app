# Front end tutorial (react.js)
## How to use
PublicationOrm.create(publicationId: 84979828304,journalImpact:3.5,viewsCount:1,citationCount:2,publicationYear:2000,sourceTitle:"IEEE")
### front-end
#### set-up
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
#### Develop when building front-end
```
cd app/views/react
npm run start
```

#### Develop when building back-end
```
rackup || bundle exec rackup
```
#### Develop End, build react as static files
```
npm run build
```
this command will build the view-app static code to app/views/built

<p align="right">(<a href="#top">back to top</a>)</p>

### Built With

* [Ruby](https://www.ruby-lang.org/zh_tw/)
* [React.js](https://reactjs.org/)
* [Heroku](https://www.heroku.com/)

<p align="right">(<a href="#top">back to top</a>)</p>