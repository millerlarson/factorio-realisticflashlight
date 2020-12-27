-- Settings
local enable_light_halo = settings.startup["rf-enable-light-halo"].value
local enable_vehicle_light_halo = settings.startup["rf-enable-vehicle-light-halo"].value

-- Character
local character_picture =
  {
    filename = "__RealisticFlashlight__/lightcone_enhanced.png",
    priority = "extra-high",
    flags = {"light"},
    scale = 2,
    width = 350,
    height = 370
  }

local character_halo =
  {
    minimum_darkness = 0.1,
    intensity = 0.3,
    size = 40,
    color = {r=1.0, g=1.0, b=1.0}
  }

local flashlight =
  {
    type = "oriented",
    minimum_darkness = 0.1,
    picture = character_picture,
    shift = {0, -24},
    size = 2,
    intensity = 0.9,
    color = {r=1.0, g=1.0, b=1.0}
  }

local character = data.raw.player and data.raw.player.player or data.raw.character and data.raw.character.character

if character then
  if enable_light_halo then
    character.light = {character_halo, flashlight}
  else
    character.light = {flashlight}
  end
end


-- Vehicles
local vehicle_picture =
  {
    filename = "__RealisticFlashlight__/lightcone_enhanced-vehicle.png",
    priority = "extra-high",
    flags = {"light"},
    scale = 2,
    width = 350,
    height = 370
  }

local vehicle_halo =
  {
    minimum_darkness = 0.1,
    intensity = 0.2,
    size = 30,
  }

local vehicle_headlights =
  {
    type = "oriented",
    minimum_darkness = 0.1,
    picture = vehicle_picture,
    shift = {0, -25},
    size = 2,
    intensity = 1.0,
    color = {r=1.0, g=1.0, b=1.0}
  }


-- Car and tank
for _, vehicle in pairs(data.raw["car"]) do
  if vehicle then
    if enable_vehicle_light_halo then
      vehicle.light = {vehicle_halo, vehicle_headlights}
    else
      vehicle.light = {vehicle_headlights}
    end
  end
end

-- Spidertron
for _, spider in pairs(data.raw["spider-vehicle"]) do
  if spider then
    if enable_vehicle_light_halo then
      spider.graphics_set.light = {vehicle_halo, vehicle_headlights}
    else
      spider.graphics_set.light = {vehicle_headlights}
    end
  end
end

-- Locomotive
for _, loco in pairs(data.raw["locomotive"]) do
  if loco then
    if enable_vehicle_light_halo then
      loco.front_light =
      {
        vehicle_halo, vehicle_halo, vehicle_headlights
      }
      loco.stand_by_light =
      {
          {
              color = {b=1},
              shift = {-0.6, -3.5},
              size = 2,
              intensity = 0.6
          }
      }
    else
      loco.front_light = {vehicle_headlights}
      loco.stand_by_light =
      {
          {
              color = {b=1},
              shift = {-0.6, -3.5},
              size = 2,
              intensity = 0.6
          }
      }
    end
  end
end