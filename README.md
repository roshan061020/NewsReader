# News Reader App

## Overview

The **News Reader App** is a simple and scalable iOS application that allows users to fetch, browse, filter, and bookmark news articles from a public API. It’s designed with a modular structure and follows modern development best practices. Users can view articles, bookmark their favourites, and filter news by categories. It uses **MVVM architecture**, **CoreData** for persistence, and **SwiftUI** for the user interface.

## Features

- Display a list of news articles with titles, descriptions, and thumbnails (when available).
- Filter news by categories. 
- Pagination support for infinite scrolling of large datasets.
- Has a page size of 8 articles and loads more on tap of load more button.
- Bookmark functionality to save articles for future reading using CoreData.
- Smooth transitions between article lists and detailed views.
- In-app WebView for reading full articles.

## Architecture

The app follows the **MVVM (Model-View-ViewModel)** architecture, which separates the UI from the business logic and data fetching, allowing for better scalability and testability. It uses **CoreData** for storing bookmarked articles and **URLSession** for networking.

- **Model**: Defines the data structure for news articles and bookmarks.
- **ViewModel**: Handles data fetching, filtering, and managing states for the views.
- **View**: Displays data in the UI using SwiftUI. Views are updated automatically based on changes in the ViewModel's state.

## Key Technologies

- **Swift**: The primary language used to build the app.
- **SwiftUI**: Used for building the UI in a declarative style.
- **CoreData**: Used to persist articles and bookmark information.
- **URLSession**: For handling network requests to fetch news articles from the API.
- **MVVM Architecture**: Clean separation of concerns between the UI and business logic.
- **SOLID Principles**: Ensuring clean, maintainable, and scalable code.

## Public API

This app uses a public news API to fetch news articles. [NewsAPI](https://newsapi.org/)

**Example API URL**:

## Core Features

1. **News Articles List**
    - Displays a list of news articles with pagination.
    - On error, data is loaded from core data.
    - SDWebImages is used to cache and fetch the images. 
    - Articles are loaded with infinite scrolling.

2. **Article Detail View**
    - Tap on an article to open the full news and then on tap of 'read more' to open complete article in Web view for complete article access.
    - Navigate back to the article list using the back button.

3. **Bookmarking Articles**
    - Users can bookmark articles to read later.
    - Bookmarks are stored using CoreData and persisted across app sessions.
    - A separate view shows all the bookmarked articles.

4. **Filtering News by Category**
    - Users can filter news articles by categories on News Articles List View.
    - Smooth animations are used to transition between category filters.

## Installation

- Clone the repository:

```git clone https://github.com/roshan061020/NewsReader.git```

- Open the Xcode project:
```cd NewsReaderApp```
```open NewsReaderApp.xcodeproj```

- Install the necessary dependencies (SDWebImages)

- Run the App

# Demo video

https://drive.google.com/file/d/1zLcnwhIOAkrRM9_iH2X3usn5daqrYiPv/view?usp=sharing


