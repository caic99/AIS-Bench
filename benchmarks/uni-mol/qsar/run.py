# Adapt from https://nb.bohrium.dp.tech/detail/7141701322 by zhengh@dp.tech
# under CC BY-NC-SA 4.0 license

# Step 1: Prepare data
import pandas as pd
import numpy as np

data = pd.read_csv("./datasets/hERG.csv")
print("------------ Original data ------------")
print(data)
data.columns = ["SMILES", "TARGET"]

# 将数据集的80%设置为训练数据集，20%设置为测试数据集
train_fraction = 0.8
train_data = data.sample(frac=train_fraction, random_state=1)
train_data.to_csv("./datasets/hERG_train.csv", index=False)
test_data = data.drop(train_data.index)
test_data.to_csv("./datasets/hERG_test.csv", index=False)

# 设定训练/测试目标
train_y = np.array(train_data["TARGET"].values.tolist())
test_y = np.array(test_data["TARGET"].values.tolist())


# Step 2: Train
from unimol_tools import MolTrain
import os
clf = MolTrain(task='regression',
                data_type='molecule',
                epochs=50,
                learning_rate=0.0001,
                batch_size=64,
                early_stopping=10,
                metrics='mse',
                split='random',
                save_path='./exp_reg_hERG_0616',
              )
clf.fit('datasets/hERG_train.csv')

# Step 3: Predict
from unimol_tools import MolPredict
from sklearn.metrics import mean_squared_error

predm = MolPredict(load_model='./exp_reg_hERG_0616')
pred_train_y = predm.predict('datasets/hERG_train.csv').reshape(-1)
pred_test_y = predm.predict('datasets/hERG_test.csv').reshape(-1)

mse = mean_squared_error(test_y, pred_test_y)
se = abs(test_y - pred_test_y)
print(f"[Uni-Mol]\tMSE:{mse:.4f}")
