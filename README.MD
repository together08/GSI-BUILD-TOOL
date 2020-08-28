# GSI-BUILD-TOOL

> Just a tool to making GSI and vendor-patch automaticly.

## How to use?

### First, clone this repo:

```bash
git clone https://github.com/together08/GSI-BUILD-TOOL.git --depth=1
cd GSI-BUILD-TOOL
```

### Then, setting up requirements:

```bash
bash setup.sh
```

### Finally, make the GSI:

> May you need to enter sudo password during making.

```bash
# For local ROM, use this command:
./make.sh <Path to firmware> <ROM NAME>
```

## Supported ROMs:

- Generic: Just an normal option, without any changes.
- ZUI: debloat.sh made by PdyLZY@Coolapk, remove the SetupWizard because it doesn't work well on 16:9 devices.
