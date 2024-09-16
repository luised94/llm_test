# Load required libraries
library(animation)

# Define the 3D donut shape
donut_shape <- function(theta, phi) {
  r <- 1 + 0.5 * cos(phi)
  x <- r * cos(theta)
  y <- r * sin(theta)
  z <- 0.5 * sin(phi)
  return(cbind(x, y, z))
}

# Define the rotation function
rotate_donut <- function(theta, phi, angle) {
  donut <- donut_shape(theta, phi)
  rotation_matrix <- matrix(c(cos(angle), -sin(angle), 0, sin(angle), cos(angle), 0, 0, 0, 1), nrow = 3, byrow = TRUE)
  return(donut %*% rotation_matrix)
}

# Create the animation
ani.options(interval = 0.1, nmax = 100)
saveGIF({
  for (i in 1:100) {
    theta <- seq(0, 2 * pi, length.out = 100)
    phi <- seq(0, 2 * pi, length.out = 100)
    donut <- rotate_donut(theta, phi, i / 10)
    plot(donut[, 1], donut[, 2], type = "l", col = "blue", xlim = c(-2, 2), ylim = c(-2, 2))
  }
}, movie.name = "spinning_donut.gif", ani.width = 600, ani.height = 600)
