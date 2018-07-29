shinyServer(func = function(input, output, session){
     # Data Page: ----------------------------------------------------------------------------------
     # Create Data:
     MyDataset <- reactive({
          # Yearly:
          if (input$Data_TimeInterval == "Yearly")
          {
               data[[station[which(station$Name == input$Data_SelectStation),"ID"]]] %>% 
                    filter(date >= input$Data_SelectDate[1] & date <= input$Data_SelectDate[2]) %>%  
                    group_by(year = year(date)) %>% 
                    summarise(tmin = if(all(is.na(tmin))) NA else round(x = mean(x = tmin, na.rm = TRUE), digits = 1),
                              tave = if(all(is.na(tave))) NA else round(x = mean(x = tave, na.rm = TRUE), digits = 1),
                              tmax = if(all(is.na(tmax))) NA else round(x = mean(x = tmax, na.rm = TRUE), digits = 1),
                              dp   = if(all(is.na(dp))) NA else round(x = mean(x = dp, na.rm = TRUE), digits = 1),
                              prec = if(all(is.na(prec))) NA else round(x = sum(prec, na.rm = TRUE), digits = 1),
                              wd   = if(all(is.na(wd))) NA else round(x = mean(x = wd, na.rm = TRUE), digits = 1),
                              ws   = if(all(is.na(ws))) NA else round(x = mean(x = ws, na.rm = TRUE), digits = 1),
                              stp  = if(all(is.na(stp))) NA else round(x = mean(x = stp, na.rm = TRUE), digits = 1),
                              slp  = if(all(is.na(slp))) NA else round(x = mean(x = slp, na.rm = TRUE), digits = 1),
                              ea  = if(all(is.na(ea))) NA else round(x = mean(x = ea, na.rm = TRUE), digits = 1),
                              es  = if(all(is.na(es))) NA else round(x = mean(x = es, na.rm = TRUE), digits = 1),
                              rh   = if(all(is.na(rh))) NA else round(x = mean(x = rh, na.rm = TRUE), digits = 1))
          }
          # Monthly:
          else if (input$Data_TimeInterval == "Monthly")
          {
               data[[station[which(station$Name == input$Data_SelectStation),"ID"]]] %>%
                    filter(date >= input$Data_SelectDate[1] & date <= input$Data_SelectDate[2]) %>%  
                    group_by(year = year(date), month = month(date)) %>% 
                    summarise(tmin = if(all(is.na(tmin))) NA else round(x = mean(x = tmin, na.rm = TRUE), digits = 1),
                              tave = if(all(is.na(tave))) NA else round(x = mean(x = tave, na.rm = TRUE), digits = 1),
                              tmax = if(all(is.na(tmax))) NA else round(x = mean(x = tmax, na.rm = TRUE), digits = 1),
                              dp   = if(all(is.na(dp))) NA else round(x = mean(x = dp, na.rm = TRUE), digits = 1),
                              prec = if(all(is.na(prec))) NA else round(x = sum(prec, na.rm = TRUE), digits = 1),
                              wd   = if(all(is.na(wd))) NA else round(x = mean(x = wd, na.rm = TRUE), digits = 1),
                              ws   = if(all(is.na(ws))) NA else round(x = mean(x = ws, na.rm = TRUE), digits = 1),
                              stp  = if(all(is.na(stp))) NA else round(x = mean(x = stp, na.rm = TRUE), digits = 1),
                              slp  = if(all(is.na(slp))) NA else round(x = mean(x = slp, na.rm = TRUE), digits = 1),
                              ea  = if(all(is.na(ea))) NA else round(x = mean(x = ea, na.rm = TRUE), digits = 1),
                              es  = if(all(is.na(es))) NA else round(x = mean(x = es, na.rm = TRUE), digits = 1),
                              rh   = if(all(is.na(rh))) NA else round(x = mean(x = rh, na.rm = TRUE), digits = 1))
          }
          # Daily:
          else
          {
               data[[station[which(station$Name == input$Data_SelectStation),"ID"]]] %>%
                    select(-id, -lat, -lon, -elev) %>% 
                    filter(date >= input$Data_SelectDate[1] & date <= input$Data_SelectDate[2])
          }
     })
     
     # Data Viwe:
     output$Data_viwe <- DT::renderDataTable({
          DT::datatable(data = MyDataset(),
                        options = list(lengthMenu = c(10, 25, 50), 
                                       pageLength = 10))
     })
     
     # Data Download:
     output$Data_Download <- downloadHandler(
          filename = function()
          {
               paste(input$Data_SelectStation, " - ", input$Data_TimeInterval, ".csv", sep = "")
          },
          content = function(file)
          {
               write.csv(x = MyDataset(),
                         file = file,
                         row.names = FALSE)
          }
     )
     
     # Graphs Page: --------------------------------------------------------------------------------
     # Graphs 01:
     # Create Data:
     MyDataset_Graphs_01 <- reactive({
          # Yearly:
          if (input$Graphs_01_TimeInterval == "Yearly")
          {
               data[[station[which(station$Name == input$Graphs_01_SelectStation),"ID"]]] %>% 
                    filter(date >= input$Graphs_01_SelectDate[1] & date <= input$Graphs_01_SelectDate[2]) %>%  
                    group_by(year = year(date)) %>% 
                    summarise(tmin = if(all(is.na(tmin))) NA else round(x = mean(x = tmin, na.rm = TRUE), digits = 1),
                              tave = if(all(is.na(tave))) NA else round(x = mean(x = tave, na.rm = TRUE), digits = 1),
                              tmax = if(all(is.na(tmax))) NA else round(x = mean(x = tmax, na.rm = TRUE), digits = 1),
                              dp   = if(all(is.na(dp))) NA else round(x = mean(x = dp, na.rm = TRUE), digits = 1),
                              prec = if(all(is.na(prec))) NA else round(x = sum(prec, na.rm = TRUE), digits = 1),
                              wd   = if(all(is.na(wd))) NA else round(x = mean(x = wd, na.rm = TRUE), digits = 1),
                              ws   = if(all(is.na(ws))) NA else round(x = mean(x = ws, na.rm = TRUE), digits = 1),
                              stp  = if(all(is.na(stp))) NA else round(x = mean(x = stp, na.rm = TRUE), digits = 1),
                              slp  = if(all(is.na(slp))) NA else round(x = mean(x = slp, na.rm = TRUE), digits = 1),
                              ea  = if(all(is.na(ea))) NA else round(x = mean(x = ea, na.rm = TRUE), digits = 1),
                              es  = if(all(is.na(es))) NA else round(x = mean(x = es, na.rm = TRUE), digits = 1),
                              rh   = if(all(is.na(rh))) NA else round(x = mean(x = rh, na.rm = TRUE), digits = 1)) %>% 
                    mutate(Factor = factor(x = "Year"))
          }
          # Monthly:
          else if (input$Graphs_01_TimeInterval == "Monthly")
          {
               data[[station[which(station$Name == input$Graphs_01_SelectStation),"ID"]]] %>%
                    filter(date >= input$Graphs_01_SelectDate[1] & date <= input$Graphs_01_SelectDate[2]) %>%  
                    group_by(year = year(date), month = month(date)) %>% 
                    summarise(tmin = if(all(is.na(tmin))) NA else round(x = mean(x = tmin, na.rm = TRUE), digits = 1),
                              tave = if(all(is.na(tave))) NA else round(x = mean(x = tave, na.rm = TRUE), digits = 1),
                              tmax = if(all(is.na(tmax))) NA else round(x = mean(x = tmax, na.rm = TRUE), digits = 1),
                              dp   = if(all(is.na(dp))) NA else round(x = mean(x = dp, na.rm = TRUE), digits = 1),
                              prec = if(all(is.na(prec))) NA else round(x = sum(prec, na.rm = TRUE), digits = 1),
                              wd   = if(all(is.na(wd))) NA else round(x = mean(x = wd, na.rm = TRUE), digits = 1),
                              ws   = if(all(is.na(ws))) NA else round(x = mean(x = ws, na.rm = TRUE), digits = 1),
                              stp  = if(all(is.na(stp))) NA else round(x = mean(x = stp, na.rm = TRUE), digits = 1),
                              slp  = if(all(is.na(slp))) NA else round(x = mean(x = slp, na.rm = TRUE), digits = 1),
                              ea  = if(all(is.na(ea))) NA else round(x = mean(x = ea, na.rm = TRUE), digits = 1),
                              es  = if(all(is.na(es))) NA else round(x = mean(x = es, na.rm = TRUE), digits = 1),
                              rh   = if(all(is.na(rh))) NA else round(x = mean(x = rh, na.rm = TRUE), digits = 1)) %>% 
                    mutate(Factor = factor(x = month))
          }
          # Daily:
          else
          {
               data[[station[which(station$Name == input$Graphs_01_SelectStation),"ID"]]] %>%
                    select(-id, -lat, -lon, -elev) %>% 
                    filter(date >= input$Graphs_01_SelectDate[1] & date <= input$Graphs_01_SelectDate[2]) %>% 
                    mutate(Factor = factor(x = year(date)))
          }
     })
     
     output$Graphs_01 <- renderPlot({
          # Scatterplot
          if (input$Graphs_01_GraphType == "Scatterplot")
          {
               if (input$Graphs_01_TimeInterval == "Yearly")
               {
                    x = "year"
               } 
               else if (input$Graphs_01_TimeInterval == "Monthly")
               {
                    x = "year"
               } 
               else 
               {
                    x = "date"
               }
               ggplot(data = MyDataset_Graphs_01(),
                      mapping = aes_string(x = x, 
                                           y = para[which(para$Parameter == input$Graphs_01_SelectParameter),"abbv"])) + 
                    geom_point() +
                    geom_line()
          }
          # Histogram
          else if (input$Graphs_01_GraphType == "Histogram") 
          {
               ggplot(data = MyDataset_Graphs_01(),
                      mapping = aes_string(x = para[which(para$Parameter == input$Graphs_01_SelectParameter),"abbv"])) + 
                    geom_histogram(bins = input$Graphs_01_GraphBins)
          }
          # Density Plot
          else if (input$Graphs_01_GraphType == "Density Plot") 
          {
               ggplot(data = MyDataset_Graphs_01(),
                      mapping = aes_string(x = para[which(para$Parameter == input$Graphs_01_SelectParameter),"abbv"])) + 
                    geom_density()
          }
          # Box Plot
          else
          {
               ggplot(data = MyDataset_Graphs_01(),
                      mapping = aes_string(x = "Factor", 
                                           y = para[which(para$Parameter == input$Graphs_01_SelectParameter),"abbv"])) + 
                    geom_boxplot()
          }
     })
})