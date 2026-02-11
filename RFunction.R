library(move2)
library(ggplot2)
library(ggspatial)
library(prettymapr)

## The parameter "data" is reserved for the data object passed on from the previous app

# to display messages to the user in the log file of the App in MoveApps
# one can use the function from the logger.R file:
# logger.fatal(), logger.error(), logger.warn(), logger.info(), logger.debug(), logger.trace()

rFunction = function(data, linewidth, ...) {
  # Create basemap with scale bar
  basemap <- ggplot() +
    annotation_map_tile(type = "cartolight", zoomin = 0) +
    annotation_scale(location = "br")
  
  # Add track line segments
  map <- basemap + 
    geom_sf(
      data = mt_track_lines(data),
      aes(color = .data[[mt_track_id_column(data)]]),
      alpha = 0.8,
      linewidth = linewidth
    )
  
  # Adjust plot theme
  map <- map + 
    theme_linedraw() +
    guides(color = "none")
  
  # Save to output file
  ggsave(moveapps::appArtifactPath("example_track_lines.png"), plot = map)
  
  # provide my result to the next app in the MoveApps workflow
  return(data)
}
