import 'dart:io';

/// This file contains the implementation of the [supportsAnsiEscapes] getter for IO systems.
bool get supportsAnsiEscapes => stdout.supportsAnsiEscapes;
