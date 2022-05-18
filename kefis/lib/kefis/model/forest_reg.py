import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestRegressor
import matplotlib.pyplot as plt
import joblib




df = pd.DataFrame()

df = pd.read_csv('./sales.csv', index_col='DATE', parse_dates=True)
df.index.freq = 'MS'



df.columns = ['Sales']
df['Sale_LastMonth'] = df['Sales'].shift(+1)
df['Sale_2Monthsback'] = df['Sales'].shift(+2)
df['Sale_3Monthsback'] = df['Sales'].shift(+3)


# Remove null values
df = df.dropna()


lin_model = LinearRegression()
model = RandomForestRegressor(n_estimators=100, max_features=3, random_state=1)


# Extract columns from the dataframe
x_last_month, x_2_months, x_3_months, y = df['Sale_LastMonth'], df[
    'Sale_2Monthsback'], df['Sale_3Monthsback'], df['Sales']

# Convert them into Numpy arrays
x_last_month, x_2_months, x_3_months, y = np.array(
    x_last_month), np.array(x_2_months), np.array(x_3_months), np.array(y)

#
x_last_month, x_2_months, x_3_months, y = x_last_month.reshape(
    -1, 1), x_2_months.reshape(-1, 1), x_3_months.reshape(-1, 1), y.reshape(-1, 1)

final_x = np.concatenate((x_last_month, x_2_months, x_3_months), axis=1)
#print(final_x)


X_train, X_test, y_train, y_test = final_x[:-30], final_x[-30:], y[:-30], y[-30:]

model.fit(X_train, y_train)

# Save the model locally
joblib.dump(model, "model.pkl") 
