# Celebratly - Belated is outdated

---

### Server URL: https://kiprosh-optimize-prime.herokuapp.com/ 

### Features
- Feature to update the user details from airtable daily resulting in zero manual intervention in the application
- Headless APIs for event, occurrences, imageupload, user, and profile
- Video compilation with ImageMagic and Linux-ffmpeg
- Feature to create custom events for occasions such as Farewell announcements
- Firebase integration to send notifications
- Slack integration for sending final video compilation

### Getting Started

- ##### Get the latest snapshot
   `git clone https://github.com/karanvalecha/optimize-prime.git`


- ##### Change directory
  `cd optimize-prime`

- ##### Install NPM dependencies
  `npm install`

- ##### Install ffmpeg
  `brew install ffmpeg`

- ##### Install the gems
  `bundle install`

- ##### Start the server
   `rails s`


### Obtaining API Keys
  #### Firebase
  - Create a project on https://console.firebase.google.com/
  - Visit project settings page
  - Visit cloud messaging page
  - Copy server key
  - Set server key in ENV['FIREBASE_SERVER_KEY']
  
  #### Slack
  - Visit https://api.slack.com/apps/
  - Create a slack app
  - Visit app basic details page https://api.slack.com/apps/A01UKQM43TP
  - Click on incoming webhooks in the left side bar under `features.`
  - There is a option provided at the bottom `Add new webhook to workspace`
  - Copy the webhook url
  - Set the webhook url in ENV['SLACK_GENERAL_HOOK']
  
  #### Airtable
  - Contact Airtable administrator
  - Get the key for the currently used Airtable
  - Set the value of key in ENV['KARAN_AIRTABLE_KEY']

### Import data

Run the following task to generate users, their Birthday and work anniversary events, And event's occurrences for the duration of next 1 year.
```
rake users:import
```

### Postman exported collections
- https://drive.google.com/drive/folders/14H7_O1QwE8UcsEy9vVFatjfAIol5JgmV?usp=sharing 


### References
- Slack Integration https://docs.harness.io/article/4zd81qhhiu-slack-notifications
- File.upload slack https://api.slack.com/methods/files.upload/code
- Share video to slack https://clipchamp.com/en/blog/how-to-embed-video-in-slack/#:~:text=Sending%20links%20to%20YouTube%20videos,original%20location%20such%20as%20YouTube.
- pdfgenerator-rails - https://code.tutsplus.com/tutorials/generating-pdfs-from-html-with-rails--cms-22918
