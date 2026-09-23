# Cyber-Tactile Command Deck

A superhero emergency console built with Flutter. Sentinel-07 can spend energy
on tactical actions, rescue civilians, charge a laser, and recharge the suit.

## Build Challenge

- **Theme:** Superhero command deck responding to a city emergency.
- **State variables:** `energy` tracks the power reserve, `rescues` tracks saved
  civilians, `chargeLevel` controls the laser meter, `shieldActive` controls
  the forcefield state, and `heroStatus` drives the live status banner.
- **Actions:** Laser Blast costs 25 energy, Forcefield costs 15 energy, Rescue
  adds one civilian, and Recharge restores energy to 100.
- **Condition:** After three rescues the interface displays **CITY SAVED!** and
  disables the rescue control. Tactical controls also disable when energy is too
  low, making the Recharge action available.
- **Theme switcher:** The app bar button changes between dark command mode and
  a light console palette.

### Changed UI State

The changed state is represented by the green **CITY SAVED!** status banner and
the disabled Rescue Civilians control after the third rescue.

![City saved state](docs/city-saved-state.png)

## Run

```bash
flutter pub get
flutter run
```