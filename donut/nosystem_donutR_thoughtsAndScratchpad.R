## Install and load required packages
if (!requireNamespace("plotrix", quietly = TRUE)) install.packages("plotrix")
if (!requireNamespace("animation", quietly = TRUE)) install.packages("animation")
library(plotrix)
library(animation)

## Function to create donut points
create_donut <- function(R, r, n = 50) {
  theta <- seq(0, 2*pi, length.out = n)
  phi <- seq(0, 2*pi, length.out = n)
  theta_mat <- outer(theta, phi, FUN = function(t, p) t)
  phi_mat <- outer(theta, phi, FUN = function(t, p) p)
  x <- (R + r * cos(phi_mat)) * cos(theta_mat)
  y <- (R + r * cos(phi_mat)) * sin(theta_mat)
  z <- r * sin(phi_mat)
  list(x = x, y = y, z = z)
}

## Function to create rotation matrix
rotation_matrix <- function(angle, x, y, z) {
  angle <- angle * pi / 180
  c <- cos(angle)
  s <- sin(angle)
  matrix(c(
    x*x*(1-c)+c,   x*y*(1-c)-z*s, x*z*(1-c)+y*s,
    y*x*(1-c)+z*s, y*y*(1-c)+c,   y*z*(1-c)-x*s,
    z*x*(1-c)-y*s, z*y*(1-c)+x*s, z*z*(1-c)+c
  ), nrow = 3, byrow = TRUE)
}

## Animation function
animate_donut <- function() {
  R <- 1  # Major radius
  r <- 0.3  # Minor radius
  donut <- create_donut(R, r)
  
  for (angle in seq(0, 360, by = 10)) {
    rot_matrix <- rotation_matrix(angle, 1, 1, 0)
    rotated_donut <- rot_matrix %*% rbind(as.vector(donut$x), as.vector(donut$y), as.vector(donut$z))
    
    plot3D(matrix(rotated_donut[1,], ncol = 50), 
           matrix(rotated_donut[2,], ncol = 50), 
           matrix(rotated_donut[3,], ncol = 50),
           type = "n", xlim = c(-1.5, 1.5), ylim = c(-1.5, 1.5), zlim = c(-1.5, 1.5),
           xlab = "", ylab = "", zlab = "", main = "Spinning Donut")
    surface3D(matrix(rotated_donut[1,], ncol = 50), 
              matrix(rotated_donut[2,], ncol = 50), 
              matrix(rotated_donut[3,], ncol = 50),
              col = "pink", add = TRUE)
  }
}

## Create the animation
saveGIF(animate_donut(), interval = 0.1, movie.name = "spinning_donut.gif", ani.width = 500, ani.height = 500)
