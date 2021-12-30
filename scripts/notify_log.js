#!/run/current-system/sw/bin/env /etc/profiles/per-user/caleb/bin/node
const fs = require('fs');

if (process.env.DUNST_APP_NAME === '') {
  process.exit(0);
}

const data = JSON.stringify({
  id: Number.parseInt(process.env.DUNST_ID, 10),
  dateTime: Math.round(Date.now() / 1000),
  appname: process.env.DUNST_APP_NAME,
  summary: process.env.DUNST_SUMMARY,
  body: process.env.DUNST_BODY,
  category: process.env.DUNST_APP_NAME,
  icon: process.env.DUNST_ICON_PATH,
  urgency: process.env.DUNST_URGENCY,
  progress: process.env.DUNST_PROGRESS,
  stack_tag: process.env.DUNST_STACK_TAG,
  desktop_entry: process.env.DUNST_DESKTOP_ENTRY,
  urls: process.env.DUNST_URLS ? process.env.DUNST_URLS.split('\n') : [],
}) + '\n';

fs.appendFile('/tmp/notify_log.txt', data, (err) => {
  console.error(err);
});