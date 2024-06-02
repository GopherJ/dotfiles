package main

/*
#include <stdlib.h> // Include C standard library, if necessary
#include <string.h>
*/


import "C"

//export HelloWorld
func HelloWorld() *C.char {
  return C.CString("Hello World")
}


func main() {
}
