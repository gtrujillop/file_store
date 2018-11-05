# README

This is a small application to upload files with tags and retrieves it.

Rails 5.2
Ruby 2.4.4

### System dependencies

  * Sidekiq
  * Active Storage
  * Act As Taggable gem to use tags associated with FileUpload model and allow searching by tags.
  
### Configuration

  For local environment, no need to setup Amazon S3 keys, as far as Active Storage stores locally.

### Database creation

`rake db:create db:migrate`

### How to run the test suite
  
No testing added

### Services (job queues, cache servers, search engines, etc.)

Sidekiq added but not used.

+ Once running, just run a POST request
```
curl -X POST \
  http://localhost:3000/file_uploads \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 6f17b58e-56f3-0e12-9149-8fa68045ac1f' \
  -d '{
	"file_upload": {
		"file_name": "file03",
		"tag_list": ["sports", "healthcare"]
	}
}'
```

+ And Search by running a GET request
```
curl -X GET \
  'http://localhost:3000/file_uploads/+sports%20-healthcare/1' \
  -H 'cache-control: no-cache' \
  -H 'postman-token: ceb0c56d-c3ea-c69f-d7f5-31d6bb721d26'
```
