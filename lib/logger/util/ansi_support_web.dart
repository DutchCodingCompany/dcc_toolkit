/// This file contains the implementation of the [supportsAnsiEscapes] getter for Web systems.
///
/// Browser consoles do not interpret ANSI escape sequences, so they are disabled.
bool get supportsAnsiEscapes => false;
