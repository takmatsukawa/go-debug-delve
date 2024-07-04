package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"net/http"
)

func homeHandler(w http.ResponseWriter, _ *http.Request) {
	_, err := fmt.Fprintf(w, "Hello, World!")
	if err != nil {
		return
	}
}

func aboutHandler(w http.ResponseWriter, _ *http.Request) {
	_, err := fmt.Fprintf(w, "About Page")
	if err != nil {
		return
	}
}

func main() {
	r := mux.NewRouter()
	r.HandleFunc("/", homeHandler)
	r.HandleFunc("/about", aboutHandler)
	r.HandleFunc("/favicon.ico", func(w http.ResponseWriter, r *http.Request) {
		http.NotFound(w, r)
	})

	fmt.Println("Starting server on :8080")
	if err := http.ListenAndServe(":8080", r); err != nil {
		fmt.Println("Error starting server:", err)
	}
}
