# Cast Volume Tracker

This component does the following:

* When an individual speaker is off, by default its media player volume will be set to zero -- effectively muting it -- but its "desired" volume level will be retained
* When an individual speaker turns on, its volume level will be set to its desired volume level
  * As a result, you won't hear the "blip" noise when the device turns on
* When a group turns on, the volume for each of its members will be set to the average value of its members (excluding any members provided in its `members_excluded_when_off` parameter)
* During group playback, the volume of all of its members will be kept normalized

The idea is that for all your cast devices, you would setup a `cast_volume_tracker` and replace all `media_player.volume_set` service calls with `cast_volume_tracker.volume_set`.  The usage is the same, except that the entity ID should be for the `cast_volume_tracker` instead of the `media_player` (i.e., `cast_volume_tracker.computer_speakers` instead of `media_player.computer_speakers`).


## Configuration

For configuration information, see the [README](https://github.com/JeffLIrion/ha-cast_volume_tracker/blob/master/README.md#configuration).
