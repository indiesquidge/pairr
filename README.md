# Pairr (/per-r/)

Turing School Final Assessment

We had 24 hours to build a fully-functional and tested web application that acted as _"tinder for programmers"_

The criteria for the feature set can be seen [here](https://gist.github.com/worace/6cace9638351f8f9ac8b)

### Thoughts

For myself, the hardest part of designing the application was the
architectural relationships between users when they were matched and
whether or not they "approved" or "rejected" each other. When a user
matches with another user, the database needs to know they've seen each
other so as to not attempt to match them again.

To keep track of which users have already seen each other, I kept an
ActiveRecord column of type array that, for any given user, would
initially hold all other user ids in the database. This would be applied
to each user upon their creation and then randomized to shuffle their
perspective matches. Each time the current user matched with someone else,
that user's id would be removed from the current user's potential matches
array attribute. The problem here, which I unfortunately ran out of time
to solve, was when new users were coming into the site, how to add them
to all other user's potential matches array.

The second half of this issue was how to store a "potential match" between
users. I used a `match` model containing columns for the current user's id, the
potential match user's id, and a match status, which was set to pending when a
user "approved" of the match, and rejected if they "rejected" the match. When
the second user came around, if they too "approved" of the match (setting the
match status to pending from there end as well), the match would immediately
change to "approved", and both users would be notified of their love for each
other.

Had I more time, I would have liked to refactoring the matches_controller#update
method which is push 20 lines of code...not pretty. A lot of the logic could be
pushed down into the model or even parsed out into it's own separate object. My
spec harness is also less than optimal. Always room for improvement.

### Installation

clone and bundle
```shell
git clone https://github.com/indiesquidge/pairr; cd pairr
bundle install
```

database setup
```shell
rake db:create db:migrate db:seed
```
(seed data file found [here](https://gist.github.com/worace/f5518e5f061202671e66))
