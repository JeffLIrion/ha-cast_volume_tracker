[![hacs_badge](https://img.shields.io/badge/HACS-Custom-orange.svg)](https://github.com/custom-components/hacs)

**HACS URL:** [JeffLIrion/ha-cast-volume-tracker](https://github.com/JeffLIrion/ha-cast_volume_tracker)


# Cast Volume Tracker

This component does the following:

* When an individual speaker is off, by default its media player volume will be set to zero -- effectively muting it -- but its "desired" volume level will be retained
* When an individual speaker turns on, its volume level will be set to its desired volume level
  * As a result, you won't hear the "blip" noise when the device turns on
* When a group turns on, the volume for each of its members will be set to the average value of its members (excluding any members provided in its `members_excluded_when_off` parameter)
* During group playback, the volume of all of its members will be kept normalized

The idea is that for all your cast devices, you would setup a `cast_volume_tracker` and replace all `media_player.volume_set`/`mute`/`down`/`up` service calls with `cast_volume_tracker.volume_set`/`mute`/`down`/`up`.  The usage is the same, except that the entity ID should be for the `cast_volume_tracker` instead of the `media_player` (i.e., `cast_volume_tracker.computer_speakers` instead of `media_player.computer_speakers`).


## Configuration

**NOTE:** the names *must* correspond to the names of your cast devices.  In other words, `cast_volume_tracker.computer_speakers` will correspond to `media_player.computer_speakers`.

```yaml
# individual speaker
computer_speakers:
  name: 'Computer Speakers'
  parents:
  - kitchen_speakers

# individual speaker
kitchen_home:
  name: 'Kitchen Home'
  mute_when_off: false
  default_volume_level: 0.16
  parents:
  - kitchen_speakers

# cast group
kitchen_speakers:
  name: 'Kitchen Speakers'
  members:
  - computer_speakers
  - kitchen_home
  members_excluded_when_off:
  - kitchen_home
```

For an individual cast device, the configuration variables are:

* **name** (required): friendly name for the cast volume tracker
* **parents** (optional): groups to which the cast device belongs
* **mute_when_off** (optional, default=`true`): if `true`, when the cast device turns off the volume will be set to 0, effectively muting it; if `false`, the volume will be set to `default_volume_level` (if provided) or left as is
* **default_volume_template** (optional): if provided, the volume for the cast device will be set to this level when the cast is turned off
* **off_script**: a script or sequence of actions to perform when the speaker turns off
* **on_script**: a script or sequence of actions to perform when the speaker turns on

When the configuration variable `members` is provided, the cast volume tracker will be recognized as a group.  For cast groups, the configuration variables are:

* **name** (required): friendly name for the cast volume tracker
* **members**: the object ID's of the group members (e.g., `kitchen_home` for `media_player.kitchen_home`)
* **members_excluded_when_off** (optional): when turning the group on, the volume for all speakers will be set to the average of the values of the cast volume trackers *not* included in this list
* **members_start_muted** (optional): when turning the group on, these members will be muted
* **off_script**: a script or sequence of actions to perform when the speaker turns off
* **on_script**: a script or sequence of actions to perform when the speaker turns on

The file [switches.yaml](./example_config/switches.yaml) demonstrates how to create switches for muting/un-muting `cast_volume_tracker` entities.

The file [input_numbers.yaml](./example_config/input_numbers.yaml) demonstrates how to setup `input_number`s (using the custom [`input_number`](https://github.com/JeffLIrion/ha-input_number) component) that will track the value of a `cast_volume_tracker` when its state changes and change the value of a `cast_volume_tracker` when its value is changed.
