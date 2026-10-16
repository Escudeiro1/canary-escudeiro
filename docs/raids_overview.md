# Raids Overview (canary1511)

*Snapshot: 2026-10-16. Regenerate the legacy table if `raids.xml` changes.*

Canary runs **two independent raid systems** side by side (plus a mostly broken fixed schedule). They do not know about each other and **can run at the same time**, even in the same area.

| | Legacy XML | Lua `Raid` |
|---|---|---|
| Registry | `data-otservbr-global/raids/raids.xml` | `data-otservbr-global/scripts/raids/**.lua` |
| Engine | `src/lua/creature/raids.cpp` (C++) | `data/libs/systems/raids.lua` + `encounters.lua` |
| Check | every 60s, C++ dispatcher | every 1m, `raids.check.onThink` globalevent (`data/scripts/globalevents/raids.lua`), stops 1h before server save |
| Concurrency | **one legacy raid at a time** + global `margin` gap | each raid independent; many can run at once |
| Persistence | none — every reboot resets everything | KV (`raids.<name>`): last occurrence, failed attempts, checks today, trigger-when-possible |
| Repeat | `repeat` attr defaults to **false** → each raid fires **at most once per boot** | governed by `minGapBetween` |
| Player requirement | **none** (fires with 0 players online) | `minActivePlayers` (non-idle < 5 min) |
| Spawned monsters | normal monsters, never cleaned up | **all flagged `setRewardBoss()`** (reward-chest loot); cleanup optional (`addRemoveMonsters()` / `timeLimit`), unused today |
| Discord webhook | no | yes on every `addBroadcast` (`discordWebhookURL` is empty today) |
| Disable switch | `disableLegacyRaids = true` in `config.lua` | — |

## Triggering

- **Automatic** — both schedulers start at boot.
- **GM:** `/raid <name>` (god). Checks Lua `Raid.registry` first, then legacy via `Game.startRaid(name)`. `/simraid` simulates Lua chance settings.
- **Lua:** `Game.startRaid("Orshabaal")` → legacy only. Returns `RETURNVALUE_NOERROR`, `RETURNVALUE_NOSUCHRAIDEXISTS` or `RETURNVALUE_ANOTHERRAIDISALREADYEXECUTING`. Bypasses margin/chance; does **not** remove the raid from today's rotation.
- **Reload legacy XML:** `/reload raids` or `kill -HUP <canary pid>` (also restores raids already consumed today).
- Legacy names are the `name` attribute in `raids.xml`, case-insensitive (`/raid zulazza the corruptor` works).

## Legacy XML raids

### Format

```xml
<!-- raids.xml -->
<raid name="Cyclops" file="thais/cyclops.xml" interval2="500" margin="30" />   <!-- optional repeat="yes" -->

<!-- thais/cyclops.xml -->
<raid>
  <announce delay="1000" type="event" message="Let da mashing begin! Cyclops riot east of Thais." />
  <singlespawn delay="60000" name="Orshabaal" x="33118" y="31699" z="7" />
  <areaspawn delay="1000" fromx="32440" fromy="32223" fromz="7" tox="32474" toy="32266" toz="7">
    <monster name="Cyclops" amount="5" />            <!-- or minamount/maxamount -->
  </areaspawn>
  <!-- also supported: areaspawn centerx/centery/centerz + radius, <script delay=".." script="x.lua"/> -->
</raid>
```

- `delay` = ms **from raid start** (absolute, not relative); minimum 1000.
- `interval2` = average minutes between starts; `margin` = minutes since the **last legacy raid of any kind** ended.
- Raid "ends" right after its last event; monsters stay.
- `areaspawn` tries up to 10 random tiles per monster.
- Features actually used by the registered files: 116 `announce` (all `type="event"`), 29 `singlespawn`, 92 rectangle `areaspawn`. No `radius`, no `minamount/maxamount`, no `script`.

### Scheduler

Each 60s, if no legacy raid is running: walk the list **top to bottom**; for each raid whose `margin` has passed, roll the chance; first success starts and (without `repeat`) is removed from the list until the next boot.

**Randomness bug (fixed in source 2026-10-16, needs restart to go live):** `raids.cpp:124` computed `MAX_RAND_RANGE * interval` in 32-bit → overflow → ~100% chance for every raid (Feroxa ~50%). Raids fired as a fixed daily rotation ordered by margin/list position. Fixed formula: chance per check = `60 / (interval2 × 60)` computed in 64-bit. The "Chance/check" column below is the **fixed** value.

With the fix, the overall pace barely changes (all eligible raids together ≈ 10%/min, so *some* raid starts ~10 min after the margin elapses), but **which** raid fires is now random, weighted toward lower `interval2`. Combined with once-per-boot and the 06:05 daily restart, the 1440-interval bosses appear roughly 1 day in 4–6.

### Registered raids

| City | `/raid` name | File | interval2 | margin | Chance/check | Spawns | First announcement |
|---|---|---|---|---|---|---|---|
| abdendriel | `Badger` | `abdendriel/badger.xml` | 500 | 60 | 0.200% | 100× Badger | *(no announcement)* |
| abdendriel | `WarWolf` | `abdendriel/warwolf.xml` | 500 | 30 | 0.200% | 55× Wolf, 70× War Wolf | Many aggressive beasts are roaming south of Ab'Dendriel! Take care! |
| abdendriel | `WaspBear` | `abdendriel/wasp_bear.xml` | 500 | 40 | 0.200% | 30× Wasp, 30× Bear | Forrest animals spread out close to Ab'Dendriel! |
| abdendriel | `Dragons` | `abdendriel/dragons.xml` | 500 | 80 | 0.200% | 8× Dragon, 12× Dragon Hatchling, 4× Dragon Lord | There are dragons rising in Draconia! |
| ankrahmun | `Bonebeast` | `ankrahmun/bone_beast.xml` | 500 | 70 | 0.200% | 15× Bonebeast | Bonebeasts are rattling down in the Ankrahmun Dipthrah tombs. |
| ankrahmun | `Cobra` | `ankrahmun/cobra.xml` | 500 | 70 | 0.200% | 25× Cobra | There's something sizzling in the Ankrahmun Dipthrah tombs. |
| ankrahmun | `Gargoyle` | `ankrahmun/gargoyle.xml` | 500 | 70 | 0.200% | 15× Gargoyle | There is something stony moving down in the Ankrahmun Rahemos tombs. |
| ankrahmun | `Nomad` | `ankrahmun/nomad.xml` | 500 | 70 | 0.200% | 320× Nomad | Nomad scouts have been sighted close to the gates to Ankrahmun. |
| ankrahmun | `Scarab` | `ankrahmun/scarab.xml` | 500 | 60 | 0.200% | 50× Larva, 30× Scarab, 16× Ancient Scarab | Unusual frequent scarab sightings at the gates of Ankrahmun |
| ankrahmun | `Terramite` | `ankrahmun/terramite.xml` | 500 | 70 | 0.200% | 30× Terramite | Something is moving under the surface in the sand north of Ankrahmun! |
| carlin | `OrcWoods` | `carlin/orc.xml` | 500 | 80 | 0.200% | 50× Orc, 20× Orc Berserker, 15× Orc Leader, 15× Orc Shaman | Some Orcs are assembling in the woods between Carlin and Northport. |
| chayenne | `Chayenne` | `chayenne/chayenne.xml` | 1440 | 170 | 0.069% | 1× Chayenne | An immense force is approaching Draconia. |
| darashia | `Lions` | `darashia/lions.xml` | 500 | 70 | 0.200% | 15× Lion, 1× Zomba | There are more lions than usual west of Darashia. |
| darashia | `Minos` | `darashia/minotaurs.xml` | 500 | 100 | 0.200% | 30× Minotaur, 25× Minotaur Guard, 30× Minotaur Mage | Minotaurs are preparing an attack in the Darashia Minotaur pyramid! |
| darashia | `Necropharus` | `darashia/necropharus.xml` | 1440 | 110 | 0.069% | 1× Necropharus | Beware of Necropharus! |
| darashia | `Pirates` | `darashia/pirates.xml` | 500 | 90 | 0.200% | 20× Pirate Buccaneer, 15× Pirate Cutthroat, 15× Pirate Marauder | Pillage and plunder! Pirates have been sighted north of Darashia!. |
| darashia | `Priestesses` | `darashia/priestesses.xml` | 500 | 70 | 0.200% | 25× Priestess | The priestesses in Drefia are preparing a black celebration. |
| darashia | `Undead Darashia` | `darashia/undead_darashia.xml` | 500 | 70 | 0.200% | 25× Vampire, 30× Stalker, 35× Skeleton, 35× demon skeleton, 25× bonelord, 25× necromancer, 25× bonebeast | Sightings of undead, west of Darashia! Imminent invasion is suspected! |
| edron | `Feroxa` | `edron/feroxa.xml` | 430 | 81 | 0.233% | 1× Feroxa | An ancient evil is awakening in the grimvale mines. |
| edron | `GoEdron` | `edron/goblins.xml` | 500 | 90 | 0.200% | 40× Goblin, 10× Goblin Scavenger, 15× Goblin Assassin | Goblins are converging west of Edron. |
| edron | `Mad Mage` | `edron/mad_mage.xml` | 360 | 30 | 0.278% | 7× Golden Servant, 7× Iron Servant, 1× Mad Mage | *(no announcement)* |
| edron | `Orcss` | `edron/orc.xml` | 500 | 100 | 0.200% | 20× Orc, 5× Orc Rider, 15× Orc Spearman, 10× Orc Warrior | Deep under Edron, the Orc population seems to grow rapidly.   Be careful and take a rope with you! |
| edron | `Orshabaal` | `edron/orshabaal.xml` | 1440 | 100 | 0.069% | 1× Orshabaal | Orshabaal's minions are working on his return to the World. LEAVE Edron at once, mortals. |
| edron | `Warlock` | `edron/warlock.xml` | 500 | 100 | 0.200% | 6× Monk, 3× Warlock | Some monks have gathered at a stone circle west of Edron. They seem to be up to something. |
| farmine | `Beetles` | `farmine/beetles.xml` | 500 | 70 | 0.200% | 10× Lancer Beetle | Lancer beetles troop up in Farmine. Beware! |
| farmine | `Gnarlhounds` | `farmine/gnarlhounds.xml` | 500 | 20 | 0.200% | 20× Gnarlhound | There seems to be a big gnarlhoud gang in Zao Steppe. |
| farmine | `Zevelon Duskbringer` | `farmine/zevelon_duskbringer.xml` | 1440 | 90 | 0.069% | 1× Zevelon Duskbringer | Beware of Zevelon Duskbringer! |
| farmine | `Zulazza the Corruptor` | `farmine/zulazza_the_corruptor.xml` | 1440 | 60 | 0.069% | 1× Zulazza the Corruptor, 1× Chizzoron the Distorter | A massive orc force is gathering at the gates of Zzaion. |
| kazordoon | `GoFemor` | `kazordoon/goblins.xml` | 500 | 70 | 0.200% | 50× Goblin, 15× Goblin Scavenger, 10× Goblin Assassin, 1× Goblin Leader | Goblins are preparing to attack Kazordoon from Femor Hills! |
| kazordoon | `Horned Fox` | `kazordoon/horned.xml` | 1440 | 180 | 0.069% | 1× Minotaur mage, 1× the Horned Fox | Beware of The horned Fox! |
| liberty_bay | ~~`Ferumbras`~~ (commented out) | `liberty_bay/ferumbras.xml` | 1440 | 120 | 0.069% | 1× Ferumbras | The seals on Ferumbras old cidatel are glowing. Prepare for HIS return mortals. |
| liberty_bay | `Morgaroth` | `liberty_bay/morgaroth.xml` | 1440 | 90 | 0.069% | 1× Morgaroth | The ancient volcano on Goroma slowly becomes active once again. |
| liberty_bay | `Quaras` | `liberty_bay/quaras.xml` | 500 | 50 | 0.200% | 12× Quara Mantassin Scout, 12× Quara Constrictor Scout, 12× Quara Hydromancer Scout, 12× Quara Pincher Scout, 10× Quara Predator Scout | Something is moving in the depths of the sea around Liberty Bay |
| liberty_bay | `Tigers` | `liberty_bay/tigers.xml` | 500 | 100 | 0.200% | 30× Tiger | Majestic creatures with stripes roam the small desert at Meriana. |
| liberty_bay | `Tortoise` | `liberty_bay/tortoises.xml` | 500 | 80 | 0.200% | 30× Tortoise | Slowly but steady, the population of tortoises grows on liberty island. |
| port_hope | `Kongras` | `port_hope/kongras.xml` | 500 | 60 | 0.200% | 15× Lizard Snakecharmer, 15× Lizard Templar, 10× Lizard Sentinel | Lizards Sentinels seem to attack Port Hope from Chor. |
| port_hope | `Lizards` | `port_hope/lizards.xml` | 500 | 95 | 0.200% | 15× Lizard Snakecharmer, 15× Lizard Templar, 10× Lizard Sentinel | Lizards Sentinels seem to attack Port Hope from Chor. |
| port_hope | `Sspawn` | `port_hope/serpent_spawn.xml` | 500 | 60 | 0.200% | 30× Serpent Spawn | Something bad is happening deep, deep down under Banuta. |
| port_hope | `Terror` | `port_hope/terrorbirds.xml` | 500 | 100 | 0.200% | 30× Terror Bird | Terrorbirds have been sighted in Trapwood south-east of Port Hope! |
| rookgaard | `Munster` | `rookgaard/munster.xml` | 500 | 40 | 0.200% | 1× Munster | *(no announcement)* |
| rookgaard | `Rats` | `rookgaard/rats.xml` | 500 | 70 | 0.200% | 20× Rat, 10× Cave Rat | Numerous Rats invaded Rookgaard! |
| rookgaard | `Rottie The Rotworm katana` | `rookgaard/rottie1.xml` | 500 | 70 | 0.200% | 20× Rat, 10× Cave Rat | Numerous Rats invaded Rookgaard! |
| rookgaard | `Rottie The Rotworm spidercave` | `rookgaard/rottie2.xml` | 300 | 70 | 0.333% | 1× Rottie The Rotworm | Something is moving in the northern grounds of the Rookgaard. |
| rookgaard | `Apprentice Sheng` | `rookgaard/sheng.xml` | 500 | 70 | 0.200% | 1× Apprentice Sheng | *(no announcement)* |
| rookgaard | `Teleskor` | `rookgaard/teleskor.xml` | 500 | 50 | 0.200% | 1× Teleskor | *(no announcement)* |
| roshamuul | `Gaz` | `roshamuul/gaz_haragoth.xml` | 1440 | 160 | 0.069% | 1× Gaz'Haragoth | Something out of the ordinary, it's better we hide now! |
| roshamuul | `Omrafir` | `roshamuul/omrafir.xml` | 1440 | 80 | 0.069% | 1× Omrafir | Omrafir is about to make his way into the roshamuul prison. Run for your lives! |
| svargrond | `BarbaBitter` | `svargrond/barba_bittermor.xml` | 500 | 40 | 0.200% | 5× Barbarian Bloodwalker, 3× Barbarian Brutetamer, 5× Barbarian Headsplitter, 10× Barbarian Skullhunter | Barbarians are gathering at Bittermor. They seem to be up to something. |
| svargrond | `BarbaSvar` | `svargrond/barba_svar.xml` | 500 | 80 | 0.200% | 15× Barbarian Bloodwalker, 15× Barbarian Brutetamer, 15× Barbarian Headsplitter, 15× Barbarian Skullhunter | Scouts report a barbarian army gathering near Svargrond. |
| svargrond | `Barbarian` | `svargrond/barbarian.xml` | 500 | 70 | 0.200% | 35× Barbarian Bloodwalker, 22× Barbarian Brutetamer, 22× Barbarian Headsplitter, 28× Barbarian Skullhunter, 15× Ice Witch | Scouts report a barbarian army gathering near Svargrond |
| svargrond | `Ghazbaran` | `svargrond/ghazbaran.xml` | 1440 | 100 | 0.069% | 1× Ghazbaran, 12× Deathslicer, 5× Juggernaut, 8× Fury, 6× Demon | An ancient evil is awakening in the mines beneath Hrodmir. |
| svargrond | `IceGolems` | `svargrond/ice_golems.xml` | 500 | 70 | 0.200% | 15× Ice Golem | There is a sudden rise in ice golem population in Formogar mines. |
| svargrond | `Ocyakao` | `svargrond/ocyakao.xml` | 1440 | 50 | 0.069% | 1× Ocyakao | Beware of Ocyakao! |
| svargrond | `Zushuka` | `svargrond/zushuka.xml` | 6000 | 60 | 0.017% | 1× Zushuka | *(no announcement)* |
| thais | `Cyclops` | `thais/cyclops.xml` | 500 | 30 | 0.200% | 5× Cyclops, 5× Cyclops Drone, 3× Cyclops Smith | Let da mashing begin! Cyclops riot east of Thais. |
| thais | `OrcsThais` | `thais/orcs.xml` | 500 | 70 | 0.200% | 1× Orc Helmet, 1× Orc Shield, 1× Orc Armor, 25× Orc Shaman, 23× Orc Berserker, 10× Orc Warlord, 26× Orc Rider, 24× Orc | Orc activity near Thais reported! Beware! |
| venore | `Dharalion` | `venore/dharalion.xml` | 500 | 70 | 0.200% | 1× Dharalion | Beware! Beware of the Dharalion! |
| venore | `Elves` | `venore/elves.xml` | 500 | 80 | 0.200% | 12× elf, 12× elf scout, 9× elf arcanist | Elf Scouts have been sighted near Venore! |
| venore | `Fernfang` | `venore/fernfang.xml` | 1440 | 80 | 0.069% | 1× Fernfang, 2× War Wolf | Beware Fernfang. |
| venore | ~~`Citizen`~~ (commented out) | `venore/feverish_citizen.xml` | 500 | 40 | 0.200% | 120× feverish citizen | Feverish Citizens are invading the streets of Venore! |
| venore | `Hunters` | `venore/hunter.xml` | 500 | 65 | 0.200% | 15× Hunter | Hunters on the hunt north of the Green Claw Swamp. |
| venore | `Orc Backpack` | `venore/orc_backpack.xml` | 300 | 110 | 0.333% | 1× Orc Sambackpack | *(no announcement)* |
| venore | `Undead Army` | `venore/undead.xml` | 500 | 100 | 0.200% | 35× Skeleton, 12× Banshee, 22× ghoul, 18× demon skeleton, 15× Vampire | The dead of the plains of havoc are becoming restless! |
| venore | `Water Buffalo` | `venore/water_buffalo.xml` | 500 | 100 | 0.200% | 32× water buffalo | *(no announcement)* |

**Oddities spotted:**
- `rookgaard/rottie1.xml` ("Rottie The Rotworm katana") is byte-identical to `rookgaard/rats.xml` — it spawns rats, not Rottie.
- `port_hope/kongras.xml` is byte-identical to `port_hope/lizards.xml` — no Kongras.
- `Orc Helmet / Orc Shield / Orc Armor / Orc Sambackpack` are real special monsters (`monster/raids/`), not items.
- Raids with no announcement leave no `Broadcasted message:` log line (Badger, Mad Mage, Munster, Sheng, Teleskor, Zushuka, Orc Backpack, Water Buffalo).

### Files present but NOT registered (never run as legacy)

`carlin/yeti`, `darashia/arachir_the_ancient_one`, `darashia/the_pale_count`, `darashia/white_pale`, `edron/sir_valorcrest`, `edron/weakened_shlorg`, `farmine/draptor`, `fury_gate/furyosa`, `liberty_bay/crustacea_gigantica_1-3`, `liberty_bay/diblis_the_fair`, `liberty_bay/undead_cavebear`, `oramond/crustacea_gigantica_4-5`, `port_hope/midnight_panther_1-3`, `port_hope/the_welter`, `svargrond/hirintror`, `thais/rats`, `thais/wild_horses`, `venore/the_old_widow`.

Most were superseded by Lua raids. **Crustacea Gigantica has no Lua version → never happens.** Re-enable any by adding a line to `raids.xml` + `/reload raids`.

## Lua raids

### Format

```lua
local zone = Zone("thais.rats")
zone:addArea(Position(32331, 32182, 7), Position(32426, 32261, 7))

local raid = Raid("thais.rats", {
	zone = zone,
	allowedDays = { "Monday", "Tuesday", ... },  -- weekdays allowed
	minActivePlayers = 0,      -- non-idle (<5 min) players online
	initialChance = nil,       -- % per 1-min check at start (default target / ~1380)
	targetChancePerDay = 30,   -- % the ramp climbs to over ~23h of failed checks
	maxChancePerCheck = 50,    -- cap per check (%)
	maxChecksPerDay = nil,     -- limit rolls per day
	minGapBetween = "36h",     -- cooldown since last occurrence
})

raid:addBroadcast("Rat Plague in Thais!"):autoAdvance("5s")                       -- stage 1
raid:addSpawnMonsters({ { name = "Rat", amount = 10 }, { name = "Cave Rat", amount = 10 } }):autoAdvance("10m")
raid:addSpawnMonsters({ { name = "Rat", amount = 20 }, { name = "Cave Rat", amount = 20 } }):autoAdvance("10m")
raid:register()
```

### Start logic (each minute)

1. Already running → skip.
2. `minGapBetween` not elapsed → skip.
3. `maxChecksPerDay` used up → skip.
4. Roll: chance = `initialChance + increase × failedAttempts`, capped at `maxChancePerCheck`, where `increase = (target − initial) / ~1380`. Fail → failedAttempts+1.
5. Roll won but wrong day / too few players → flagged **trigger-when-possible**: starts as soon as conditions are met, no new roll.

⚠️ `targetChancePerDay` is misleadingly named. When `initialChance >= target` the chance never ramps, so `0.02` = flat 0.02% per minute ≈ **24% per day**; `0.04` ≈ 42%/day; `0.01` ≈ 13%/day.

Spawn details: `Zone:randomPosition()` picks a walkable tile, but scans **every tile in the zone on each call** (slow for big zones). Default 3s teleport effect before each spawn (`timeToSpawnMonsters`).

### Registered Lua raids

| `/raid` name | Script | What happens | Min players | Days | Chance setup | Gap | ≈ Frequency |
|---|---|---|---|---|---|---|---|
| `thais.rats` | `thais/rats.lua` ⚠️dup | "Rat Plague in Thais!" → 10 Rat + 10 Cave Rat → 10 min → 20 + 20 | 0 | all | ramps to 30, cap 50 | 36h | ~every 1.5 days |
| `thais.wild-horses` | `thais/wild_horses.lua` ⚠️dup | 3 Wild Horses east of Thais, no broadcast | 0 | all | 30% per check, max 2 checks/day | 23h | ~daily |
| `folda.yeti` | `monsters/yeti.lua` | 3 broadcasts → 3 Yetis in Folda | 2 | all | flat 0.02, cap 0.6 | 48h | ~24%/day after gap |
| ~~`farmine.draptor`~~ | `monsters/draptor.lua` | "Dragons have descended to Zao…" → 50 Dragons → Draptor → Grand Mother Foulscale | 2 | all | flat 0.02, cap 0.6 | 12h | ⚠️ **overwritten** — never runs |
| `farmine.draptor` (actually cavebear) | `monsters/undead_cavebear.lua` | 3 Undead Cavebears | 2 | all | flat 0.02, cap 0.6 | 12h | ~24%/day |
| `tiquanda.midnight-panther` | `monsters/midnight_panther.lua` | 1 Midnight Panther at 1 of 3 spots | 3 | all | flat 0.03, cap 0.9 | — | ~34%/day |
| `darashia.tyrn` | `bosses/tyrn.lua` | Tyrn | 2 | not Mon | flat 0.04, cap 0.4 | — | ~42%/day |
| `roshamuul.mawhawk` | `bosses/mawhawk.lua` | Mawhawk | 2 | not Wed | flat 0.04, cap 0.4 | — | ~42%/day |
| `venore.the-old-widow` | `bosses/the_old_widow.lua` | 2 broadcasts → 8 Giant Spiders → The Old Widow (Plains of Havoc) | 3 | all | flat 0.02, cap 0.8 | — | ~24%/day |
| `fury-gates.furiosa` | `bosses/furyosa.lua` | **80 Demons** → Furyosa | 3 | all | flat 0.01, cap 0.6 | — | ~13%/day |
| `ankrahmun.the-welter` | `bosses/the_welter.lua` | The Welter | 3 | not Mon | flat 0.01, cap 0.6 | — | ~13%/day |
| `drefia.arachir` | `bosses/arachir_the_ancient_one.lua` | Arachir the Ancient One | 3 | all | flat 0.02, cap 0.8 | — | ~24%/day |
| `drefia.the-pale-count` | `bosses/the_pale_count.lua` | The Pale Count | 3 | all | 0.01 → 0.02, cap 0.7 | — | ~15–24%/day |
| `edron.valorcrest` | `bosses/sir_valorcrest.lua` | Sir Valorcrest | 3 | all | flat 0.02, cap 0.8 | — | ~24%/day |
| `edron.weakened-shlorg` | `bosses/weakened_shlorg.lua` | Weakened Shlorg | 3 | all | flat 0.02, cap 0.8 | — | ~24%/day |
| `edron.white-pale` | `bosses/white_pale.lua` | White Pale | 3 | all | flat 0.02, cap 0.8 | — | ~24%/day |
| `svargrond.hirintror` | `bosses/hirintror.lua` | Hirintror | 3 | all | flat 0.02, cap 0.8 | — | ~24%/day |
| `nargor.diblis` | `bosses/diblis_the_fair.lua` | Diblis the Fair | 3 | all | flat 0.02, cap 0.8 | — | ~24%/day |
| `muggy_plains.battlemaster_zunzu` | `bosses/battlemaster_zunzu.lua` | Battlemaster Zunzu | 3 | all | flat 0.02, cap 0.8 | — | ~24%/day |

Single-boss raids use `autoAdvance("24h")`: the raid counts as running for a day after the boss spawns.

### Known Lua raid bugs

1. **Duplicate names** — `monsters/rats.lua` + `thais/rats.lua` both register `thais.rats`; `monsters/wild_horses.lua` + `thais/wild_horses.lua` both register `thais.wild-horses`. Registration silently overwrites; the `thais/` versions (0 min players, higher chances) win, per the logs. The `monsters/` versions had min players 2/3, `thais.rats` flat 0.04 cap 0.4, wild-horses gap 12h.
2. **Draptor never runs** — `monsters/undead_cavebear.lua` was copied from `draptor.lua` and still registers as `farmine.draptor`, replacing it. `/raid farmine.draptor` spawns cavebears.
3. **Min 3 players** on most bosses — on a low-population server they only pop once 3 non-idle players are online at once (a won roll stays queued until then).
4. **Reward-boss flag on every spawn** (`encounters.lua:217`) — trash mobs from Lua raids use reward-chest loot.

## Fixed-time schedule (mostly broken)

`data-otservbr-global/scripts/globalevents/others/raids_schedule.lua` calls `Game.startRaid(name)` (legacy only) at fixed weekday/times: Midnight Panther (Tue 16:00, Sun 15:00), Draptor (Wed 12:00, Sat 20:00), Undead Cavebear (Thu 19:00), Titanica (Fri 06:00), Orc Backpack (Sun 13:00), Halloween Hare (31/10 16:00). **Only "Orc Backpack" exists in `raids.xml`**; all others fail silently with "no such raid".

## Log grepping

```sh
grep -h "Broadcasted message" logs/*.log   # legacy raids (only those with an announce)
grep -h "Starting raid" logs/*.log         # Lua raids
```
