Config = {}

Config.UseQBTarget = true  -- Cambiar a false si quieres desactivar qb-target


Config.StashCoords = {
    ["DeSanta1"] = {
        coords = vector3(-799.8, 177.1, 72.83),
        access = "everyone",  -- Opciones: "everyone", "job", "gang"
        allowedJobs = {},
        allowedGangs = {}, 
        stashSize = 100000,
        stashSlots = 50, 
    },
    ["DeSanta2"] = {
        coords = vector3(-811.89, 182.51, 76.74),
        access = "job",  
        allowedJobs = { "police", "ambulance" },
        allowedGangs = {}, 
        stashSize = 100000,
        stashSlots = 50, 
    },
    ["Clinton1"] = {
        coords = vector3(0.38, 525.07, 174.63),
        access = "gang",
        allowedJobs = {},
        allowedGangs = { "cartel" }, 
        stashSize = 100000,
        stashSlots = 50, 
    },
}

Config.WardrobeCoords = {
    ["DeSanta1"] = {
        coords = vector3(-803.96, 169.34, 76.74),
        access = "everyone",
        allowedJobs = {},
        allowedGangs = {}
    },
    ["DeSanta2"] = {
        coords = vector3(-811.69, 175.82, 76.75),
        access = "job",
        allowedJobs = { "police", "ambulance" },
        allowedGangs = {}
    },
    ["Clinton1"] = {
        coords = vector3(9.59, 529.12, 170.62),
        access = "gang",
        allowedJobs = {},
        allowedGangs = { "cartel" }
    },
}
