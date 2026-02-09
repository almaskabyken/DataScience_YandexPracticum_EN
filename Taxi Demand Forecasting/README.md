# Taxi Demand Forecasting

## Project Description
The goal of this project is to develop a machine learning model to forecast hourly taxi demand. The solution is aimed at optimizing driver allocation, reducing customer waiting time, and improving overall service operational efficiency.

The model is built using historical taxi order data from airports and applies time series analysis and machine learning techniques.

---

## Skills and Tools
* pandas  
* NumPy  
* matplotlib, seaborn  
* Time Series Analysis  
* Feature Engineering (lag features, rolling mean)  
* Scikit-learn  
* CatBoost / Gradient Boosting / Random Forest  
* Evaluation metric: RMSE  

---

## Data
Historical taxi order data was used:

* Order timestamp  
* Number of orders per hour  
* Observation period — several months  

---

## Project Stages

### 1. Data Preprocessing
* Missing value check  
* Time-based sorting  
* Hourly data resampling  

---

### 2. Exploratory Data Analysis (EDA)
* Time series visualization  
* Trend and seasonality analysis  
* Order distribution analysis  
* Demand analysis by time of day  

---

### 3. Feature Engineering
Additional features were created:

* Hour  
* Day of week  
* Lag features  
* Rolling mean features  

---

### 4. Model Training
Several models were tested:

* Linear Regression  
* Random Forest  
* Gradient Boosting  
* CatBoost  

---

### 5. Best Model Selection
* Main metric — RMSE  
* Business requirement — RMSE ≤ 48  
* The best model was selected based on test set performance  

---

## Final Conclusions

The analysis showed that taxi demand has strong seasonality and depends on time of day and day of week. Demand peaks occur during periods of high transportation activity.

Adding time-based features and lag variables significantly improved forecasting accuracy.

The developed model demonstrates high forecasting accuracy and meets the business requirements of the project. The solution can be used for:

* driver workload planning  
* vehicle allocation optimization  
* reducing customer waiting time  
* improving service quality  

Using the model can help:

* reduce operational costs  
* increase customer satisfaction  
* improve resource planning  
* support data-driven decision making  
