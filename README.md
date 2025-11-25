# Teen Health Risk Index — Maryland Counties  
*A portfolio-safe reconstruction using synthetic data*

## 📌 Overview  
This project replicates an evaluation-style public health workflow using synthetic data modeled after common SDOH (Social Determinants of Health) indicators. The goal was to create a **Teen Health Risk Index** for Maryland counties using:

- R for data cleaning, z-score standardization, and composite index creation  
- Excel for initial data structure  
- Tableau Public for geospatial visualization  

The final deliverable is a **choropleth map** showing teen health risk quintiles across Maryland’s 24 counties.

All data used is fully **synthetic** and suitable for public sharing.

---

## 🛠 Tools Used  
- **R** (tidyverse)  
- **Excel**  
- **Tableau Public**  

---

## 📊 Dataset Description  

**File:** `maryland_teen_health_index_export.csv`  

**Fields included:**

| Field | Description |
|-------|-------------|
| `county` | County name (24 MD counties + Baltimore City) |
| `state` | “Maryland” for all rows |
| `teen_birth_rate` | Synthetic teen birth rate per 1,000 |
| `poverty_rate` | Synthetic % living in poverty |
| `hs_dropout_rate` | Synthetic % high school dropout rate |
| `juvenile_arrests` | Synthetic arrest count |
| `unemployment_rate` | Synthetic % unemployment |
| `teen_risk_index` | Composite z-score index |
| `quintile` | 1–5 risk level classification |

These indicators are commonly used in SDOH-driven public health analyses and were selected to mimic a real-world evaluation workflow.

---

## 🔬 Analysis Workflow

### **1. Data Cleaning (R)**
- Loaded the Excel file  
- Standardized county names  
- Trimmed whitespace and removed non-ASCII characters  
- Verified numeric types for all indicators  

### **2. Z-Score Standardization**
Used `scale()` to standardize indicators:

```
df <- df %>%
  mutate(across(all_of(indicators), ~ scale(.)[,1], .names = "{.col}_z"))
```

### **3. Composite Risk Index**
```
df <- df %>%
  rowwise() %>%
  mutate(teen_risk_index = mean(c_across(ends_with("_z")))) %>%
  ungroup()
```

### **4. Quintiles**
```
df <- df %>% mutate(quintile = ntile(teen_risk_index, 5))
```

### **5. Export for Tableau**
```
write.csv(df, "maryland_teen_health_index_export.csv", row.names = FALSE)
```

## 🗺 Visualization (Tableau Public)
**The final map includes:**

- County-level polygons colored by risk quintile

- Sequential 5-step color ramp

- Tooltip with:

  - County name

  - Risk index

  - Quintile

  - Raw synthetic indicator values

The dashboard focuses on a single high-quality visualization for clarity and impact.

## 📁 Repository Structure
```
.
├── data
│   ├── maryland_teen_health_raw.xlsx
│   └── maryland_teen_health_index_export.csv
├── r
│   └── teen_health_index.R
├── tableau
│   └── teen_health_dashboard.twbx
└── README.md
```
## 🧠 Skills Demonstrated

- Data wrangling (R / tidyverse)

- Z-score standardization

- Composite index development

- Geographic visualization (Tableau)

- Public health analytics workflow

- Working with synthetic data in a privacy-safe portfolio format

## 📎 Notes

All data in this project is synthetic and does not represent real Maryland SDOH or teen health outcomes.

The purpose of this project is to demonstrate methodology and visualization skills.
