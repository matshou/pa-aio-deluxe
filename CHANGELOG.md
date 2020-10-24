# Changelog

All notable changes to this project will be documented in this file.

## [Version 6.4](https://github.com/yooksi/pa-aio-deluxe/releases/tag/v6.4)

[Full Changelog](https://github.com/yooksi/pa-aio-deluxe/commit/f6823defcf9e30c7989c647676e8802d6be3d5ec)

### Object

- Re-design Sink and Mirror object:
	- Remove mirror from object texture.
	- Slightly reduce object scale.
	- Improve texture color blending.
	- Rename object to better reflect its intent.
	- Remove object entry from some room requirements.

- Slightly reduce Bathroom Sink object scale.
- Re-texture and re-scale Bookshelf object.
- School Desk no longer requires Education research.
- Add Outdoor Table to Canteen room requirements.
- Exclude Table Football, Table Tennis and Pool Table from Common Room grading.

### Fixes

- Fix Comfy Bed object changes not being applied.
- Fix incorrect Cell grading entry (office desk).
- Fix some Common Room grading entries displayed as `none`.
- Fix some room grading multi entries not recognized.
- Fix malformed Yard grading entries (not recognized).
- Fix Staff door object displayed as Bookshelf when carried by workmen.
- Fix minor Bunkbed tooltip text mistake (decrease rate).
- Fix Groundskeeping localization typo.

### Other

- Remove some visitation grant objectives.
- Provide more info about deployment and prioritization through tooltips.
- Remove lower quality staff name entries from `staffnames.txt`.


## [Version 6.3](https://github.com/yooksi/pa-aio-deluxe/releases/tag/v6.3)

[Full Changelog](https://github.com/yooksi/pa-aio-deluxe/commit/95276ad5ad0097f84f69fb1f03d2559f03a2dc36)

### Features

- <details>
	<summary>Add <b>clone</b> and <b>move</b> tools.</summary>
	<ul>
		<li>You can easily select a room and clone or move it.
		<li>Several modes of cloning are at your service.
		<li>You can also move or rotate objects.
	</ul>
</details>
	
- <details>
	<summary>Add <b>Faster Sleep Time</b> feature to speed up sleep time.</summary>
	<ul>
		<li>Enable this feature in the warden context menu.
		<li>Cheat mode is <b>required</b> for this feature to work.
	</ul>
</details>
	
- <details>
	<summary>Foremans can now change floor material and terrain.</summary>
	<ul>
		<li>Cheat mode is <b>required</b> for this feature to work.
		<li>Works in the following tile range:
		<ul>
			<li>Borders
			<li>Grids (every 10 meters)
			<li>Other outdoor tiles.
		</ul>
	</ul>
</details>
	
- <details>
	<summary>Lawyers can now earn your prison money from visitors.</summary>
	<p>Visitation is still good for you even when phone booths can easily satisfy family needs.</p>
</details>
	
- <details>
	<summary>Added <b>Muster Guards</b> feature.</summary>
	<p>Summons guards to a single location helping you deal with tough prisoners.</p>
</details>

### Object

- Fixed or improved many orientation issues with objects.
- Added **Medicine Cabinet** object which can provide first aid and call doctors if needed.
- Drinking machines can now replenish staff energy.
- <details>
	<summary>CCTV cameras can now be upgraded to sort prisoners if they are snitchers or gang members.</summary>
	<p>This should result in a decrease in murder and fight incidents</p>
</details>

### Interface

- Improved misconduct visibility by adding a large red marker when a prisoner starts to misbehave.
- Included *Re-offending chance* information in prisoner tooltip.
- Added a lot of helpful information to many other game tooltips.

### Room

- Redesigned room configurations.
- <details>
	<summary>Removed room zoning indoor requirement.</summary>
	<ul>
		<li>This requirement required foundation and walls to be built before the room could be zoned.
		<li>Now you can freely plan your prison before dealing with foundations, walls and doors.
	</ul>
</details>

### Health

- Food policy and exercising on weights bench now influence prisoners health. 
- Unhealthy prisoners will receive random damage to simulate bad health.
- Doctors are now far busier and healing costs money, making injures non-trivial issues.

### Other

- <details>
	<summary>Improve existing grants and added new grants</summary>
	<p>Grants should now provide more player guidance and make you favour low re-offending rate and minimal guards.</p>
</details>
