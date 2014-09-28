Trailmix
========

What is this?
-------------
This is source code behind [Trailmix], a private place to write.

Every day, Trailmix sends you an email asking how your day went. Simply reply
to that email, and a journal entry is created.

To encourage you to write, and to provide a delightful reminiscence, each
prompt email contains a previous entry chosen at random.

![homepage](https://cloud.githubusercontent.com/assets/65323/4453095/ccb7bb0c-4853-11e4-973f-5c54d0b18eda.png)

[Trailmix]: https://www.trailmix.life

Caveat emptor
-------------

This source code is very much provided as-is.

We hope you find it useful to see the source code behind a production
application that real people are paying for.

You are welcome to do what you like with this code, including running your own
instance of it. However, please know that our development time is limited, so
we're unable to spend time helping you make it work.

Who wrote this?
---------------

[Chris] and [Ben] did.

[Chris]: http://twitter.com/chrishunt
[Ben]: http://twitter.com/r00k

Contributions
-------------

Our goal is to keep the functionality of this app very focused. Please ask
before opening a pull to add features.

That said, if you find a bug, please do open an issue!

Getting Started
---------------

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup


(Note: the final steps of this script will fail, because you don't have access
to our heroku application.)

The script also assumes you have a machine equipped with Ruby, Postgres, etc.
If not, set up your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

After setting up, you can run the application using [foreman]:

    % foreman start

If you don't have `foreman`, see [Foreman's install instructions][foreman]. It
is [purposefully excluded from the project's `Gemfile`][exclude].

[foreman]: https://github.com/ddollar/foreman
[exclude]: https://github.com/ddollar/foreman/pull/437#issuecomment-41110407

Guidelines
----------

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)
