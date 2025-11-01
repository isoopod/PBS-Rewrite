# Wiring

General overview of wiring will go here

Wiring is mostly handled from the server. It can be found in `ServerScriptService/PBSServer/Wiring`

## Wiring Types

The types used in the wiring system are mostly found in the `WireType` module.

### WireTypeNames <badge type='info' text='Type' />

```lua
"boolean" | "number" | "string" | "Vector3" | 
"Vector2" | "CFrame" | "Color3" | "BrickColor" | 
"Instance" | "buff_" | "any" | "hidden"
```

A non exhaustive list of types supported natively by the wiring system.  
Any roblox datatype that [can be saved in an attribute](https://create.roblox.com/docs/studio/properties#instance-attributes) is valid, but there are also a few custom types that can be used:

* `buff_` is used internally for [custom datatypes](./CDT.md). These are sent as buffers.
* `any` will accept any valid datatype.
* `hidden` will not show up on the wiring tool. Functions like an input without letting the player modify or see it. This can be used for stuff like radio transmitters where the inputs are set by the WirePart itself. `hidden` functions like `any`.

All of the roblox datatypes (boolean -> Instance) listed here have a datatype icon included natievly. Using something other than these means the icon will show up as unknown unless you define a custom icon for it.  

::: warning
Instance **does not** save but it will work like any other datatype once set.  
If you are looking to reference another WirePart, save its UID as a number or UInt16 wrapped in a custom datatype, and get the WireHandler from `WireTracker.GetWireHandlerFromId(uid)`. If you need the actual WirePart model itself, that can be obtained from `WireHandler.Wirepart`
:::

### `WirePart<T>` <badge type='info' text='Type' />

```lua
T & {
    WireIO: Folder & {
        Inputs: Folder,
        InputTypes: Folder,
        Outputs: Folder,
        OutputConnectionsCache: Folder,
    },
}
```

The WirePart type shows the datamodel structure of a wiring instance. Every WirePart has a WireIO folder, which is used to save and replicate wiring state.  
The subfolders
