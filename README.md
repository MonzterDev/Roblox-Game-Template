# Roblox-Game-Template 🚀

This Roblox Game (Luau) template uses a [module framework](https://monzter.dev/lessons/the-module-framework/) and includes the following commonly used libraries:
- [ProfileService](https://github.com/MadStudioRoblox/ProfileService/)
- [Cmdr](https://github.com/evaera/Cmdr/)
- [Net](https://github.com/roblox-aurora/rbx-net)
- [Reflex](https://github.com/littensy/reflex)
- [Format Number](https://devforum.roblox.com/t/311-formatnumber-a-module-for-formatting-numbers/)
- [React](https://github.com/Roblox/react-lua)
- [and more!](https://github.com/MonzterDev/Roblox-Game-Template/blob/master/wally.toml)

I've also created another version for [TypeScript](https://github.com/MonzterDev/Roblox-TS-Template) users!

## Versions 🖖

I've created two versions which are seperated using branches.

### Simple (Current)
The simple version is tailored towards the common Roblox developer.
- Uses a *simpler* method of managing state.
- Uses guis made inside of Roblox Studio, rather than React.

### [Standard](https://github.com/MonzterDev/Roblox-Game-Template/)
The standard version is tailor towards slightly more advanced developers.
- Uses Reflex to manage state.
- Uses React for creating guis.

## Instructions 🛠️

### Game File 📁
You can easily grab a copy of this template and hop directly into Roblox Studio to begin your next project by doing the following:

1. Visit the [releases page](https://github.com/MonzterDev/Roblox-TS-Template/releases).
2. Locate the **Assets** section towards the bottom.
3. Download either of the `.RBXL` game files.
4. Open the game file to launch into Roblox Studio.

### Rojo 🔃
Make sure you have the following requirements:

- [Rojo](https://rojo.space/docs/v7/getting-started/installation/)
- [Aftman](https://github.com/LPGhatguy/aftman#installation)
- [Wally](https://wally.run/install)

Follow these steps to setup the project:

1. Clone this repo `git clone https://github.com/MonzterDev/Roblox-Game-Template.git`.
2. Use Wally to install the libraries `wally install`.
3. Open a new project inside of Roblox Studio.
4. Use Rojo to sync Visual Studio Code with Roblox Studio.

## Resources 📚

- [Module Framework](https://monzter.dev/lessons/the-module-framework/)
- [ProfileService](https://github.com/MadStudioRoblox/ProfileService/)
- [Cmdr](https://github.com/evaera/Cmdr/)
- [Net](https://github.com/roblox-aurora/rbx-net)
- [Reflex](https://github.com/littensy/reflex)
- [Format Number](https://devforum.roblox.com/t/311-formatnumber-a-module-for-formatting-numbers/)
- [React](https://github.com/Roblox/react-lua)
- [t](https://github.com/osyrisrblx/t)
- [Signal](https://sleitnick.github.io/RbxUtil/api/Signal/)
- [Sift](https://github.com/cxmeel/sift)
- [Viewport Fitter](https://devforum.roblox.com/t/viewportframe-model-fitter/1345611)
- [React Reflex](https://github.com/littensy/react-reflex)

## Features 🎮

- Player data system using ProfileService.
- State is managed and synced from the Server to Client.
- Currency labels UI created and hooked into the State.
- Cmdr terminal accessible via F2 key.
- Utilize the AdjustBalance command from Cmdr to adjust a player's currency amount.
