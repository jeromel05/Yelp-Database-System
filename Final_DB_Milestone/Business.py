#############################
## Python script to divide opening days 
## for each weekday
############################# 

import pandas as pd
import json

busi_file = pd.read_csv('yelp_academic_dataset_business.csv')##,nrows=10)
name_map = {'Sunday':0, 'Monday': 1, 'Tuesday': 2, 'Wednesday': 3, 'Thursday': 4, 'Friday': 5, 'Saturday': 6}
maindataframe = pd.DataFrame(columns=['BUSINESS_ID','DAY_ID','OPENING_HOUR_ID','CLOSING_HOUR_ID'])

def convertime2(timestr2):
  tarr = timestr2.split(':')
  return int(tarr[0])*60+int(tarr[1])

def converttime(b_id,i,timestr):
  tarr = timestr.split('-')
  return b_id,i,convertime2(tarr[0]),convertime2(tarr[1])

def devidetotime(time_array,b_id):
  try:
    json_acceptable_string = time_array.replace("'", "\"")
    d = json.loads(json_acceptable_string)
    row = dict((name_map[name], d[name]) for name in d)
    subdf = pd.concat([pd.DataFrame([converttime(b_id,i,row[i])], columns=['BUSINESS_ID','DAY_ID','OPENING_HOUR_ID','CLOSING_HOUR_ID']) for i in row ], ignore_index=True)
    global maindataframe 
    maindataframe = pd.concat([maindataframe, subdf] , ignore_index=True)

    return subdf

  except (AttributeError):
    print(f'problem with time array: {time_array}')

busi_file[['hours','business_id']].apply(lambda x: devidetotime(x[0],x[1]) , axis=1)

maindataframe.to_csv('startin_closing_time.csv')

