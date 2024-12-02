# Classroom App - Launch Screen Images

This directory contains the launch images for the **Classroom** app, which are displayed on the launch screen when the app is first opened.

## Overview

The launch images are shown briefly while the app is loading. These images are necessary for different iPhone and iPad screen sizes and resolutions. This setup ensures a smooth user experience when transitioning from the app icon to the main UI.

## Image Set Details

This folder contains the following images:

- **LaunchImage@1x.png**: Used for devices with lower resolution screens (iPhone 4, iPhone 5, etc.).
- **LaunchImage@2x.png**: Used for devices with mid-resolution screens (iPhone 6, 7, 8).
- **LaunchImage@3x.png**: Used for high-resolution screens (iPhone X, 11, 12, 13, etc.).

Make sure to add your own images with the appropriate resolutions for each device size. These images should follow the aspect ratio of the launch screen layout to ensure a consistent look across devices.

## Design Recommendations

- The **Classroom app's logo** or branding should be featured on the launch screen. Use simple, static elements like a logo, app name, or background to match the app's theme.
- The launch screen should not contain any interactive or dynamic elements.
- The image should be **centered** to ensure that it looks great on all screen sizes.
- Avoid adding too much text or other elements that may not look good on various devices.

## Usage

These images are used for the **launch screen** and are displayed while the app is starting. Once the app is loaded, the main user interface (managed by Flutter) will take over and appear to the user.

## Notes

- The launch image is intended to provide a quick, visually appealing introduction to the app while it loads.
- Avoid complex animations or content, as the launch screen should be simple and static.
- Ensure that the launch image complements the **Classroom app's branding** for a smooth user experience.
