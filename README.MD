# **pulse-config**

A simple tool to help configure pulse for higher quality audio on linux using ansible.

Due to some changes to pulse-daemon.conf it will require ubuntu 20+ and fedora 32+.

## How to use

###### First install ansible for your platform.

ubuntu: `./install-ansible-ubuntu.sh`

fedora: `./install-ansible-fedora.sh`

other: https://docs.ansible.com/ansible/latest/installation_guide/index.html

###### Get information for your sound cards

`./get-soundcard-info.sh`

Originally I wanted to have the configuration set itself automatically but due to the wide range of possible configurations it's probably easier for the user to do some decision making.

sample for the Realtek ALC1220 with an HDMI output.

```
Codec: ATI R6xx HDMI
rates [0x70]: 32000 44100 48000
bits [0x2]: 16
Codec: Realtek ALC1220
rates [0x5f0]: 32000 44100 48000 88200 96000 192000
rates [0x7e0]: 44100 48000 88200 96000 176400 192000
bits [0x1e]: 16 20 24 32
bits [0xe]: 16 20 24
Byte Order:                      Little Endian
device.buffering.buffer_size = "65536"
device.buffering.fragment_size = "32768"
```

You can ignore any non primary sound codecs (unless you use them) like the `ATI R6xx HDMI`.
Pick the top two highest rates and highest bits value for your primary device.
In this case `192000`, `176400` and `32` for the `Realtek ALC1220`.

Note the byte order, in this case `Little Endian`, but on some platforms could be `Big Endian`.

also note the `buffer_size` and `fragment_size`

edit the file in `roles/pulse/defaults/main.yml`

set `sample_format` based on the bits you found earlier and the sample format you noted.

for `24` bits on `Little Endian` you would probably want `s24le`


from the man page:
```
Specify one of u8, s16le, s16be, s24le, s24be, s24-32le, s24-32be, s32le, s32be, float32le, float32be, ulaw, alaw. Depending on the endianness of the CPU the formats s16ne,
       s16re, s24ne, s24re, s24-32ne, s24-32re, s32ne, s32re, float32ne, float32re (for native, resp. reverse endian) are available as aliases.
```

then set the `sample_rate` and `alternate_rate` based on what you found earlier.

Now set `buffer_size` and `fragment_size` to what was reported earlier (although it will have no effect with the current configuration)


###### update your pulse configuration

`./run.sh`

## Future Plans

A guided setup would be better than reading the above doc.