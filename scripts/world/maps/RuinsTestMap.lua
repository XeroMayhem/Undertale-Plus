return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 20,
  tileheight = 20,
  nextlayerid = 16,
  nextobjectid = 80,
  properties = {},
  tilesets = {
    {
      name = "ruins-tiles",
      firstgid = 1,
      class = "",
      tilewidth = 20,
      tileheight = 20,
      spacing = 0,
      margin = 0,
      columns = 8,
      image = "../../../assets/sprites/tilesets/Ruins-Tiles.png",
      imagewidth = 160,
      imageheight = 380,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 20,
        height = 20
      },
      properties = {},
      wangsets = {},
      tilecount = 152,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 1,
      name = "Ground",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
        9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
        9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
        9, 9, 9, 9, 9, 9, 9, 35, 36, 9, 9, 9, 9, 9, 9, 9,
        9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
        9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
        9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
        9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
        9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
        9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
        9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
        9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 6,
      name = "Leaves2",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 89, 0, 0, 91, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 89, 97, 0, 0, 99, 0, 91, 0, 0, 0, 0, 0, 0, 0, 0,
        89, 97, 105, 0, 0, 107, 0, 99, 91, 0, 0, 0, 0, 0, 0, 0,
        97, 105, 0, 0, 0, 0, 0, 91, 99, 0, 0, 0, 0, 0, 0, 0,
        105, 97, 89, 0, 0, 0, 0, 99, 107, 0, 0, 0, 0, 0, 0, 0,
        0, 105, 97, 0, 0, 0, 0, 99, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 105, 0, 0, 0, 0, 107, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 5,
      name = "Leaves",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 89, 90, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 90, 98, 98, 90, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 90, 98, 98, 98, 98, 98, 90, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 98, 98, 98, 98, 98, 98, 98, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 106, 98, 98, 98, 98, 98, 106, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 106, 98, 98, 98, 98, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 106, 106, 106, 106, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 2,
      name = "Wall",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        3, 3, 3, 4, 3, 4, 5, 47, 48, 2, 3, 4, 3, 3, 3, 3,
        3, 4, 3, 3, 3, 4, 5, 55, 56, 2, 3, 3, 3, 4, 3, 4,
        4, 3, 3, 3, 4, 4, 5, 63, 64, 2, 4, 3, 53, 54, 3, 3,
        11, 11, 11, 12, 11, 11, 13, 0, 0, 10, 11, 11, 61, 62, 12, 11,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 8,
      name = "Wall Decor",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 87, 0, 87, 0, 0, 0, 0, 0, 0, 0, 0, 0, 87, 0,
        0, 0, 87, 0, 87, 0, 0, 0, 0, 0, 0, 0, 0, 0, 87, 0,
        0, 0, 87, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 9,
      name = "Ceiling",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14,
        16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14,
        16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14,
        16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14,
        16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14,
        16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 0, 14,
        16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 0, 14,
        16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 0, 14,
        16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 0, 14,
        16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 0, 14,
        16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 0, 14,
        38, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 39
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 11,
      name = "Collision",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 80,
          width = 20,
          height = 140,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 20,
          y = 220,
          width = 280,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 300,
          y = 80,
          width = 20,
          height = 140,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 180,
          y = 40,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 20,
          y = 40,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 140,
          y = 20,
          width = 40,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 12,
      name = "Objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 28,
          name = "crack",
          type = "",
          shape = "point",
          x = 80,
          y = 100,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 39,
          name = "squeak",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 60,
          width = 40,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 42,
          name = "npc_noelle01",
          type = "",
          shape = "point",
          x = 240,
          y = 140,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["script"] = "noelle01",
            ["sprite"] = "Noelle.png"
          }
        },
        {
          id = 47,
          name = "npc_noelle02",
          type = "",
          shape = "point",
          x = 60,
          y = 180,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["script"] = "noelle02",
            ["sprite"] = "Noelle Inverted.png"
          }
        },
        {
          id = 58,
          name = "sign",
          type = "",
          shape = "point",
          x = 140,
          y = 120,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* Hey there!"
          }
        },
        {
          id = 79,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 140,
          y = 60,
          width = 40,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "Ruins01",
            ["marker"] = "down_entry"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 13,
      name = "Cutscene",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 50,
          name = "squeak",
          type = "",
          shape = "rectangle",
          x = 260,
          y = 200,
          width = 40,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 14,
      name = "Markers",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 55,
          name = "spawn",
          type = "",
          shape = "point",
          x = 80,
          y = 140,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 57,
          name = "down_entry",
          type = "",
          shape = "point",
          x = 160,
          y = 100,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
