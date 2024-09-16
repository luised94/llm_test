# Load necessary libraries
if (!requireNamespace("rgl", quietly = TRUE)) {
  install.packages("rgl")
}
if (!requireNamespace("htmlwidgets", quietly = TRUE)) {
  install.packages("htmlwidgets")
}

library(rgl)
library(htmlwidgets)

# Function to create a torus
create_torus <- function(R = 3, r = 1, n = 100) {
  theta <- seq(0, 2 * pi, length.out = n)
  phi <- seq(0, 2 * pi, length.out = n)
  theta <- rep(theta, each = n)
  phi <- rep(phi, times = n)
  
  x <- (R + r * cos(phi)) * cos(theta)
  y <- (R + r * cos(phi)) * sin(theta)
  z <- r * sin(phi)
  
  return(list(x = x, y = y, z = z))
}

# Create the torus
torus <- create_torus()

# Open a new 3D device
open3d()

# Plot the torus
plot3d(torus$x, torus$y, torus$z, type = 's', col = 'blue', size = 0.5, xlab = "", ylab = "", zlab = "")

# Use rglwidget to create an HTML widget
widget <- rglwidget()

# Save the widget to an HTML file
saveWidget(widget, "spinning_donut.html")

# Note: This will create a static 3D plot in an HTML file. For animation, consider using JavaScript libraries.
