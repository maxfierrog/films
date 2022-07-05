# Flixter

Flixter is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#). I spent about 20 hours working on this, which is pretty sad.

## User Stories

These are some of the features included:

- [X] User sees an app icon on the home screen and a styled launch screen.
- [X] User can view a list of movies currently playing in theaters from The Movie Database.
- [X] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [X] User sees a loading state while waiting for the movies API.
- [X] User can pull to refresh the movie list.
- [X] User sees an error message when there's a networking error.
- [X] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.
- [X] Networking error alert is also presented when refreshing movie data.

Here are some additional features I might implement in the future:

- [ ] User can tap a poster in the collection view to see a detail screen of that movie.
- [ ] User can search for a movie.
- [ ] All images fade in as they are loading.
- [ ] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [ ] Customize the selection effect of the cell.
- [ ] Customize the navigation bar.
- [ ] Customize the UI.
- [ ] Run your app on a real device.

## Video Walkthrough

https://user-images.githubusercontent.com/69845191/174865214-ca5f00cf-f0a7-4b45-a8ac-9ba1b3cde344.mp4

## Notes

The main challenge when making this was becoming familiarized with app development "headfirst". I found I had to google a lot of things, and oftentimes felt like I was "cheating" in some ways. However, it is slowly becoming evident that I am indeed learning. Who would have thought.

## Credits

Libraries:

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

