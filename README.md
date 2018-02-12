# Rails Remote

A job ad website optimized for remote work

## Deployment

https://devcenter.heroku.com/articles/git

TLDR: Commit changes to the git repo and push them to `git@heroku.com:railsremote.git`

## Admin

Admin pages are located at http://railsremote.herokuapp.com/admin_jobs
There is only one admin account and new ones can not be created.

Username: `superuser`

You can get the password by running the following command in your terminal:

    heroku config --app railsremote | grep ADMIN_PASSWORD

Or going to heroku https://dashboard.heroku.com/apps/railsremote/settings and clicking `Reveal Config Vars`.

You can update the password by running

    heroku config:set ADMIN_PASSWORD=yourNewPassword

Or doing it in the heroku dashboard (link above).

### Admin tasks

#### Moderating

In the admin panel you see a list of all submitted or imported job ads.

- Click `Edit` and make changes to the ad text. Big text blocks accept [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) for formatting.
- Click `Preview` button to see what it looks like.
- If you can see the `All good, make it live` button it means the author has not made the job ad public yet, unless you are the author (or the job was imported) do not click it.
- If the job has been made public by the author, `Admin Publish` button will approve it and make it visible on the website for 1 month

If you want to change the duration of how long it's visible you'll need to change this code `job.update_column(:visible_until, 1.month.from_now)` in `admin_jobs_controller.rb`

#### Importing the ads

**StackOverflow crawler needs to be updated**

There are currently two crawlers that scrape Stack Overflow and WeWorkRemotely.
To invoke them load a heroku database session (an equivalent of `bundle exec rails console` locally):

```
heroku run console
> WeWorkRemotely.call
> StackOverflow.call # Fails at the moment
```

This will populate the admin panel with unpublished and unapproved job ads.
It will also list the moderation links for each imported ad e.g.:

```
-> √. http://railsremote.herokuapp.com/jobs/17829/edit?token=6681e214fc16c22ae67c47cda61d304625e20be1916857929dc64d4ec1c23eb16b922d73815c6f029a2c0c611e2628980064e8f86d6724a774f41178e99377cd50c0eaaa99a7295662575aa0ea520e95b34862f7ba112cb10bae87ffa9350814ba8290d3
-> √. http://railsremote.herokuapp.com/jobs/17830/edit?token=402f22e6d2893d67a74dc15508f5c36975b0d44c6f2fa20a76f03a1463922ea417ea60d90f5ce3bf02ec4d1952cd0a4b331c55a6c69c5529695cb73240854efc426507d6d6664d6c4a9f53d756f6e9c47fed0fda33cb4c3df9eaa9022b89a7af519c690e
```

## Development

This is a typical Ruby on Rails application.

To start it locally you will need `ruby` to be installed.

```
> gem install bundler
> bundle install
> bundle exec rake db:create db:migrate
> ADMIN_PASSWORD=localpassword bundle exec rails server
# This will start an app at http://localhost:3000
```

### Testing

To run the tests:

```
bundle exec rspec
```
