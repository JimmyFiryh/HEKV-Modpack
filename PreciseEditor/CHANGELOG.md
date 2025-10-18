## CHANGELOG

1.5.0
	Adoption by LGG
	Added ToolbarController
	Added AssemblyVersion.tt
	Added InstallChecker
	Added code to set defaults if cfg file is missing

### 1.4.1
- Recompiled for KSP 1.11.0
- Added a "zero" button to revert all angles to 0

### 1.4.0
- Recompiled for KSP 1.9.0
- Added /10 and x10 buttons for - / + values (Requested by flart)

### 1.3.3
- Moved PreciseEditor.cfg in PluginData directory.
- New Icon.

### 1.3.2
- Recompiled for KSP 1.8.1

### 1.3.1
- Recompiled for KSP 1.8.0

### 1.3.0
- Part Edition Window configuration automatically saved in a cfg file.
- Removed the Tweakables window since tweakables precision editing is now stock.
- Struts and fuel lines can be edited on both ends.
- Added the Attachment Rules window where surface attachment rules can be edited. Now you can surface attach anything !
- Pressing P while a part is selected but not attached will edit that part. Useful to edit attachment rules before attaching the part.
- New icon.

### 1.2.0
- Changed max number of input digits from 14 to 8.
- Tweaking Thrust Limiter now update DeltaV information.
- Corrected windows position with UI scaling other than 100%.
- Moved tweakables and colliders information in separate windows which can be toggled on/off.
- A button to switch between Absolute and Local mode has been added. Less rows needed.
- Position and Rotation values are color coded like the offset and rotation gizmos.
- The axis of the used coordinate system are shown on the selected part.
- Basic editor bounds check when setting position.

### 1.1.1
- Recompiled for KSP 1.7.0

### 1.1.0
- The part name is now the same as the one on the right click menu (ex. : Mk1 Command Pod) and is on the window title.
- Added new informations on the collider bounds of the current part regarding its position, extends and size.
- Added new informations on the distance between the current part and the part under the cursor.
  Also we have the distance between collider bounds and if they intersect.
  It's now possible to make kerbal mechanical devices with perfect precision !

### 1.0.3
- Fixed a mirror symmetry counterpart bug.
- Tweakable fields are now found dynamically instead of having a fixed list (Thanks to Canisin for that contribution).
- Position and Rotation become Absolute Position and Absolute Rotation.

### 1.0.2
- Support for KSP-AVC.
- Fixed a NullReferenceException when used with mods that change part modules. Window was not opening in that case.
- Do not reset Part Edition Window position when pressing P on a part while the Part Edition Window is already opened.

### 1.0.1
- Adjusted keyboard control lock.
- Fixed the Z SetRotation rotating around the Y axis.
- Update editor gizmo position and rotation.
- Fixed a mirror symmetry rotation bug.
- Fixed a NullReferenceException when clicking the new or load craft button while the Part Edition Window was open.

### 1.0.0
- Recompiled for KSP 1.6.0
- Part Edition Window can edit Authority Limiter, Thrust Limiter, Gimbal Limit, Decouple Force Percent, Deploy Limit, Light RGB,
  Parachute Min Pressure, Altitude, Spread Angle, Wheels Brakes, Friction, Spring, Damper, Drive Limiter, Traction Control with
  greater precision.

### 0.2.0
- Recompiled for KSP 1.5.1

### 0.1.2
- Updated Licence to GPL 3.0

### 0.1.1
- Fixed a Null Reference Exception when the part in the Part Edition Window was deleted. Now the Part Edition Window is automatically closed if its part is detached or the vessel root is deleted.

### 0.1.0
- First release