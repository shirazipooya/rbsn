DashHeader <- dashboardHeader(
     title = "RBSN Daily Data"
)

DashSidebar <- dashboardSidebar(
     sidebarMenu(
          menuItem(
               text = "Data",
               tabName = "DataTab",
               icon = icon("download")),
          menuItem(
               text = "Graphs",
               tabName = "GraphsTab",
               icon = icon("bar-chart-o")
          )
     )
)

DashBody <- dashboardBody(
     tabItems(
          # Data Page:
          tabItem(
               tabName = "DataTab",
               h1("Data Page"),
               fluidRow(
                    box(
                         width = 3,
                         title = "Controls",
                         status = "primary",
                         solidHeader = TRUE,
                         # Select a Station
                         selectInput(
                              inputId = "Data_SelectStation",
                              label = "Select a Station:",
                              choices = sort(x = station[,"Name"]),
                              selected = sort(x = station[,"Name"])[1]
                         ),
                         # Select Date Range
                         dateRangeInput(
                              inputId = "Data_SelectDate",
                              label = "Select Date Range:",
                              start = "1951-01-01",
                              end = "2017-12-31",
                              min = "1951-01-01",
                              max = "2017-12-31"
                         ),
                         # Select Time Interval
                         radioButtons(
                              inputId = "Data_TimeInterval",
                              label = "Select Time Interval:",
                              choices = c("Yearly", "Monthly", "Daily"),
                              selected = "Yearly"
                         ),
                         # Download Data
                         downloadButton(
                              outputId = "Data_Download",
                              label = "Download"
                         )
                    ),
                    box(
                         width = 9,
                         title = "Data",
                         status = "primary",
                         solidHeader = TRUE,
                         # Placeholder for Plot
                         DT::dataTableOutput(outputId = "Data_viwe")
                    )
               )
          ),
          # Graphs Page
          tabItem(
               tabName = "GraphsTab",
               h1("Graphs Page"),
               # Graphs 01:
               fluidRow(
                    box(
                         width = 3,
                         title = "Controls",
                         status = "primary",
                         solidHeader = TRUE,
                         # Select a Stations:
                         selectInput(
                              inputId = "Graphs_01_SelectStation",
                              label = "Select a Station:",
                              choices = sort(x = station[,"Name"]),
                              selected = sort(x = station[,"Name"])[1]
                         ),
                         # Select a Parameter:
                         selectInput(
                              inputId = "Graphs_01_SelectParameter",
                              label = "Select a Meteorological Parameter:",
                              choices = para[,"Parameter"],
                              selected = para[,"Parameter"][1]
                         ),
                         # Select Date Range:
                         dateRangeInput(
                              inputId = "Graphs_01_SelectDate",
                              label = "Select Date Range:",
                              start = "1951-01-01",
                              end = "2017-12-31",
                              min = "1951-01-01",
                              max = "2017-12-31"
                         ),
                         # Select Type of Graph:
                         selectInput(
                              inputId = "Graphs_01_GraphType",
                              label = "Select a Graph Type:",
                              choices = sort(c("Scatterplot", "Histogram", "Density Plot", "Box Plot")), 
                              selected = "Scatterplot"
                         ),
                         # Select Time Interval:
                         radioButtons(
                              inputId = "Graphs_01_TimeInterval",
                              label = "Select Time Interval:",
                              choices = c("Yearly", "Monthly", "Daily"),
                              selected = "Yearly"
                         ),
                         # Select Bins:
                         sliderInput(
                              inputId = "Graphs_01_GraphBins",
                              label = "Choose Bin Sizes for Histogram:",
                              min = 0,
                              max = 100,
                              value = 50
                         )
                    ),
                    box(
                         width = 9,
                         title = "Graph",
                         status = "primary",
                         solidHeader = TRUE,
                         plotOutput(outputId = "Graphs_01")
                    )
               # ),
               # # Graphs 02:
               # fluidRow(
               #      box(
               #           width = 3,
               #           title = "Controls",
               #           status = "primary",
               #           solidHeader = TRUE,
               #           # Select a Stations
               #           selectInput(
               #                inputId = "SelectStation1",
               #                label = "Select a Station",
               #                choices = sort(x = station[,"Name"]),
               #                selected = sort(x = station[,"Name"])[1]
               #           ),
               #           # Select a Parameter
               #           selectInput(
               #                inputId = "SelectParameter1",
               #                label = "Select a Parameter",
               #                choices = para[,"Parameter"],
               #                selected = para[,"Parameter"][1]
               #           ),
               #           # Select Date Range
               #           dateRangeInput(
               #                inputId = "SelectDate1",
               #                label = "Select Date Duration",
               #                start = "1951-01-01",
               #                end = "2017-12-31",
               #                min = "1951-01-01",
               #                max = "2017-12-31"
               #           ),
               #           # Select Type of Graph
               #           selectInput(
               #                inputId = "SelectGraph1",
               #                label = "Select a Graph",
               #                choices = sort(c("Scatterplot", "Boxplot", "Barplot",
               #                                 "Histogram", "Violin plot", "Density plot")), 
               #                selected = "Histogram"
               #           )
               #      ),
               #      box(
               #           width = 9,
               #           title = "Graph",
               #           status = "primary",
               #           solidHeader = TRUE,
               #           # Placeholder for Plot
               #           plotOutput(outputId = "StationPlot1")
               #      )
               )
          )
     )
)
     
     
     dashboardPage(
          header = DashHeader,
          sidebar = DashSidebar,
          body = DashBody,
          title = "RBSN Daily Data",
          skin = "blue"
     )