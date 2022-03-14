# testing script in rake console
in pry for tesing ORM and repository script
# entering testing record
0. drop and migrate db
1. rackup use postman hit one request,Papers will get 25 records
2. use rake console key publication raw data
```
rake console
cd PaperDeep/Database
PublicationOrm.create(publication_id: 84979828304,journal_impact:3.5,views_count:1,citation_count:2,publication_year:2000,source_title:"IEEE")
```
# 測試left join
rake console
```
cd PaperDeep/Repository
Papers.all.first
Papers.find_publication_by_id(84979828304)
Papers.find_publication_by_id(84979828304).publication.content
```
# test