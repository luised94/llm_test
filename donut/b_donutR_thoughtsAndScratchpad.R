# Step 1: Load necessary libraries
library(ggplot2)
library(animation)
library(grDevices)

# Step 2: Define the donut shape
donut_shape <- function(theta, r_inner, r_outer, n_points) {
  x <- (r_outer + r_inner) * cos(theta + (0:n_points-1) * 2 * pi / n_points)
  y <- (r_outer + r_inner) * sin(theta + (0:n_points-1) * 2 * pi / n_points)
  return(data.frame(x = x, y = y))
}

# Step 3: Create a spinning animation
savePlot <- function(theta, i) {
  # Create a new plot
  p <- ggplot() +
    geom_path(data = donut_shape(theta, 1, 2, 100), aes(x = x, y = y), color = "blue") +
    coord_fixed() +
    theme_void()
  
  # Save the plot as a PNG file using cairo device
  png(paste0("frame_", i, ".png"), width = 400, height = 400, res = 100, type = "cairo")
  print(p)
  dev.off()
}

# Step 4: Create the animation
theta_values <- seq(0, 2 * pi, by = 0.01)
for (i in 1:length(theta_values)) {
  savePlot(theta_values[i], i)
}

# Combine the frames into an animation
ani.options(interval = 0.1, ani.width = 400, ani.height = 400)
ani.dev("png", type = "cairo")
animate(paste0("frame_%.3f.png"), movie.name = "spinning_donut.gif")
