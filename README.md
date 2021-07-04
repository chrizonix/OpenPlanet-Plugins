# TrackMania In-Game Plugins (OpenPlanet API)
[![GitHub Release](https://img.shields.io/github/release/chrizonix/OpenPlanet-Plugins.svg)](https://github.com/chrizonix/OpenPlanet-Plugins/releases/tag/v1.0.0)
[![Github Releases (by Release)](https://img.shields.io/github/downloads/chrizonix/OpenPlanet-Plugins/v1.0.0/total.svg)](https://github.com/chrizonix/OpenPlanet-Plugins/releases/tag/v1.0.0)
[![Github Commits (since latest release)](https://img.shields.io/github/commits-since/chrizonix/OpenPlanet-Plugins/latest.svg)](https://github.com/chrizonix/OpenPlanet-Plugins/compare/v1.0.0...master)
[![GitHub Repo Size in Bytes](https://img.shields.io/github/repo-size/chrizonix/OpenPlanet-Plugins.svg)](https://github.com/chrizonix/OpenPlanet-Plugins)
[![Github License](https://img.shields.io/github/license/chrizonix/OpenPlanet-Plugins.svg)](LICENSE.md)

In-Game Plugin for TrackMania Turbo to Record Scoreboard Updates

## Install / Usage
* Install OpenPlanet for TrackMania Turbo ([openplanet.nl/download](https://openplanet.nl/download))
* Install the Plugins to
  * `C:\Users\[user]\OpenplanetTurbo\Scripts` (for TrackMania Turbo) or
  * `C:\Users\[user]\Openplanet4\Scripts` (for ManiaPlanet 4)
* Launch the TurboCup Recorder App ([chrizonix/TrackMania-Turbo-Cup](https://github.com/chrizonix/TrackMania-Turbo-Cup))
* Launch the Game and Wait for the Main Screen
* Launch the Plugin via `F3 -> Scripts -> Turbo Cup -> Control Panel -> Start`

## How does it work?
* This Plugin records the In-Game Scoreboard every 5 Seconds and
* Sends this Data via WebSocket Requests to the TurboCup Recorder App
* The Tool automatically detects, if a Map is currently running (and only sends data, when racing on an active Map)

## Why?
TrackMania Turbo offers no Dedicated Server, so Scripting for a Racing Event has to be done on client-side.
This Plugin in combination with the TurboCup Recorder App, enables a Race Organizer to Record the Scoreboard of every Player in the Current Session.

Only the Race Organizer has to use this Plugin for Recording, so every Attendee can just join the Server.

## Additional Credits
* [Terminal Application Icon by CB2K, Wikimedia Commons](https://commons.wikimedia.org/wiki/Category:Black_Mac_Style_Icons#/media/File:Dosemu_Mac.png)
