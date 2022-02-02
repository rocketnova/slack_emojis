# Teeny docker container to download emojis from Slack

From https://gist.github.com/lmarkus/8722f56baf8c47045621

Modified @griffero's ruby script from https://gist.github.com/lmarkus/8722f56baf8c47045621?permalink_comment_id=4020434#gistcomment-4020434

⚠️ Use only in moderation on Slack workspaces that you have permission to access! ⚠️

## How to Run

1. Make sure `docker` and `docker-compose` are installed
2. Download the list of emojis as a JSON file (see below) and save the file as `./app/emojis.json`
3. Run `docker-compose up --build` to build the image and start the container in the foreground
4. Watch the logs as emojis are downloaded
5. To stop the container early, use `Ctrl-C`; otherwise, the container should gracefully exit once it's done
6. Check the logs to see if any downloads encountered network errors and download manually following the directions in the log, which should say something like `Manually download using: curl -o <filename> <url>`
7. Files will be saved to the `output` folder

## Getting the list of emojis

Extract the JSON list of emojis as directed in the gist linked at the top of this file.

However, if you have issues with the methods described there, try the following (directions for Firefox):

1. Navigate to `https://<workspace>.slack.com/customize/emoji` (you must have permission to access this page)
2. Open the Network pane in the browser's developer tools and refresh
3. Click on filename that starts with `emoji.adminList` or `emoji.list`
4. In the side panel, click on the "Response" tab
6. If the `count` is less than or equal to the `total`: toggle "Raw" to true, copy the JSON, and save to a file
5. If the `count` is less than the `total` (adapted from https://gist.github.com/lmarkus/8722f56baf8c47045621?permalink_comment_id=3535987#gistcomment-3535987):
    1. Note down what the `total` is
    2. Right click on the filename that starts with `emoji.adminList` and click "Edit and resend"
    3. Edit the "Request Body" so that `Content-Disposition: form-data; name="count"` is set to the `total`
    4. Click "Resend"
    5. Click on the new network request that was just sent
    6. Click on the "Response" tab and toggle "Raw" to true
    7. Copy the JSON and save to a file
