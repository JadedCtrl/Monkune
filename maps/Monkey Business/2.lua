return {
  version = "1.4",
  luaversion = "5.1",
  tiledversion = "1.4.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 50,
  height = 20,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 7,
  nextobjectid = 18,
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
          id = 1,
          name = "",
          type = "",
          shape = "polygon",
          x = 752,
          y = 128,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -224, y = 48 },
            { x = -1.33333, y = 48 }
          },
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 748,
          y = 14.6667,
          width = 52,
          height = 161.333,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1.33333,
          y = 177.333,
          width = 797.333,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = -2.66667,
          y = 30.6667,
          width = 510.667,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = -2.66667,
          y = 46.6667,
          width = 20,
          height = 145.333,
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
          x = 697.333,
          y = 134.667,
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
          x = 54.6667,
          y = 174.667,
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
          id = 16,
          name = "",
          type = "",
          shape = "text",
          x = 515.628,
          y = 63.5,
          width = 82.0781,
          height = 17,
          rotation = 0,
          visible = true,
          text = "touch it! go on!",
          wrap = true,
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "text",
          x = 151.628,
          y = 63.5,
          width = 82.0781,
          height = 17,
          rotation = 0,
          visible = true,
          text = "frozen monkeys + frozen buttons",
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
          x = 444,
          y = 49.3333,
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
          x = 110.667,
          y = 48,
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
          x = 480,
          y = 166.667,
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
          x = 176,
          y = 166.667,
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
