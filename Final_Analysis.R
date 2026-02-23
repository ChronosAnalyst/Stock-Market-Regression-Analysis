# ==============================================================================
# PROJECT: Stock Price Prediction Analytics (Tesla vs Ferrari)
# DESCRIPTION: Linear Regression Model to analyze the relationship between 
#              automotive giants using historical stock data (2015-2024).
# AUTHOR: [Το Όνομά Σου]
# ==============================================================================

# 1. ΠΡΟΕΤΟΙΜΑΣΙΑ & ΒΙΒΛΙΟΘΗΚΕΣ
# ------------------------------------------------------------------------------
if(!require(tidyverse)) install.packages("tidyverse")
if(!require(ggplot2)) install.packages("ggplot2")
library(tidyverse)
library(ggplot2)

# 2. ΦΟΡΤΩΣΗ & ΣΥΝΕΝΩΣΗ ΔΕΔΟΜΕΝΩΝ (DATA WRANGLING)
# ------------------------------------------------------------------------------
# Σημείωση: Βεβαιωθείτε ότι το Working Directory είναι σωστά ορισμένο

# Επεξεργασία δεδομένων Tesla
t_old <- read.csv("Tesla.csv")
t_new <- read.csv("Tesla (20.04.23 - 01.05.24).csv")
tesla_full <- rbind(t_old, t_new) %>%
  distinct(Date, .keep_all = TRUE) %>%
  mutate(Date = as.Date(Date)) %>%
  arrange(Date)

# Επεξεργασία δεδομένων Ferrari
f_old <- read.csv("Ferrari.csv")
f_new <- read.csv("Ferrari (20.04.23 - 01.05.24).csv")
ferrari_full <- rbind(f_old, f_new) %>%
  distinct(Date, .keep_all = TRUE) %>%
  mutate(Date = as.Date(Date)) %>%
  arrange(Date)

# Αποθήκευση των καθαρών αρχείων
write.csv(tesla_full, "Tesla_Full.csv", row.names = FALSE)
write.csv(ferrari_full, "Ferrari_Full.csv", row.names = FALSE)

# 3. ΔΙΑΣΤΑΥΡΩΣΗ ΔΕΔΟΜΕΝΩΝ (CROSS-EXAMINATION)
# ------------------------------------------------------------------------------
# Ένωση των δύο datasets βάσει ημερομηνίας
combined_stocks <- merge(tesla_full[, c("Date", "Close")], 
                         ferrari_full[, c("Date", "Close")], 
                         by = "Date", 
                         suffixes = c("_Tesla", "_Ferrari"))

# Υπολογισμός Συσχέτισης (Correlation)
cor_value <- cor(combined_stocks$Close_Tesla, combined_stocks$Close_Ferrari)
cat("Correlation between Tesla and Ferrari:", round(cor_value, 4), "\n")

# 4. ΜΟΝΤΕΛΟ ΓΡΑΜΜΙΚΗΣ ΠΑΛΙΝΔΡΟΜΗΣΗΣ (LINEAR REGRESSION)
# ------------------------------------------------------------------------------
# Εκπαίδευση μοντέλου: Πρόβλεψη Tesla βάσει Ferrari
my_model <- lm(Close_Tesla ~ Close_Ferrari, data = combined_stocks)

# Εμφάνιση αποτελεσμάτων μοντέλου
summary(my_model)

# 5. ΤΕΛΙΚΗ ΟΠΤΙΚΟΠΟΙΗΣΗ (VISUALIZATION)
# ------------------------------------------------------------------------------
final_plot <- ggplot(combined_stocks, aes(x = Close_Ferrari, y = Close_Tesla)) +
  geom_point(alpha = 0.3, color = "steelblue") + 
  geom_smooth(method = "lm", color = "darkred", linewidth = 1.2) + 
  labs(title = "Linear Regression Model: Tesla vs Ferrari",
       subtitle = paste("R-squared:", round(summary(my_model)$r.squared, 3), 
                        "| Correlation:", round(cor_value, 3)),
       x = "Ferrari Stock Price ($)",
       y = "Tesla Stock Price ($)",
       caption = "Data Source: Kaggle | Analysis: RStudio") +
  theme_minimal()

# Προβολή και Αποθήκευση του γραφήματος
print(final_plot)
ggsave("Final_Regression_Analysis.png", plot = final_plot, width = 10, height = 7)

print("✅ Η ανάλυση ολοκληρώθηκε επιτυχώς!")