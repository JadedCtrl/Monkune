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
  nextlayerid = 7,
  nextobjectid = 23,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "platforms",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 779.288,
          y = 116.365,
          width = 20,
          height = 145.333,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 16.2311,
          y = 735.171,
          width = 782.91,
          height = 63.9694,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 112.663,
          y = 258.742,
          width = 683.614,
          height = 479.293,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "polygon",
          x = 301.707,
          y = 257.787,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -188.089, y = -98.3411 },
            { x = -189.044, y = 0.954768 }
          },
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 374.269,
          y = 118.391,
          width = 423.917,
          height = 21.9597,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "special",
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
          x = 50.0004,
          y = 727.578,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["count"] = 2
          }
        },
        {
          id = 12,
          name = "",
          type = "banana",
          shape = "point",
          x = 725.869,
          y = 252.003,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "signs",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 17,
          name = "",
          type = "",
          shape = "text",
          x = 407.506,
          y = 84.5049,
          width = 82.0781,
          height = 17,
          rotation = 0,
          visible = true,
          text = "frozen button + frozen monkey",
          wrap = true,
          properties = {}
        },
        {
          id = 22,
          name = "",
          type = "",
          shape = "text",
          x = 17.944,
          y = 604.416,
          width = 80.5938,
          height = 19,
          rotation = 0,
          visible = true,
          text = "climb!",
          wrap = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "doors",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 7,
          name = "",
          type = "door",
          shape = "rectangle",
          x = 376.211,
          y = 132.398,
          width = 20,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "frozenDoor",
          shape = "rectangle",
          x = 625.287,
          y = 128.201,
          width = 17.3333,
          height = 129.333,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "buttons",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 10,
          name = "",
          type = "button",
          shape = "rectangle",
          x = 304.323,
          y = 247.822,
          width = 42.6667,
          height = 9.33333,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "frozenButton",
          shape = "rectangle",
          x = 539.767,
          y = 249.732,
          width = 58.6667,
          height = 9.33333,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
