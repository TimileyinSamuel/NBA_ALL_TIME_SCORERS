############################### NBA ALL-TIME SCORERS ###############################
### loading libraries
library(tidyverse)
library(tidylog)
library(gt)
library(gtExtras)
library(ggsci)

### Importing Data
df <- read_csv("https://raw.githubusercontent.com/TimileyinSamuel/NBA_ALL_TIME_SCORERS/main/nba_data.csv")

### Adding players' images to data set
df <- df |> 
  mutate(image = case_when(player == "LeBron James" ~ 
  "https://raw.githubusercontent.com/TimileyinSamuel/NBA_ALL_TIME_SCORERS/main/Players/lebron_james.png",
  player == "Kareem Abdul-Jabbar" ~ 
              "https://raw.githubusercontent.com/TimileyinSamuel/NBA_ALL_TIME_SCORERS/main/Players/kareem%20abdul-jabbar.png",
  player == "Karl Malone" ~ 
              "https://raw.githubusercontent.com/TimileyinSamuel/NBA_ALL_TIME_SCORERS/main/Players/karl_malone.png",
  player == "Kobe Bryant" ~ 
              "https://raw.githubusercontent.com/TimileyinSamuel/NBA_ALL_TIME_SCORERS/main/Players/kobe_bryant.png",
  player == "Michael Jordan" ~ 
              "https://raw.githubusercontent.com/TimileyinSamuel/NBA_ALL_TIME_SCORERS/main/Players/michael_jordan.png",
  player == "Dirk Nowitzki" ~ 
              "https://raw.githubusercontent.com/TimileyinSamuel/NBA_ALL_TIME_SCORERS/main/Players/dirk_nowitzki.png",
  player == "Wilt Chamberlain" ~ 
              "https://raw.githubusercontent.com/TimileyinSamuel/NBA_ALL_TIME_SCORERS/main/Players/wilt_chamberlain.png",
  player == "Shaquille O'Neal" ~ 
              "https://raw.githubusercontent.com/TimileyinSamuel/NBA_ALL_TIME_SCORERS/main/Players/Shaquille%20O'Neal.png",
  player == "Carmelo Anthony" ~ 
              "https://raw.githubusercontent.com/TimileyinSamuel/NBA_ALL_TIME_SCORERS/main/Players/carmelo%20anthony.png",
  player == "Moses Malone" ~ 
              "https://raw.githubusercontent.com/TimileyinSamuel/NBA_ALL_TIME_SCORERS/main/Players/Moses_Malone.png",
  TRUE ~ "No Image Available"))


### Selecting needed columns
df <- df |> 
  select(position, image, player, gamesplayed, minutes, points, assists, pointsperminute)

### Adding dots to the position
df <- df |> 
  mutate(position = paste0(position, "."))

### Making table
gt(df) |> 
## add image to the table
  gt_img_rows(columns = image, height = 40) |> 
## use new york times theme
  gt_theme_nytimes() |> 
## addblue colour palette for column "point per minute"
  gt_color_rows(pointsperminute, palette = "ggsci::blue_material") |> 
## align columns to centre or left
  cols_align(
    align = "center") |> 
  cols_align(
    align = "left",
    columns = (player)
  ) |> 
## rename column labels
  cols_label(
    image = "",
    position = "#",
    gamesplayed = "GAMES PLAYED",
    pointsperminute = "POINT PER MINUTE") |> 
## add title and subtitle
  tab_header(
    title = "NBA ALL-TIME POINTS LEADERS",
    subtitle = "Top 10 scorers as at March 14, 2023."
  ) |> 
## add source note
  tab_source_note(source_note = "Data: NBA | Graphic: @Timmy1Tesla") |> 
## setting column width for each column
  cols_width(
    position ~ px(24),
    image ~ px(100),
    player ~ px(170),
    gamesplayed ~ px(125),
    pointsperminute ~ px(118),
    everything() ~ px(100)
  ) |> 
## applying style to column headers (changing fonts and size)
  tab_style(
    locations = cells_title(groups = c("title", "subtitle")),
    style = list(
      cell_text(weight = "bold", size = 50)
    )) |> 
## additional theme features
  tab_options(table.background.color = "#FFFFFF", # change table background colour
              heading.title.font.size = 22, # change title font
              heading.subtitle.font.size = 14, # change subtitle font
              source_notes.font.size = 12, # change source note font
              column_labels.font.weight = "bold", # make column labels bold
              heading.padding = px(12), # add space between title and table header
              container.width = 920, # change table width
              container.height = 740, # change table height
              table_body.border.bottom.color = "grey", # make bottom border grey colour
              table_body.border.top.color = "black", # make top border black
              data_row.padding = px(3.5)) |> # reduce space between rows
  ## change column labels text colour and font
    tab_style(
    style = cell_text(color = "black"),
    locations = cells_column_labels()
## change text weight of player column
  ) |> 
    tab_style(
      style = cell_text(color = "black", weight = "normal"),
      locations = cells_body(
        columns = player
      )) |> 
## change font of all texts
      opt_table_font(
        font = google_font(name = "Montserrat")
      ) |> 
## align table title to the centre
  opt_align_table_header(align = "center") |> 
## Saving the table
gtsave(filename = "nba_viz.png", expand = 25)
