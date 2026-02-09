# Telecom Customer Churn Prediction — TeleDom

## Project Description
The TeleDom telecom company aims to reduce customer churn by offering personalized discounts and special conditions to users who are planning to terminate their contracts. To achieve this, a machine learning model is required to predict customer churn based on customer data and service usage history.

## Skills and Tools
* pandas
* NumPy
* matplotlib, seaborn
* phik (correlation analysis)
* Scikit-learn (Pipeline, GridSearchCV, cross-validation, preprocessing)
* Imbalanced-learn (SMOTE)
* CatBoost
* LightGBM
* Random Forest
* Gradient Boosting
* Logistic Regression
* SVM
* KNN
* ROC-AUC, Confusion Matrix, Classification Report
* PyTorch

## Data
**4 tables were provided for model training:**

* contract_new.csv – contract information (start date, end date, payment type, charges).
* personal_new.csv – customer personal data (gender, age, marital status).
* internet_new.csv – internet service data (connection type, additional services).
* phone_new.csv – phone service data (multiple lines).

## Project Stages
1. Data preprocessing  
2. Data analysis  
3. Data preparation  
  * Encoding categorical features  
  * Scaling numerical features (StandardScaler)  
  * Train-test split (75% / 25%)  
  * Class balancing using SMOTE  

4. Model Training  
* SVM (Support Vector Machine)  
* Random Forest  
* Gradient Boosting  

5. Hyperparameter Tuning  
* GridSearchCV (5-fold cross-validation)  
* Evaluation metric — ROC-AUC (target value ≥ 0.85)  

6. Best Model Selection  
* Test set evaluation and feature importance analysis  

## Churn Factor Analysis
**Most significant churn drivers:**
* Contract length: Long-term contracts are associated with higher churn.  
* Payment method: Customers using automatic payments churn more often.  
* Internet service type: Higher churn among fiber optic users.  
* Electronic billing: E-billing increases churn probability.  
* Social factors: Senior customers and customers without partners are more likely to churn.  

# Recommendations

* Introduce flexible monthly subscription plans, since customers with long-term contracts churn more often.  
* Improve automatic payment communication and provide clearer payment notifications.  
* Optimize fiber optic services based on customer feedback.  
* Provide personalized services for senior customers to increase loyalty.  

**Conclusion:** The CatBoost-based model effectively predicts customer churn probability and highlights key factors influencing churn decisions. Implementing the proposed recommendations can reduce churn rate and improve customer satisfaction.
