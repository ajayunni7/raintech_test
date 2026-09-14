# Raintech Booking App

A modern, responsive room booking application built with Flutter. This project demonstrates clean architecture principles, reactive state management using BLoC, and a beautiful, custom-styled user interface.

## How to Run

Follow these steps to run the application on your local machine:

1. **Get Dependencies:**
   Make sure you are in the project root directory, then run:
   ```bash
   flutter pub get
   ```

2. **Run the App:**
   Connect a device or start an emulator, then run:
   ```bash
   flutter run
   ```

3. **Run Tests:**
   To execute the test suite (unit and widget tests), run:
   ```bash
   flutter test
   ```

## Architecture Overview

This project is structured using **Clean Architecture** principles to ensure separation of concerns, testability, and scalability. It is divided into three main layers:

- **Domain Layer (`lib/domain/`):** Contains the core business logic and entities (e.g., `Room`, `Booking`). This layer is completely independent of Flutter and external dependencies.
- **Data Layer (`lib/data/`):** Responsible for data retrieval and storage. In this implementation, it includes mock data models (`rooms_data.dart`, `bookings_data.dart`) to simulate a backend or database.
- **Presentation Layer (`lib/presentation/`):** Contains the UI components and state management logic.
  - **Widgets & Screens:** Custom, reusable widgets styled with a modern aesthetic (e.g., `BookingScreen`, `DateRangePickerWidget`, `BookingSummaryWidget`).
  - **State Management (BLoC):** Uses the `flutter_bloc` package to manage the application state (`BookingBloc`, `BookingEvent`, `BookingState`). The BLoC acts as the single source of truth, reacting to user interactions (date selection, room selection, guest filtering) and dynamically calculating availability and pricing logic decoupled from the UI.

Additional layers include:
- **Core Layer (`lib/core/`):** Contains shared utilities and business rules, such as `booking_calculator.dart` for date validation and overlap detection, and `currency_formatter.dart` for consistent UI formatting.

## What I'd Improve with More Time

Given more time, I would focus on the following enhancements:

- **Persistence:** Implement local storage (e.g., `shared_preferences` or `sqflite`) or a robust database solution to save user bookings across app restarts.
- **API Integration:** Replace the hardcoded mock data with a real backend integration using `http` or `dio`, fetching live room availability and submitting actual booking requests.
- **Accessibility (a11y):** Enhance Semantic labels across all custom widgets, ensure proper contrast ratios for all states (like disabled items), and test comprehensively with screen readers (TalkBack/VoiceOver).
- **Integration Tests:** Add end-to-end (E2E) UI testing using `integration_test` to verify complete user flows (e.g., picking dates -> filtering -> selecting a room -> confirming booking summary) on real devices.
- **Animations:** Add smooth micro-interactions, such as animated list transitions when filtering rooms, and hero animations when confirming a booking, to elevate the premium feel of the UI.
