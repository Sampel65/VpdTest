# GitHub Repositories Explorer

A Swift-based iOS application that fetches and displays GitHub repositories with a modern, user-friendly interface.

## Features

### Core Features
- Fetches repository data from GitHub API
- Displays repositories in a grid layout
- Shows detailed information for each repository
- Modern and clean UI design
- Error handling with user feedback
- Proper navigation flow

### Advanced Features
- Pull-to-refresh functionality
- Pagination support (infinite scrolling)
- Offline data caching
- Custom search functionality
- Share repository feature

## Technical Implementation

### Architecture
- MVVM (Model-View-ViewModel) architecture
- SwiftUI for UI implementation
- URLSession for networking
- Codable for JSON parsing

### Key Components

1. **Models**
   - Repository: Represents GitHub repository data
   - Owner: Represents repository owner information

2. **Views**
   - ContentView: Main view with repository grid
   - RepositoryDetailView: Detailed view for selected repository
   - CustomSearchBar: Custom search implementation
   - SplashView: App launch screen

3. **ViewModels**
   - RepositoriesViewModel: Manages repository data and business logic
   - NetworkService: Handles API calls and caching

### Features Implementation

1. **Data Fetching**
   - Uses URLSession for API calls
   - Implements proper error handling
   - Provides loading states feedback

2. **UI/UX**
   - Grid layout for repositories
   - Async image loading
   - Pull-to-refresh
   - Infinite scrolling
   - Custom search bar
   - Share functionality

3. **Data Management**
   - Local caching using UserDefaults
   - Pagination implementation
   - Search filtering

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.5+

## Installation

1. Clone the repository
2. Open VpdTest.xcodeproj in Xcode
3. Build and run the project

## API

The app uses the GitHub API endpoint:
```
https://api.github.com/repositories
```

## Credits

Developed by Samson oluwapelumi as a technical assessment for VPD.


https://github.com/user-attachments/assets/bac1c8dd-1b2a-4c9f-b612-bb6300c0a682



