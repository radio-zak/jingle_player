# jingle_player

A minimal, cross-platform audio player designed for short audio file playout. Designed for broadcast purposes for Technical University of Lodz Student Radio "ŻAK".

## Configuration

The application doesn't need a config file to run - the defaults are provided out of the box. However, there are options to configure the app to your needs.

This application stores its main configuration in a `config.json` file stored in the same folder as the binary. Currently the following keys are supported:

- `appTitle` (string): the title of the application, shown on the top bar. Defaults to "Jingle Player".
- `playerCount` (int): the number of jingle slots shown in app. Maximum supported number is 16. Defaults to 16.
- `paletteCount` (int): the number of user-configurable jingle palettes. Maximum supported number is 8. Defaults to 16.
- `mediaDir` (string): the directory where media files for playout are stored. Defaults to ApplicationSupport directory for each platform (`AppData\Roadming` for Windows, `/.local/share` for Linux)
- `logDir` (string): the directory for log files. Defaults to ApplicationSupport directory.
- `logLevel` (string): how verbose should the logs be. Supported values are "error", "info" and "debug". Default is info.

## Keyboard shortcuts

- keys `1-P` - select jingle for playout (each jingle slot shows the corresponding keyboard character)
- `Space` - play jingle
- `ESC` - stop playback
- `CTRL-E` - toggle edit mode
- `CTRL-<palette number>` - load palette

## Palettes

Each user can create up to 8 palettes with up to 16 jingles in each. By default palette 1 is the default.  
To edit the palette, select the target palette and enter `Edit mode`. In `Edit mode` you can pick files from the filesystem to load into the slots. The files are then copied into the configured `mediaDir`. The palette is saved on `Edit mode` exit. Alternatively, you can save the palette to a new number by clicking on the target palette number while in `Edit mode`.

In case the file picked from the filesystem matches the file already existing in the `mediaDir`, no copy operation is performed - instead the application picks the file from the media directory instead. Should you wish to swap the file, you need to do it manually.

The configuration files are stored per system user in user's `AppData` directory (on Windows) and equivalent.

In `Edit mode` the playout capability is disabled.

This application supports `.wav` files only.

Optimized for display resolutions 1280x720 and higher, beware!

## Playing files

After loading files into jingle slots in `Edit mode`, select the desired jingle. This loads the file into the audio player making it primed and ready for playout.
Press `Space` key on the keyboard or `Play` to play the file.

When the file completes, the queue is cleared and the audio player is ready to accept another jingle for playout. If such a need arises, you can press `Stop` or `Esc` to stop playback immediately.

Alternatively you can pick another jingle during playout - the currently playing jingle will be stopped, and the selected jingle will be armed, primed and ready for playout.

## Feature roadmap

- [x] Implement event logging to file
- [x] Separate intensive backend tasks to isolates
- [ ] `Immediate playback` mode - allowing users to play files immediately on jingle slot selection
- [ ] API for integration with Bitfocus Companion

## License

This application is licensed under AGPL v3.
All copyrights belong to Technical University of Lodz Student Radio ŻAK and contributors. Contributions are welcome.

## Author information

Primary developer: Kacper Zieliński (<kacper.zielinski@zak.lodz.pl>)
