library(RSQLite)
library(ggplot2)

db_path <- "/Users/ugur_dura/Desktop/Protein_Prediction_2/Project/Exploring_the_Protein_Universe/Trials/parsed_data/my_database.db"


conn <- dbConnect(SQLite(), dbname = db_path)


query <- "SELECT * FROM merged;"
data <- dbGetQuery(conn, query)


dbDisconnect(conn)


ggplot(data, aes(x = Localization, y = Lower_Darkness_Bin)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Localization vs Lower Darkness Bin",
       x = "Localization",
       y = "Lower Darkness Bin")


protein_data <- data[, c("UniprotID", "Protein_sequence")]


protein_data$Sequence_Length <- nchar(protein_data$Protein_sequence)


histogram <- ggplot(protein_data, aes(x = Sequence_Length)) +
  geom_histogram(binwidth = 50, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Protein Sequence Lengths",
       x = "Protein Sequence Length",
       y = "Frequency")


print(histogram)



boxplot_data <- data[, c("Localization", "Upper_Darkness_Bin")]

grouped_boxplot <- ggplot(boxplot_data, aes(x = Localization, y = Upper_Darkness_Bin, fill = Localization)) +
  geom_boxplot() +
  labs(title = "Grouped Boxplot of Upper Darkness Bin Values by Localization",
       x = "Localization",
       y = "Upper Darkness Bin") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for better visibility

print(grouped_boxplot)
