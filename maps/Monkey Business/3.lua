return {
  version = "1.4",
  luaversion = "5.1",
  tiledversion = "1.4.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 100,
  height = 100,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 5,
  nextobjectid = 14,
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
          shape = "rectangle",
          x = 333.333,
          y = 950.667,
          width = 754.667,
          height = 93.3333,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 624.667,
          y = 79.3333,
          width = 162,
          height = 18,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 626.667,
          y = 98.3333,
          width = 21,
          height = 109,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 767.667,
          y = 98.3333,
          width = 20,
          height = 108,
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
      name = "doors",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 5,
          name = "",
          type = "door",
          shape = "rectangle",
          x = 628.667,
          y = 192.333,
          width = 159,
          height = 17,
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
      name = "buttons",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 6,
          name = "",
          type = "button",
          shape = "rectangle",
          x = 672.667,
          y = 393.667,
          width = 70.3333,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "banana",
          shape = "point",
          x = 702.667,
          y = 191.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "spawn",
          shape = "point",
          x = 711.667,
          y = 950.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["count"] = "10"
          }
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "text",
          x = 663.703,
          y = 786.5,
          width = 80.5938,
          height = 19,
          rotation = 0,
          visible = true,
          text = "+/- to zoom",
          wrap = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 858.667,
          y = 613.333,
          width = 24,
          height = 76,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "polygon",
          x = 870.667,
          y = 580,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -25.3333, y = 38.6667 },
            { x = 30.6667, y = 38.6667 }
          },
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 566.667,
          y = 412,
          width = 302.667,
          height = 41.3333,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
