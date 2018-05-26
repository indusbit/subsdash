# Subsdash
Open Source Subscription Analytics

## Developing Subsdash

After you clone the repo, simply install all the gem, create and migrate the database, and start the servers with `Procfile.dev`

```sh
$ bundle install
$ yarn install
$ rake db:create
$ rake db:migrate
$ bundle exec foreman start -f Procfile.dev
```
This will install all the gems and start a development server on port 3000.