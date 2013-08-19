Lifestream
===

Lifestream is a cross between Evernote and Day One for the user who wants more control and efficiency of journaling.

## Technologies
* Built with Ruby on Rails
* Javascript
  * AJAX
  * jQuery
  * UJS
* All CSS custom-written for the project
* APIs
  * Google Maps v3 Javascript API with gmaps4rails gem
  * Markit for stock quotes
* Javascript parsing of custom scripting language to expand snippets
  * e.g. typing in @ STOCK GOOG @ in a new post will expand to Google's current stock price
* SortableTree plugin for arrangement of categories
* Markdown live preview with Javascript
* Devise for authentication with Sendgrid for user confirmation on Heroku
* Paperclip for file uploading with Amazon S3
  * Drag and drop file ploading with jQuery File Upload
* Testing done with RSpec, Poltergeist, FactoryGirl, and Capybara with Guard on a Spork server

## Features
* Categories can be organized in a tree structure
* Expand snippets to useful information immediately while typing
* Drag and drop to upload your photos to a post
* Automatic geolocation of posts
* Separate your posts into multiple streams
* Share selected posts with friends, and comment on their posts!


## Upcoming features:
* AJAX autosaving
* Ability to add Wiki links to posts in a particular stream