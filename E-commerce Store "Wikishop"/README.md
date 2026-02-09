# Toxic Comment Classification

## Project Description
The goal of this project is to develop a machine learning model for **automatic toxic comment detection**. The solution can be used for user content moderation, message filtering, and improving the quality of online communication.

The project uses text comment data and Natural Language Processing (NLP) techniques. A pre-trained Toxic-BERT model is used for feature extraction, followed by classical machine learning algorithms for classification.

---

## Skills and Tools
* pandas
* NumPy
* matplotlib
* seaborn
* NLP (text cleaning, tokenization, stop words)
* Transformers (Toxic-BERT)
* PyTorch
* Scikit-learn
* Random Forest
* Logistic Regression
* Gradient Boosting
* XGBoost
* SVM
* F1-score
* Confusion Matrix
* Classification Report

---

## Data
* Total number of comments — 159,292
* Share of toxic comments — 10.2%
* The dataset contains comment text and toxicity labels

---

## Project Stages

### 1. Text Preprocessing
* Text cleaning
* Lowercasing
* Stop word removal
* Word frequency analysis

### 2. Data Preparation
* Train / test split
* Using a subset of 5,000 texts
* Text tokenization using Toxic-BERT
* Text embedding generation

### 3. Model Training
* Logistic Regression
* Random Forest
* Gradient Boosting
* XGBoost
* SVM

### 4. Best Model Selection
* Best model — Random Forest
* F1-score (Validation) = 0.8776
* F1-score (Test) = 0.8932

---

## Conclusion
The developed model demonstrates high performance in toxic comment classification and can be used in automated content moderation systems.
