import 'dart:io';

// The code below is used to create a method to return the json data
// from the file whose name we provide as input
String fixture(String fileName) {
  return File("test/fixtures/$fileName").readAsStringSync();
}
