return {
  version = "1.4",
  luaversion = "5.1",
  tiledversion = "1.4.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 50,
  height = 50,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 4,
  nextobjectid = 20,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "Object Layer 1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 38.932,
          y = 306.814,
          width = 14.6488,
          height = 242.519,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 55.2085,
          y = 537.94,
          width = 524.102,
          height = 11.3935,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 581.752,
          y = 306,
          width = 14.6488,
          height = 242.52,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "Object Layer 2",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 9,
          name = "",
          type = "spawn",
          shape = "point",
          x = 378.031,
          y = 420.905,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["count"] = 10
          }
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "polygon",
          x = 800,
          y = 524.242,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -360.606, y = 269.697 },
            { x = -6.06061, y = 266.667 }
          },
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 46.6667,
          y = 785.333,
          width = 66.6667,
          height = 14.6667,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 177.333,
          y = 784,
          width = 105.333,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 346.667,
          y = 782.667,
          width = 54.6667,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
