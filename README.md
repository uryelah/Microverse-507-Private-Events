<!--
This is the first project of the Ruby on Rails section of the Microverse course	*** Thanks for checking out this README Template. If you have a suggestion that would
<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://www.microverse.org/">
    <img src="./doc/microverse.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Private Events</h3>

  <p align="center">
This is an events site project, similar to Eventbrite, done with ruby on rails which allows users to create events, send invites to their hosted or attending events and confirm their presence for the events they were invited to. 
- Sign up and login to access the events, invites and users routes.
- Create an event and send invites to other users
- Receive and accept an invite to an event to be able to attend it and send invites for it
- Cancel your attendance to an event to destroy your invitation
- An event envite cannot be sent to it's creator
- An user cannot send an invite to an event held past the current time

<br />
  </p>
</p>

<!-- ABOUT THE PROJECT -->
## About The Project

From the [Odin Project](https://www.theodinproject.com/courses/ruby-on-rails/lessons/associations): 
You want to build a site similar to a private Eventbrite which allows users to create events and then manage user signups. Users can create events and send invitations and parties (sound familiar?). Events take place at a specific date and at a location (which you can just store as a string, like “Andy’s House”).

A user can create events. A user can attend many events. An event can be attended by many users. This will require you to model many-to-many relationships and also to be very conscious about your foreign keys and class names (hint: you won’t be able to just rely on Rails’ defaults like you have before).

### Built With
This progam was made using this technologies

* [Ruby on Rails](https://www.ruby-lang.org/en/)
* [Heroku](https://heroku.com/)
* [Rubocop](https://github.com/rubocop-hq/rubocop)
* [Stickler](https://stickler-ci.com/)



## Getting Started
To get a local copy up and running follow these simple example steps.
### Prerequisite Instalations
* Ruby
* Rails
You can easily install Ruby on your Linux computer by using [Homebrew](https://docs.brew.sh/) and [Chruby](https://github.com/postmodern/chruby)
```sh
brew install chruby
brew install ruby-install
ruby-install ruby
```
After that make sure to install rails simply by writting ```gem install rails``` on the console. 
Check that rails was installed by writting ```rails -v``` and you should get an output similar to ```Rails 4.2.4``` with your rails version.

### Installation

Clone this repo ```git clone https://github.com/jairjy/Microverse-504-Micro-Reddit.git``` 
Then intall the required gems with ```bundle install``` followed by ```bundle update```

Migrate the database to your machine with ```rails db:migrate```

You can test the API in the rails console. Access it with ```rails console```

## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact


* Sarah Uryelah: [Github](https://github.com/uryela), [Twitter](https://twitter.com/uryela
)

* Jair Jaramillo: [Github](https://github.com/jairjy), [Twitter](https://twitter.com/jairjy)

Project Link: [Private Events](https://github.com/jairjy/Microverse-504-Micro-Reddit/tree/micro-reddit)

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [Microverse](https://www.microverse.org/)
* [The Odin Project](https://www.theodinproject.com/)
* [Rails Guide](https://guides.rubyonrails.org)