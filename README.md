# Hangman
Created as part of [The Odin Project](https://www.theodinproject.com) curriculum.

View on [Github](https://github.com/harmolipi/hangman)

### Functionality

This is the [hangman](https://www.theodinproject.com/courses/ruby-programming/lessons/file-i-o-and-serialization-ruby-programming) project - a basic hangman game, with the ability to save and load game progress.

### Thoughts

This project's functionality was straightforward for the most part, but included a couple new ideas: I/O and serialization. It was fortunately not difficult to figure out how to open, modify, and save files, and likewise the serialization ended up being easy as well. I used [MessagePack](https://github.com/msgpack/msgpack-ruby) to serialize the game saves, since it seems to be more efficient when the file doesn't need to be human-readable. In this case, as we're merely saving data to be loaded into the game later, and not to be read or modified manually in any way, there was no need to use YAML or JSON.

As always, when I completed the project, I felt good about its functionality, but also felt that the code is more complicated than it needs to be. If I return to it, my next step will be to trim it down. But I'm still encouraged, because at the end, each project feels more elegant than the last, and my code less messy - so hopefully I'm moving in the right direction.

God bless.

-Niko Birbilis