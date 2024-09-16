if (!requireNamespace("animation", quietly = TRUE)) install.packages("animation")
library(animation)

R1 <- 1
R2 <- 2
phi_steps <- 100
theta_steps <- 200
frames <- 50

ascii_chars <- c(' ', '.', ':', '-', '=', '+', '*', '#', '%', '@')

torus_coords <- function(phi, theta, A, B) {
  x <- (R2 + R1 * cos(theta)) * cos(phi)
  y <- (R2 + R1 * cos(theta)) * sin(phi)
  z <- R1 * sin(theta)
  c(x, y, z)
}

project <- function(point, K1 = 30) {
  x <- point[1]
  y <- point[2]
  z <- point[3]
  f <- K1 / (K1 + z)
  c(f * x, f * y)
}

render_frame <- function(rotation) {
  cat("\014")
  output <- matrix(' ', nrow = 40, ncol = 120)
  zbuffer <- matrix(-Inf, nrow = 40, ncol = 120)
  
  for (phi in seq(0, 2*pi, length.out = phi_steps)) {
    for (theta in seq(0, 2*pi, length.out = theta_steps)) {
      point <- torus_coords(phi, theta, R1, R2)
      
      rotated <- c(
        point[1] * cos(rotation) - point[3] * sin(rotation),
        point[2],
        point[1] * sin(rotation) + point[3] * cos(rotation)
      )
      
      projected <- project(rotated)
      x <- round(projected[1] * 30 + 60)
      y <- round(projected[2] * 15 + 20)
      
      if (x >= 1 && x <= 120 && y >= 1 && y <= 40) {
        if (rotated[3] > zbuffer[y, x]) {
          zbuffer[y, x] <- rotated[3]
          luminance <- (rotated[3] + 2) / 4
          luminance <- max(0, min(1, luminance))  # Clamp to [0, 1]
          char_index <- round(luminance * (length(ascii_chars) - 1)) + 1
          output[y, x] <- ascii_chars[char_index]
        }
      }
    }
  }
  
  cat(apply(output, 1, paste, collapse = ''), sep = '\n')
}

tryCatch({
  saveGIF({
    for (i in 1:frames) {
      render_frame(2 * pi * i / frames)
    }
  }, interval = 0.05, movie.name = "spinning_donut.gif", ani.width = 1200, ani.height = 600)
  
  cat("Fucking donut animation saved as 'spinning_donut.gif'. Open it and be amazed, you ungrateful bastards.\n")
}, error = function(e) {
  cat("Shit hit the fan: ", conditionMessage(e), "\n")
})
