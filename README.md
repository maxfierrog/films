# Flixter

Flixter is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#). I spent about 20 hours working on this.

## User Stories

These are some of the features included:

- [X] User sees an app icon on the home screen and a styled launch screen.
- [X] User can view a list of movies currently playing in theaters from The Movie Database.
- [X] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [X] User sees a loading state while waiting for the movies API.
- [X] User can pull to refresh the movie list.
- [X] User sees an error message when there's a networking error.
- [X] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

Here are some additional features I might implement in the future:

- [X] Networking error alert is also presented when refreshing movie data.
- [ ] User can tap a poster in the collection view to see a detail screen of that movie.
- [ ] User can search for a movie.
- [ ] All images fade in as they are loading.
- [ ] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [ ] Customize the selection effect of the cell.
- [ ] Customize the navigation bar.
- [ ] Customize the UI.
- [ ] Run your app on a real device.

Some things I would like to get better at are:

1. Modularization: How to write less boilerplate by potentially writing a Utils class.
2. UI Workflow Overview: How the main moving parts of an iOS project work together (views, controllers, outlets, classes, frameworks, etc.)

## Video Walkthrough

Here's a video showing some of the app's UI and functionality:

https://user-images.githubusercontent.com/69845191/174865214-ca5f00cf-f0a7-4b45-a8ac-9ba1b3cde344.mp4

## Notes

The main challenge when making this was becoming familiarized with app development "headfirst". I found I had to google a lot of things, and oftentimes felt like I was "cheating" in some ways. However, it is slowly becoming evident that I am indeed learning.

## Credits

Libraries:

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
