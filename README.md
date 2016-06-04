# Maximum concurrency queue in Swift

This repo has a quick demo of a class implementing a
queue which allows for a certain number of concurrently
executing tasks. This is typically used to protect
a resource that only allows a certain number of concurrent
connections. Otherwise GCD is pretty good at managing
active numbers of tasks on its own.

Running this application, you'll see:

- `Hello, World!` printed to the console.
- One hundred instances of `Task: N` printed to the console in (by default) batches of five.
- `Goodbye, World!` as the program terminates.

As you've probably guessed, the maximum concurrency set up
in the demo in `main.swift` is five.
