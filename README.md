![BookWorm icon](/Images&Gifs/BookWormIcon.png)

# BookWorm

## Description

BookWorm app built in SwiftUI displays bestseller lists published every week by the New York Times. Lists are sorted by the fiction and nonfiction genres on a specific date. User can explore each book on the list by clicking on it and thereby displaying its details.

![Whole App Gif](/Images&Gifs/WholeAppGif.gif)

## API

The application uses two APIs:
* the first screen with bestsellers list fetches data from the [New York Times Books API](https://developer.nytimes.com/docs/books-product/1/overview)
* the second screen with book details takes data from [Google Books API](https://developers.google.com/books/docs/v1/using)

## Errors handling

Two types of alerts you may encounter while using the app:
* New York Times API has a call limit of 5 requests per minute. When this limit is exceeded, the following alert will be displayed.

![Error number of requests](/Images&Gifs/ErrorNumberOfRequests.gif)

* the rest of network/server errors (ex. no Internet connection) is handled by general error

![General error](/Images&Gifs/GeneralError.gif)






