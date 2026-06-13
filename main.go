package main

import (
	_ "embed"
	fmt "fmt"
)
import (
	fiber "github.com/gofiber/fiber/v2"
)

import (
	router "mcods/router"
)

const (
	HOST string = "127.0.0.1"
	PORT string = "3000"
)
var (
	app *fiber.App = fiber.New(fiber.Config{
		Immutable: false,
		DisableStartupMessage: true,
	})
)



func main() {
	hostname := fmt.Sprintf(
		"%s:%s",
		HOST, PORT,
	)


	app.Route("", router.Route)

	fmt.Printf("MCods is running on http://%s\n", hostname)
	app.Listen(hostname)
}