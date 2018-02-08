--[[
* Ashita - Copyright (c) 2014 - 2017 atom0s [atom0s@live.com]
*
* This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
* To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/ or send a letter to
* Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
*
* By using Ashita, you agree to the above license and its terms.
*
*      Attribution - You must give appropriate credit, provide a link to the license and indicate if changes were
*                    made. You must do so in any reasonable manner, but not in any way that suggests the licensor
*                    endorses you or your use.
*
*   Non-Commercial - You may not use the material (Ashita) for commercial purposes.
*
*   No-Derivatives - If you remix, transform, or build upon the material (Ashita), you may not distribute the
*                    modified material. You are, however, allowed to submit the modified works back to the original
*                    Ashita project in attempt to have it added to the original project.
*
* You may not apply legal terms or technological measures that legally restrict others
* from doing anything the license permits.
*
* No warranties are given.
]]--

_addon.author   = 'Eulerpath';
_addon.name     = 'LookUp';
_addon.version  = '3.4.0';
-- version <commands to use>.<sql files addon loads>.<bug fix version>

--[[
for this addon to work you will need a few *.sql files for ffxi darkstar server.
these files can be downloaded from github at: https://github.com/DarkstarProject/darkstar
at this webpage click on "Clone or download" then Download ZIP
or use this link: https://github.com/DarkstarProject/darkstar/archive/master.zip

when the zip file is downloaded open it up and go to darkstar-master/sql
in this folder you will need these files:
item_basic.sql, mob_droplist.sql, mob_groups.sql, mob_spawn_points.sql

now that you have this lua file and the sql files make a directory under AshitaV3/addons/LookUp and dump all files here
now in game you should be able to put in the command /addon load LookUp.
you will know if it worked if you see the text:
finished reading item_basic
finished reading mob_droplist
finished reading mob_groups
finished reading mob_spawn_points

]]--
require 'common'
require 'ffxi.targets'
require 'logging'


function ZoneIdToString(zoneid)
    z = tonumber(zoneid)
    if 0 == z then
        return "Tech Demo Area"
    elseif 1 == z then
        return "Phanauet Channel"
    elseif 2 == z then
        return "Carpenters' Landing"
    elseif 3 == z then
        return "Manaclipper"
    elseif 4 == z then
        return "Bibiki Bay"
    elseif 5 == z then
        return "Uleguerand Range"
    elseif 6 == z then
        return "Bearclaw Pinnacle"
    elseif 7 == z then
        return "Attohwa Chasm"
    elseif 8 == z then
        return "Boneyard Gully"
    elseif 9 == z then
        return "Pso'Xja"
    elseif 10 == z then
        return "The Shrouded Maw"
    elseif 11 == z then
        return "Oldton Movalpolos"
    elseif 12 == z then
        return "Newton Movalpolos"
    elseif 13 == z then
        return "Mine Shaft #2716"
    elseif 14 == z then
        return "Hall of Transference"
    elseif 15 == z then
        return "Abyssea - Konschtat"
    elseif 16 == z then
        return "Promyvion - Holla"
    elseif 17 == z then
        return "Spire of Holla"
    elseif 18 == z then
        return "Promyvion -  Dem"
    elseif 19 == z then
        return "Spire of Dem"
    elseif 20 == z then
        return "Promyvion - Mea"
    elseif 21 == z then
        return "Spire of Mea"
    elseif 22 == z then
        return "Promyvion - Vahzl"
    elseif 23 == z then
        return "Spire of Vahzl"
    elseif 24 == z then
        return "Lufaise Meadows"
    elseif 25 == z then
        return "Misareaux Coast"
    elseif 26 == z then
        return "Tavnazian Safehold"
    elseif 27 == z then
        return "Phomiuna Aqueducts"
    elseif 28 == z then
        return "Sacrarium"
    elseif 29 == z then
        return "Riverne - Site #B01"
    elseif 30 == z then
        return "Riverne - Site #A01"
    elseif 31 == z then
        return "Monarch Linn"
    elseif 32 == z then
        return "Sealion's Den"
    elseif 33 == z then
        return "Al'Taieu"
    elseif 34 == z then
        return "Grand Palace of Hu'Xzoi"
    elseif 35 == z then
        return "The Garden of Ru'Hmet"
    elseif 36 == z then
        return "Empyreal Paradox"
    elseif 37 == z then
        return "Temenos"
    elseif 38 == z then
        return "Apollyon"
    elseif 39 == z then
        return "Dynamis - Valkurm"
    elseif 40 == z then
        return "Dynamis - Buburimu"
    elseif 41 == z then
        return "Dynamis - Qufim"
    elseif 42 == z then
        return "Dynamis - Tavnazia"
    elseif 43 == z then
        return "Diorama Abdhaljs-Ghelsba"
    elseif 44 == z then
        return "Abdhaljs Isle-Purgonorgo"
    elseif 45 == z then
        return "Abyssea - Tahrongi"
    elseif 46 == z then
        return "Open sea route to Al Zahbi"
    elseif 47 == z then
        return "Open sea route to Mhaura"
    elseif 48 == z then
        return "Al Zahbi"
    elseif 49 == z then
        return "Test Area (Checkerboard Zone)"
    elseif 50 == z then
        return "Aht Urhgan Whitegate"
    elseif 51 == z then
        return "Wajaom Woodlands"
    elseif 52 == z then
        return "Bhaflau Thickets"
    elseif 53 == z then
        return "Nashmau"
    elseif 54 == z then
        return "Arrapago Reef"
    elseif 55 == z then
        return "Ilrusi Atoll"
    elseif 56 == z then
        return "Periqia"
    elseif 57 == z then
        return "Talacca Cove"
    elseif 58 == z then
        return "Silver Sea route to Nashmau"
    elseif 59 == z then
        return "Silver Sea route to Al Zahbi"
    elseif 60 == z then
        return "The Ashu Talif"
    elseif 61 == z then
        return "Mount Zhayolm"
    elseif 62 == z then
        return "Halvung"
    elseif 63 == z then
        return "Lebros Cavern"
    elseif 64 == z then
        return "Navukgo Execution Chamber"
    elseif 65 == z then
        return "Mamook"
    elseif 66 == z then
        return "Mamool Ja Training Grounds"
    elseif 67 == z then
        return "Jade Sepulcher"
    elseif 68 == z then
        return "Aydeewa Subterrane"
    elseif 69 == z then
        return "Leujaoam Sanctum"
    elseif 70 == z then
        return "Chocobo Circuit"
    elseif 71 == z then
        return "The Colosseum"
    elseif 72 == z then
        return "Alzadaal Undersea Ruins"
    elseif 73 == z then
        return "Zhayolm Remnants"
    elseif 74 == z then
        return "Arrapago Remnants"
    elseif 75 == z then
        return "Bhaflau Remnants"
    elseif 76 == z then
        return "Silver Sea Remnants"
    elseif 77 == z then
        return "Nyzul Isle"
    elseif 78 == z then
        return "Hazhalm Testing Grounds"
    elseif 79 == z then
        return "Caedarva Mire"
    elseif 80 == z then
        return "Southern San d'Oria [S]"
    elseif 81 == z then
        return "East Ronfaure [S]"
    elseif 82 == z then
        return "Jugner Forest [S]"
    elseif 83 == z then
        return "Vunkerl Inlet [S]"
    elseif 84 == z then
        return "Batallia Downs [S]"
    elseif 85 == z then
        return "La Vaule [S]"
    elseif 86 == z then
        return "Everbloom Hollow"
    elseif 87 == z then
        return "Bastok Markets [S]"
    elseif 88 == z then
        return "North Gustaberg [S]"
    elseif 89 == z then
        return "Grauberg [S]"
    elseif 90 == z then
        return "Pashhow Marshlands [S]"
    elseif 91 == z then
        return "Rolanberry Fields [S]"
    elseif 92 == z then
        return "Beadeaux [S]"
    elseif 93 == z then
        return "Ruhotz Silvermines"
    elseif 94 == z then
        return "Windurst Waters [S]"
    elseif 95 == z then
        return "West Sarutabaruta [S]"
    elseif 96 == z then
        return "Fort Karugo-  -Narugo [S]"
    elseif 97 == z then
        return "Meriphataud Mountains [S]"
    elseif 98 == z then
        return "Sauromugue Champaign [S]"
    elseif 99 == z then
        return "Castle Oztroja [S]"
    elseif 100 == z then
        return "West Ronfaure"
    elseif 101 == z then
        return "East Ronfaure"
    elseif 102 == z then
        return "La Theine Plateau"
    elseif 103 == z then
        return "Valkurm Dunes"
    elseif 104 == z then
        return "Jugner Forest"
    elseif 105 == z then
        return "Batallia Downs"
    elseif 106 == z then
        return "North Gustaberg"
    elseif 107 == z then
        return "South Gustaberg"
    elseif 108 == z then
        return "Konschtat Highlands"
    elseif 109 == z then
        return "Pashhow Marshlands"
    elseif 110 == z then
        return "Rolanberry Fields"
    elseif 111 == z then
        return "Beaucedine Glacier"
    elseif 112 == z then
        return "Xarcabard"
    elseif 113 == z then
        return "Cape Teriggan"
    elseif 114 == z then
        return "Eastern Altepa Desert"
    elseif 115 == z then
        return "West Sarutabaruta"
    elseif 116 == z then
        return "East Sarutabaruta"
    elseif 117 == z then
        return "Tahrongi Canyon"
    elseif 118 == z then
        return "Buburimu Peninsula"
    elseif 119 == z then
        return "Meriphataud Mountains"
    elseif 120 == z then
        return "Sauromugue Champaign"
    elseif 121 == z then
        return "The Sanctuary of Zi'Tah"
    elseif 122 == z then
        return "Ro'Maeve"
    elseif 123 == z then
        return "Yuhtunga Jungle"
    elseif 124 == z then
        return "Yhoator Jungle"
    elseif 125 == z then
        return "Western Altepa Desert"
    elseif 126 == z then
        return "Qufim Island"
    elseif 127 == z then
        return "Behemoth's Dominion"
    elseif 128 == z then
        return "Valley of Sorrows"
    elseif 129 == z then
        return "Ghoyu's Reverie"
    elseif 130 == z then
        return "Ru'Aun Gardens"
    elseif 131 == z then
        return "Mordion Gaol"
    elseif 132 == z then
        return "Abyssea - La Theine"
    elseif 133 == z then
        return "Not a real zone then Character select screen background"
    elseif 134 == z then
        return "Dynamis - Beaucedine"
    elseif 135 == z then
        return "Dynamis - Xarcabard"
    elseif 136 == z then
        return "Beaucedine Glacier [S]"
    elseif 137 == z then
        return "Xarcabard [S]"
    elseif 138 == z then
        return "Castle Zvahl Baileys [S]"
    elseif 139 == z then
        return "Horlais Peak"
    elseif 140 == z then
        return "Ghelsba Outpost"
    elseif 141 == z then
        return "Fort Ghelsba"
    elseif 142 == z then
        return "Yughott Grotto"
    elseif 143 == z then
        return "Palborough Mines"
    elseif 144 == z then
        return "Waughroon Shrine"
    elseif 145 == z then
        return "Giddeus"
    elseif 146 == z then
        return "Balga's Dais"
    elseif 147 == z then
        return "Beadeaux"
    elseif 148 == z then
        return "Qulun Dome"
    elseif 149 == z then
        return "Davoi"
    elseif 150 == z then
        return "Monastic Cavern"
    elseif 151 == z then
        return "Castle Oztroja"
    elseif 152 == z then
        return "Altar Room"
    elseif 153 == z then
        return "The Boyahda Tree"
    elseif 154 == z then
        return "Dragon's Aery"
    elseif 155 == z then
        return "Castle Zvahl Keep [S]"
    elseif 156 == z then
        return "Throne Room [S]"
    elseif 157 == z then
        return "Middle Delkfutt's Tower"
    elseif 158 == z then
        return "Upper Delkfutt's Tower"
    elseif 159 == z then
        return "Temple of Uggalepih"
    elseif 160 == z then
        return "Den of Rancor"
    elseif 161 == z then
        return "Castle Zvahl Baileys"
    elseif 162 == z then
        return "Castle Zvahl Keep"
    elseif 163 == z then
        return "Sacrificial Chamber"
    elseif 164 == z then
        return "Garlaige Citadel [S]"
    elseif 165 == z then
        return "Throne Room"
    elseif 166 == z then
        return "Ranguemont Pass"
    elseif 167 == z then
        return "Bostaunieux Oubliette"
    elseif 168 == z then
        return "Chamber of Oracles"
    elseif 169 == z then
        return "Toraimarai Canal"
    elseif 170 == z then
        return "Full Moon Fountain"
    elseif 171 == z then
        return "Crawlers' Nest [S]"
    elseif 172 == z then
        return "Zeruhn Mines"
    elseif 173 == z then
        return "Korroloka Tunnel"
    elseif 174 == z then
        return "Kuftal Tunnel"
    elseif 175 == z then
        return "The Eldieme Necropolis [S]"
    elseif 176 == z then
        return "Sea Serpent Grotto"
    elseif 177 == z then
        return "Ve'Lugannon Palace"
    elseif 178 == z then
        return "The Shrine of Ru'Avitau"
    elseif 179 == z then
        return "Stellar Fulcrum"
    elseif 180 == z then
        return "La'Loff Amphitheater"
    elseif 181 == z then
        return "The Celestial Nexus"
    elseif 182 == z then
        return "Walk of Echoes"
    elseif 183 == z then
        return "Maquette Abdhaljs-Legion (Formerly 'The Last Stand')"
    elseif 184 == z then
        return "Lower Delkfutt's Tower"
    elseif 185 == z then
        return "Dynamis - San d'Oria"
    elseif 186 == z then
        return "Dynamis - Bastok"
    elseif 187 == z then
        return "Dynamis - Windurst"
    elseif 188 == z then
        return "Dynamis - Jeuno"
    elseif 189 == z then
        return "N/A"
    elseif 190 == z then
        return "King Ranperre's Tomb"
    elseif 191 == z then
        return "Dangruf Wadi"
    elseif 192 == z then
        return "Inner Horutoto Ruins"
    elseif 193 == z then
        return "Ordelle's Caves"
    elseif 194 == z then
        return "Outer Horutoto Ruins"
    elseif 195 == z then
        return "The Eldieme Necropolis"
    elseif 196 == z then
        return "Gusgen Mines"
    elseif 197 == z then
        return "Crawlers' Nest"
    elseif 198 == z then
        return "Maze of Shakhrami"
    elseif 199 == z then
        return "N/A"
    elseif 200 == z then
        return "Garlaige Citadel"
    elseif 201 == z then
        return "Cloister of Gales"
    elseif 202 == z then
        return "Cloister of Storms"
    elseif 203 == z then
        return "Cloister of Frost"
    elseif 204 == z then
        return "Fei'Yin"
    elseif 205 == z then
        return "Ifrit's Cauldron"
    elseif 206 == z then
        return "Qu'Bia Arena"
    elseif 207 == z then
        return "Cloister of Flames"
    elseif 208 == z then
        return "Quicksand Caves"
    elseif 209 == z then
        return "Cloister of Tremors"
    elseif 210 == z then
        return "GM Home (name comes from leaked official documentation)"
    elseif 211 == z then
        return "Cloister of Tides"
    elseif 212 == z then
        return "Gustav Tunnel"
    elseif 213 == z then
        return "Labyrinth of Onzozo"
    elseif 214 == z then
        return "Residential Area (Alt)"
    elseif 215 == z then
        return "Abyssea - Attohwa"
    elseif 216 == z then
        return "Abyssea - Misareaux"
    elseif 217 == z then
        return "Abyssea - Vunkerl"
    elseif 218 == z then
        return "Abyssea - Altepa"
    elseif 219 == z then
        return "N/A"
    elseif 220 == z then
        return "Ship bound for Selbina"
    elseif 221 == z then
        return "Ship bound for Mhaura"
    elseif 222 == z then
        return "Provenance"
    elseif 223 == z then
        return "San d'Oria-Jeuno Airship"
    elseif 224 == z then
        return "Bastok-Jeuno Airship"
    elseif 225 == z then
        return "Windurst-Jeuno Airship"
    elseif 226 == z then
        return "Kazham-Jeuno Airship"
    elseif 227 == z then
        return "Ship bound for Selbina (with Pirates)"
    elseif 228 == z then
        return "Ship bound for Mhaura (with Pirates)"
    elseif 229 == z then
        return "N/A"
    elseif 230 == z then
        return "Southern San d'Oria"
    elseif 231 == z then
        return "Northern San d'Oria"
    elseif 232 == z then
        return "Port San d'Oria"
    elseif 233 == z then
        return "Chateau d'Oraguille"
    elseif 234 == z then
        return "Bastok Mines"
    elseif 235 == z then
        return "Bastok Markets"
    elseif 236 == z then
        return "Port Bastok"
    elseif 237 == z then
        return "Metalworks"
    elseif 238 == z then
        return "Windurst Waters"
    elseif 239 == z then
        return "Windurst Walls"
    elseif 240 == z then
        return "Port Windurst"
    elseif 241 == z then
        return "Windurst Woods"
    elseif 242 == z then
        return "Heavens Tower"
    elseif 243 == z then
        return "Ru'Lude Gardens"
    elseif 244 == z then
        return "Upper Jeuno"
    elseif 245 == z then
        return "Lower Jeuno"
    elseif 246 == z then
        return "Port Jeuno"
    elseif 247 == z then
        return "Rabao"
    elseif 248 == z then
        return "Selbina"
    elseif 249 == z then
        return "Mhaura"
    elseif 250 == z then
        return "Kazham"
    elseif 251 == z then
        return "Hall of the Gods"
    elseif 252 == z then
        return "Norg"
    elseif 253 == z then
        return "Abyssea - Uleguerand"
    elseif 254 == z then
        return "Abyssea - Grauberg"
    elseif 255 == z then
        return "Abyssea - Empyreal Paradox"
    elseif 256 == z then
        return "Western Adoulin"
    elseif 257 == z then
        return "Eastern Adoulin"
    elseif 258 == z then
        return "Rala Waterways"
    elseif 259 == z then
        return "Rala Waterways [U]"
    elseif 260 == z then
        return "Yahse Hunting Grounds"
    elseif 261 == z then
        return "Ceizak Battlegrounds"
    elseif 262 == z then
        return "Foret de Hennetiel"
    elseif 263 == z then
        return "Yorcia Weald"
    elseif 264 == z then
        return "Yorcia Weald [U]"
    elseif 265 == z then
        return "Morimar Basalt Fields"
    elseif 266 == z then
        return "Arjami Ravine"
    elseif 267 == z then
        return "Kamihr Drifts"
    elseif 268 == z then
        return "Sih Gates"
    elseif 269 == z then
        return "Moh Gates"
    elseif 270 == z then
        return "Cirdas Caverns"
    elseif 271 == z then
        return "Cirdas Caverns [U]"
    elseif 272 == z then
        return "Dho Gates"
    elseif 273 == z then
        return "Woh Gates"
    elseif 274 == z then
        return "Outer Ra'Kaznar"
    elseif 275 == z then
        return "Outer Ra'Kaznar [U]"
    elseif 276 == z then
        return "Ra'kaznar Inner Court"
    elseif 277 == z then
        return "Ra'Kaznar Turris"
    elseif 278 == z then
        return "N/A"
    elseif 279 == z then
        return "N/A"
    elseif 280 == z then
        return "Mog Garden"
    elseif 281 == z then
        return "Leafallia"
    elseif 282 == z then
        return "Mount Kamihr"
    elseif 283 == z then
        return "Silver Knife"
    elseif 284 == z then
        return "Celennia Memorial Library (formerly Wexworth Library)"
    elseif 285 == z then
        return "Feretory"
    elseif 286 == z then
        return "N/A"
    elseif 287 == z then
        return "N/A"
    elseif 288 == z then
        return "Escha - Zi'Tah"
    elseif 289 == z then
        return "Escha - Ru'Aun"
    elseif 290 == z then
        return "Desuetia - Empyreal Paradox"
    elseif 291 == z then
        return "Reisenjima"
    elseif 292 == z then
        return "Reisenjima_Henge"
    elseif 293 == z then
        return "Reisenjima Sanctorium"
    else
      return zoneid
    end
end;

function AuctionHouseIdToString (value)
  if value == '1' then
    return 'hand-to-hand'
  elseif value == '2' then
    return 'daggers'
  elseif value == '3' then
    return 'swords'
  elseif value == '4' then
    return 'great swords'
  elseif value == '5' then
    return 'axes'
  elseif value == '6' then
    return 'great axes'
  elseif value == '7' then
    return 'scythes'
  elseif value == '8' then
    return 'polearms'
  elseif value == '9' then
    return 'katana'
  elseif value == '10' then
    return 'great katana'
  elseif value == '11' then
    return 'clubs'
  elseif value == '12' then
    return 'staves'
  elseif value == '13' then
    return 'ranged'
  elseif value == '14' then
    return 'instruments'
  elseif value == '15' then
    return 'ammunition'
  elseif value == '16' then
    return 'shields'
  elseif value == '17' then
    return 'head'
  elseif value == '18' then
    return 'body'
  elseif value == '19' then
    return 'hands'
  elseif value == '20' then
    return 'legs'
  elseif value == '21' then
    return 'feet'
  elseif value == '22' then
    return 'neck'
  elseif value == '23' then
    return 'waist'
  elseif value == '24' then
    return 'earrings'
  elseif value == '25' then
    return 'rings'
  elseif value == '26' then
    return 'back'
  elseif value == '28' then
    return 'white magic'
  elseif value == '29' then
    return 'black magic'
  elseif value == '30' then
    return 'summoning'
  elseif value == '31' then
    return 'ninjutsu'
  elseif value == '32' then
    return 'songs'
  elseif value == '33' then
    return 'medicines'
  elseif value == '34' then
    return 'furnishings'
  elseif value == '35' then
    return 'crystals'
  elseif value == '36' then
    return 'cards'
  elseif value == '37' then
    return 'cursed items'
  elseif value == '38' then
    return 'smithing'
  elseif value == '39' then
    return 'goldsmithing'
  elseif value == '40' then
    return 'clothcraft'
  elseif value == '41' then
    return 'leathercraft'
  elseif value == '42' then
    return 'bonecraft'
  elseif value == '43' then
    return 'woodworking'
  elseif value == '44' then
    return 'alchemy'
  elseif value == '45' then
    return 'geomancy'
  elseif value == '46' then
    return 'misc.'
  elseif value == '47' then
    return 'fishing gear'
  elseif value == '48' then
    return 'pet items'
  elseif value == '49' then
    return 'ninja tools'
  elseif value == '50' then
    return 'beast-made'
  elseif value == '51' then
    return 'fish'
  elseif value == '52' then
    return 'meat & eggs'
  elseif value == '53' then
    return 'seafood'
  elseif value == '54' then
    return 'vegetables'
  elseif value == '55' then
    return 'soups'
  elseif value == '56' then
    return 'breads & rice'
  elseif value == '57' then
    return 'sweets'
  elseif value == '58' then
    return 'drinks'
  elseif value == '59' then
    return 'ingredients'
  elseif value == '60' then
    return 'dice'
  elseif value == '61' then
    return 'automation'
  elseif value == '62' then
    return 'grips'
  elseif value == '63' then
    return 'alchemy 2'
  elseif value == '64' then
    return 'misc. 2'
  elseif value == '65' then
    return 'misc. 3'
  elseif value == '99' then
    return 'Not Actionable'
  else
    return value
  end
end;

function StringSplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

-- taken and modified from addon Find, thank you MalRD
-------------------------------------------------------------------------------
local function getFindArgs(cmd)
    local indexOf = cmd:find(' ', 1, true);
    if (indexOf == nil) then return nil; end -- if only 1 arg
    local indexOfObject = cmd:find(' ', indexOf+1, true);
    if (indexOfObject == nil) then 
      return -- if only 2 args
      {
        [1] = cmd:sub(1, indexOf-1),  
        [2] = cmd:sub(indexOf+1)
      };
    end
    return -- if more than 2 args
    { 
        [1] = cmd:sub(1, indexOf-1),  
        [2] = cmd:sub(indexOf+1, indexOfObject-1),
        [3] = cmd:sub(indexOfObject+1)
    };
end


local item_basic = {}
local mob_droplist = {}
local mob_groups = {}
local mob_spawn_points = {}

function loadMobDropList()
  -- Load the file for reading..
  local file = io.open(_addon.path .. 'mob_droplist.sql', 'rb');
  if (file == nil) then
      print('unable to open mob_droplist.sql')
      return nil;
  end
  index = 1
  item = ""
  for line in io.lines(_addon.path .. 'mob_droplist.sql') do
    if string.find(line, 'INSERT') then
      -- get everything between ()
      item = string.match(line, "%((.+)%)")
      mob_droplist[index] = StringSplit(item, ',')
      index = index + 1
    end
  end
  print('finished reading mob_droplist')
  file:close();
end;

function loadMobGroup()
  -- Load the file for reading..
  local file = io.open(_addon.path .. 'mob_groups.sql', 'rb');
  if (file == nil) then
      print('unable to open mob_groups.sql')
      return nil;
  end
  index = 1
  item = ""
  for line in io.lines(_addon.path .. 'mob_groups.sql') do
    if string.find(line, 'INSERT') then
      -- get everything between ()
      item = string.match(line, "%((.+)%)")
      mob_groups[index] = StringSplit(item, ',')
      index = index + 1
    end
  end
  print('finished reading mob_groups')
  file:close();
end;

function loadMobSpawnPoint()
  -- Load the file for reading..
  local file = io.open(_addon.path .. 'mob_spawn_points.sql', 'rb');
  if (file == nil) then
      print('unable to open mob_spawn_points.sql')
      return nil;
  end
  index = 1
  item = ""
  for line in io.lines(_addon.path .. 'mob_spawn_points.sql') do
    if string.find(line, 'INSERT') then
      -- get everything between ()
      item = string.match(line, "%((.+)%)")
      mob_spawn_points[index] = StringSplit(item, ',')
      index = index + 1
    end
  end
  print('finished reading mob_spawn_points')
  file:close();
end;

function loadItemBasic()
  -- Load the file for reading..
  local file = io.open(_addon.path .. 'item_basic.sql', 'rb');
  if (file == nil) then
      print('unable to open item_basic.sql')
      return nil;
  end
  index = 1
  item = ""
  for line in io.lines(_addon.path .. 'item_basic.sql') do
    if string.find(line, 'INSERT') then
      -- get everything between ()
      item = string.match(line, "%((.+)%)")
      item_basic[index] = StringSplit(item, ',')
      index = index + 1
    end
  end
  print('finished reading item_basic')
  file:close();
end;

function findItem(value)
  if (tonumber(value) ~= nil) then --if input is a digit, look up by ID
    value = tonumber(value)
    for index=1, #item_basic do
        --if (string.find(item_basic[index][1], value, 1, true)) then
      if (tonumber(item_basic[index][1]) == tonumber(value)) then
        return item_basic[index]
      end
    end
  else -- input is a string, look up by name
    value = value:gsub(' ', '_') -- replace spaces with underscores
    value = value:gsub("'", "") -- remove apostrophe, there are none in the list
    for index=1, #item_basic do
      if (string.find(item_basic[index][3], value, 1, true)) then
        return item_basic[index]
      end
    end
    for index=1, #item_basic do
      if (string.find(item_basic[index][4], value, 1, true)) then
        return item_basic[index]
      end
    end
  end
  return nil
end;

function findMobDropList(value, field)
  returnList = {}
  listIndex = 1
  if (field == 'itemId') then-- by itemId
    for index=1, #mob_droplist do
      --if (string.find(mob_droplist[index][5], value, 1, true)) then
      if (tonumber(mob_droplist[index][5]) == tonumber(value)) then
        returnList[listIndex] = mob_droplist[index]
        listIndex = listIndex + 1
      end
    end
  else -- by dropId
    for index=1, #mob_droplist do
      --if (string.find(mob_droplist[index][1], value, 1, true)) then
      if (tonumber(mob_droplist[index][1]) == tonumber(value)) then
        returnList[listIndex] = mob_droplist[index]
        listIndex = listIndex + 1
      end
    end
  end
  
  return returnList
end;

function findMobGroups(value, field)
  returnList = {}
  listIndex = 1
  if (field == 'dropId') then-- by dropId
    for index=1, #mob_groups do
--        if (string.find(mob_groups[index][6], value, 1, true)) then
      if (tonumber(mob_groups[index][6]) == tonumber(value)) then
        returnList[listIndex] = mob_groups[index]
        listIndex = listIndex + 1
      end
    end
  elseif (field == 'groupId') then -- by groupId
    for index=1, #mob_groups do
      if (tonumber(mob_groups[index][1]) == tonumber(value)) then
        return mob_groups[index] -- should be only one, no need for list
      end
    end
  end
  
  return returnList
end;

function findMobSpawnPoints(value, field)
  returnList = {}
  listIndex = 1
  if (field == 'groupId') then -- by groupId
    for index=1, #mob_spawn_points do
        --if (string.find(mob_spawn_points[index][4], value, 1, true)) then
        if (tonumber(mob_spawn_points[index][4]) == tonumber(value)) then
          returnList[listIndex] = mob_spawn_points[index]
          listIndex = listIndex + 1
        end
    end
  elseif (field == 'mobId') then -- by mobId
    for index=1, #mob_spawn_points do
      if (tonumber(mob_spawn_points[index][1]) == tonumber(value)) then
        return mob_spawn_points[index] -- should be just one, no need for list
      end
    end
  end
  
  return returnList
end;

-- Note, up to the caller of the function to pass in valid data
function displayItem(item)
  print ("Name: " .. string.gsub(item[3], '_', ' '))
  print ("Item ID: " .. item[1])
  print ("stack Size: " .. item[5])
  print ("Auction House ID: " .. AuctionHouseIdToString(item[7]))
end;

function displayMob(mob)
  mobSpawn = findMobSpawnPoints(mob, 'mobId')
  mobGroup = findMobGroups(mobSpawn[4], 'groupId')
  mobDropList = findMobDropList(mobGroup[6], 'dropId')

  if (mobSpawn[3] == nil) then
    return false
  end
  print ("Name: " .. mobSpawn[3])
  print ("MobGroupId: " .. mobGroup[1])
  print ("Zone: " .. ZoneIdToString(mobGroup[3]))
  print ("Respawn Time: " .. mobGroup[4]/60.0 .. " minutes")
  print ("Level Range: " .. mobGroup[9] .. " - " .. mobGroup[10])
  print ("Drops:")
  for index=1, #mobDropList do
    item = findItem(mobDropList[index][5])
    if (item == nil) then
      print ("item is nil")
    else
      print (mobDropList[index][6]/10.0 .. "%  " .. string.gsub(item[3], '_', ' '))
    end
  end
end;

function findDroprate(item)
  droplists = findMobDropList(item[1], 'itemId')
  currentdrop = {}
  mobgroups = {}
  mobSpawns = {}
  dropIndex = 1
  for dropIndex=1, #droplists do
    drop = droplists[dropIndex]
    --check to see if there is a second drop of item on current list
    if (currentdrop[1] == drop[1] and currentdrop[5] == drop[5]) then
      print(drop[6]/10.0 .. "%")
    else -- new drop list
      currentdrop = drop
      mobgroups = findMobGroups(drop[1], 'dropId')
      if (#mobgroups == 0) then
        print("Warning: no Group with dropId " .. drop[1] .. " Found. no point to show anything")
      elseif (#mobgroups > 0) then
        for mobgroupIndex=1, #mobgroups do
          mobSpawns = findMobSpawnPoints(mobgroups[mobgroupIndex][1], 'groupId')
          if (#mobSpawns == 0) then
            print ("Name: No Spawns found for this mobgroupId " .. mobgroups[mobgroupIndex][1])
          else
            print ("Name: " .. mobSpawns[1][3])
            print ("Number of Spawns: " .. #mobSpawns)
          end
        end
        --print ("MobGroupId: " .. mobgroups[1][1])
        print ("Zone: " .. ZoneIdToString(mobgroups[1][3]))
        print ("Respawn Time: " .. mobgroups[1][4]/60.0 .. " minutes")
        print ("Level Range: " .. mobgroups[1][9] .. " - " .. mobgroups[1][10])
      end
        print ("Drop Rate for " .. string.gsub(item[3], '_', ' '))
        print (drop[6]/10.0 .. "%")
    end
  end
end;

----------------------------------------------------------------------------------------------------
-- func: load
-- desc: Event called when the addon is being loaded.
----------------------------------------------------------------------------------------------------
ashita.register_event('load', function()
  loadItemBasic()
  loadMobDropList()
  loadMobGroup()
  loadMobSpawnPoint()
end);

----------------------------------------------------------------------------------------------------
-- func: unload
-- desc: Event called when the addon is being unloaded.
----------------------------------------------------------------------------------------------------
ashita.register_event('unload', function()
end);


ashita.register_event('command', function(cmd, nType)
    -- Ensure we should handle this command..
    cmd = string.lower(cmd)
    local args = getFindArgs(cmd);
    if (args == nil) then
      return false
    end
    if (args[1] ~= '/lookup') then
        return false;
    end
    if (args[2] == 'help') then
      print('/lookup item')
      print('-- will look up item by either ID or Name')
      print('/lookup droprate')
      print('-- will look up who drops your item and what rate')
      print('/lookup target or /lookup <t>')
      print('-- will display some information about targeted mob, will not work on NPCs or players')
    elseif (args[2] == 'item') then
      item = findItem(args[3])
      if (item == nil) then
        print('did not find item ' .. args[3])
      else
        displayItem(item)
      end
    elseif (args[2] == 'droprate') then
          item = findItem(args[3])
      if (item == nil) then
        print('did not find droprate for ' .. args[3])
      else
        findDroprate(item)
      end
    elseif (args[2] == 'target' or args[2] == '<t>') then
      target = AshitaCore:GetDataManager():GetTarget():GetTargetServerId();
      if (target == nil) then
        print('no target found.')
      else
        displayMob(target)
      end
    else
      print('all possible commands')
      print('/lookup help')
      print('/lookup item')
      print('/lookup droprate')
      print('/lookup target')
      print('/lookup <t>')
    end
    
    return false
end);