library(animation)
library(rgl)

options(rgl.printRglwidget = TRUE)
options(rgl.movie.format = "gif")

donut <- function(u, v, r1 = 2, r2 = 1) {
  x <- (r1 + r2 * cos(v)) * cos(u)
  y <- (r1 + r2 * cos(v)) * sin(u)
  z <- r2 * sin(v)
  cbind(x, y, z)
}

plot_donut <- function(donut, u, v) {
  open3d()
  plot3d(donut(u, v), type = "l", col = "blue")
}

animate_donut <- function(donut, angles, filename) {
  movie3d({
    for (i in seq_along(angles)) {
      clear3d()
      plot_donut(donut, angles[i], seq(0, 2 * pi, length.out = 100))
    }
  }, dir = "animation_frames", convert = TRUE, output = filename)
}

angles <- seq(0, 2 * pi, length.out = 100)
animate_donut(donut, angles, "spinning_donut.gif")
