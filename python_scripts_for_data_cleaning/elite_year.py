#############################
## Python script to create data for Elite User table
############################# 
import pandas as pd
import numpy as np

usr_file = pd.read_csv('yelp_academic_dataset_user.csv')##,nrows=10)
maindataframe = pd.DataFrame(columns=[0,1])
data  = usr_file[['elite','user_id']]

def addtonewdf(elite,u_id):
  try:
    e_arr = elite.split(',')
    aa = pd.DataFrame(np.array(np.meshgrid(u_id,e_arr)).T.reshape(-1, 2))
    global maindataframe 
    maindataframe = pd.concat([maindataframe, aa] , ignore_index=True)
  except (AttributeError):
    print(f'no: {u_id}')

data[['elite','user_id']].apply(lambda x: addtonewdf(x[0],x[1]) , axis=1)

maindataframe.to_csv('elite_year.csv')

