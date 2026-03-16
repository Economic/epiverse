library(ggplot2)
library(hexSticker)
library(showtext)


font_add_google("Playfair Display", "playfair")
showtext_auto()

# Hexagon colors
fill_colors <- c(
  "#82112c",
  "#983511",
  "#0b6c2f",
  "#0e5b8b",
  "#790d76",
  "#3b91be"
)

# Pointy-top hex vertices (matches sticker orientation)
make_hex <- function(cx, cy, r) {
  a <- (90 + 0:5 * 60) * pi / 180
  data.frame(x = cx + r * cos(a), y = cy + r * sin(a))
}

# 6 hexagons on distinct elliptical orbits, all different sizes
# 4 larger + 2 smaller, each unique
orbits <- data.frame(
  hex_r = c(0.10, 0.09, 0.08, 0.07, 0.05, 0.06), # all different sizes
  a = c(0.22, 0.34, 0.44, 0.17, 0.42, 0.28), # semi-major axis (horizontal)
  b = c(0.14, 0.20, 0.26, 0.28, 0.26, 0.46), # semi-minor axis (vertical)
  angle = c(60, 230, 280, 150, 0, 50), # position on ellipse
  tilt = c(15, 15, 15, -20, -20, 15) # ellipse tilt (degrees)
)

# Compute hex centers on tilted ellipses
orbits$cx <- with(orbits, {
  t <- angle * pi / 180
  rot <- tilt * pi / 180
  a * cos(t) * cos(rot) - b * sin(t) * sin(rot)
})
orbits$cy <- with(orbits, {
  t <- angle * pi / 180
  rot <- tilt * pi / 180
  a * cos(t) * sin(rot) + b * sin(t) * cos(rot)
})

# Build hex polygon data
hexagons <- do.call(
  rbind,
  lapply(seq_len(nrow(orbits)), function(i) {
    h <- make_hex(orbits$cx[i], orbits$cy[i], orbits$hex_r[i])
    h$group <- i
    h$fill_color <- fill_colors[i]
    h
  })
)

# Elliptical orbit paths
orbit_paths <- do.call(
  rbind,
  lapply(seq_len(nrow(orbits)), function(i) {
    theta <- seq(0, 2 * pi, length.out = 200)
    rot <- orbits$tilt[i] * pi / 180
    x0 <- orbits$a[i] * cos(theta)
    y0 <- orbits$b[i] * sin(theta)
    data.frame(
      x = x0 * cos(rot) - y0 * sin(rot),
      y = x0 * sin(rot) + y0 * cos(rot),
      group = i
    )
  })
)

# Just the orbiting hexagons image (no text — sticker() adds that)
p <- ggplot() +
  geom_path(
    data = orbit_paths,
    aes(x = x, y = y, group = group),
    color = "#fdc35a",
    linewidth = 0.50,
    linetype = "dotted"
  ) +
  geom_polygon(
    data = hexagons,
    aes(x = x, y = y, group = group, fill = fill_color),
    color = "black",
    linewidth = 0.4
  ) +
  scale_fill_identity() +
  coord_equal() +
  theme_void() +
  theme(legend.position = "none")

# Use sticker() with "epiverse" in the center
sticker(
  p,
  package = "epiverse",
  p_family = "playfair",
  p_size = 30,
  p_color = "white",
  p_fontface = "bold",
  p_y = 1.0,
  s_x = 1,
  s_y = 1.0,
  s_width = 2.0,
  s_height = 1.8,
  h_fill = "black",
  h_color = "black",
  h_size = 0,
  filename = here::here("man/figures/logo.png")
)
