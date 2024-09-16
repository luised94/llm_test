# Load necessary libraries
options(bitmapType="cairo")
library(ggplot2)
library(animation)

# Define the donut shape
donut_shape <- function(x, y, r, theta, color) {
  data.frame(x = x, y = y, color = color)
}

# Define the radius of the donut
r <- 1

# Create a sequence of angles
theta <- seq(0, 2 * pi, length.out = 100)

# Generate the donut data
donut_data <- lapply(theta, function(theta) {
  x <- r * cos(theta)
  y <- r * sin(theta)
  donut_shape(x, y, r, theta, "red")
})

# Create the animation
saveGIF({
  for (i in 1:length(theta)) {
    p <- ggplot(donut_data[[i]], aes(x = x, y = y, color = color)) +
      geom_point() +
      theme_void() +
      coord_polar(theta = theta[i])
    png(paste("frame_", round(theta[i], 3), ".png", sep = ""), width = 400, height = 400, res = 100)
    print(p)
    dev.off()
  }
}, interval = 0.1, movie.name = "spinning_donut.gif")
