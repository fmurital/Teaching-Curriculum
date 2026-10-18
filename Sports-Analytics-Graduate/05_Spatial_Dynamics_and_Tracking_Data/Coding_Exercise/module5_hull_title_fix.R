options(width=120)
library(BasketballAnalyzeR); library(dplyr); library(ggplot2)
out_dir <- "Sports-Analytics-Graduate/05_Spatial_Dynamics_and_Tracking_Data/Coding_Exercise"
data(PbP.BDB); PbP <- PbPmanipulation(PbP.BDB)
shots <- subset(PbP, ShotType %in% c("2P","3P") & !is.na(original_x) & !is.na(original_y))
shots$x_ft <- shots$original_x/10; shots$y_ft <- shots$original_y/10
curry <- shots %>% filter(team=="GSW", player=="Stephen Curry")
green <- shots %>% filter(team=="GSW", player=="Draymond Green")
hull_area <- function(df){h<-chull(df$x_ft,df$y_ft); hpts<-df[h,c("x_ft","y_ft")]; list(hull=hpts)}
h_curry <- hull_area(curry); h_green <- hull_area(green)
p_hulls <- ggplot() +
  geom_point(data = curry, aes(x_ft, y_ft), color = "#1D428A", alpha = 0.5, size = 1.5) +
  geom_polygon(data = h_curry$hull, aes(x_ft, y_ft), fill = "#1D428A", alpha = 0.15, color = "#1D428A", linewidth = 1) +
  geom_point(data = green, aes(x_ft, y_ft), color = "#E4572E", alpha = 0.5, size = 1.5) +
  geom_polygon(data = h_green$hull, aes(x_ft, y_ft), fill = "#E4572E", alpha = 0.15, color = "#E4572E", linewidth = 1) +
  coord_fixed() + theme_minimal(base_size=13) +
  labs(title = "Real Shot-Territory Convex Hulls, 2017-18",
       subtitle = "Blue = Stephen Curry (2,538 sq ft). Orange = Draymond Green (2,264 sq ft).",
       x = "Court X (ft)", y = "Court Y (ft)")
ggsave(file.path(out_dir, "module5_convex_hulls.png"), p_hulls, width = 9, height = 8, dpi = 150)
cat("done\n")
