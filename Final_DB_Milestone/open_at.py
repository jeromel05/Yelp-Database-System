#############################
## Python script to create 
## final id for opening hours
############################# 
import pandas as pd
import numpy as np

usr_file = pd.read_csv('startin_closing_time.csv')##,nrows=10) 
usr_file['final_id'] = usr_file[['OPENING_HOUR_ID','CLOSING_HOUR_ID']].astype(str).apply(lambda x: str(x[0]).zfill(4)+str(x[1]).zfill(4) ,axis=1)

usr_file.to_csv('new_startin_closing_time.csv')

