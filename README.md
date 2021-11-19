<div id="top"></div>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="doc/img/logo.jpg" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">SCK Team</h3>

  <p align="center">
    A startup in SOA
    <br />
    <a href="/doc"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://paperdeep.herokuapp.com/">View Demo</a>
    ·
    <a href="https://github.com/SOA-SCK/PaperDeep/issues">Report Bug</a>
    ·
    <a href="https://github.com/SOA-SCK/PaperDeep/issues">Request Feature</a>
  </p>
</div>


# PaperDeep  
Application that advances researsh article searching and plays a role of literature review assistant for researchers, professionals, graduates and undergraduates.


<!-- TABLE OF CONTENTS -->
<!-- <details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#overview">Overview</a>
      <ul>
        <li><a href="#citation-tree">Citation Tree</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details> -->



## Overview
When researchers are drowning in enormous paper mess, they are afraid of omitting any papers relevant to their research topic. Even though Google Scholar, Scopus, Web of Science, etc. with a bunch of fancy and powerful features on their websites can be utilized, researchers still have one simple question: 

### <span style="color:red"> ***So, what are those most relevant papers that I need, and what is the relationship among previous works?*** </span> 

It is a long-standing issue and also an urgent need to build an application that provides precise searching result and categorizes correlated literatures. Therefore, PaperDeep advances paper search, constructs citation trees, provides publication cluster and recommends the most relevant and significant papers.

Paperdeep will pull data from Scopus API, based on user's keywords, to provide 

<span style="color:blue">* Citation Tree</span>

<span style="color:blue">* Paper Cluster</span>

<span style="color:blue">* Publication Cluster</span>

<span style="color:blue">* Recommendation of Masterpiece</span>

<p align="right">(<a href="#top">back to top</a>)</p>

## Citation Tree
PaperDeep constructs a literature review map for researchers. This map can also become a study path for novices in a certain domain.


### Built With

This section should list any major frameworks/libraries used to bootstrap your project. Leave any add-ons/plugins for the acknowledgements section. Here are a few examples.

* [Next.js](https://nextjs.org/)
* [React.js](https://reactjs.org/)
* [Vue.js](https://vuejs.org/)
* [Angular](https://angular.io/)
* [Svelte](https://svelte.dev/)
* [Laravel](https://laravel.com)
* [Bootstrap](https://getbootstrap.com)
* [JQuery](https://jquery.com)

<p align="right">(<a href="#top">back to top</a>)</p>



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




<!-- ROADMAP -->
## Roadmap

- [x] Feature 1
- [x] Feature 2
- [ ] Feature 3
    - [ ] sub
    - [ ] sub

See the [open issues](https://github.com/SOA-SCK/PaperDeep/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#top">back to top</a>)</p>




<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

SOA-SCK Team - soa.sck@gmail.com

Project Link: [https://github.com/SOA-SCK/PaperDeep](https://github.com/SOA-SCK/PaperDeep)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [othneildrew/Best-README-Template](https://github.com/othneildrew/Best-README-Template)
* [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
* [Malven's Flexbox Cheatsheet](https://flexbox.malven.co/)
* [Malven's Grid Cheatsheet](https://grid.malven.co/)
* [Img Shields](https://shields.io)
* [GitHub Pages](https://pages.github.com)
* [Font Awesome](https://fontawesome.com)
* [React Icons](https://react-icons.github.io/react-icons/search)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/SOA-SCK/PaperDeep/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/SOA-SCK/PaperDeep/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/SOA-SCK/PaperDeep/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/SOA-SCK/PaperDeep/issues
[product-screenshot]: images/screenshot.png
