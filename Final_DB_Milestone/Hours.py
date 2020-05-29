#############################
## Python script to create 
## all possible opening hours
## from one set of times
############################# 
import pandas as pd
import numpy as np

usr_file = pd.read_csv('openinghours_minumium.csv')##,nrows=10) 
data_id = usr_file['OPENING_HOURS_ID'].astype(str).apply(lambda x: x.zfill(4) )
data_h = usr_file[['HOURS']]

# print(data_id)

did = pd.DataFrame(np.array(np.meshgrid(data_id,data_id)).T.reshape(-1, 2))
dh = pd.DataFrame(np.array(np.meshgrid(data_h,data_h)).T.reshape(-1, 2))

maindataframe = pd.DataFrame(did)
maindataframe['hours_id'] = maindataframe[[0,1]].apply(lambda x: x[0]+x[1] ,axis=1)
maindataframe[['opening','closing']] = pd.DataFrame(dh)
maindataframe.to_csv('times.csv')

