#!/usr/bin/python
# -*- coding: utf-8 -*-
#pressure testing, insert per second
#Version 0.9 (2016/7/2)
#GloryGod

import pymongo 
import sys

import random
import string
import time
from datetime import datetime

#variables define
i = 0
j = 0
r = 1
count = 0
rps = 800

#db connection

conn = pymongo.MongoClient('mongodb://10.10.0.17:27017,10.10.0.58:27017')
db = conn.sdatabase
people = db.c1

#insert data in RPS
start = datetime.now()
for i in range(0,10000000):
   try:
      if r < rps:
        try:
          rstring = string.join(random.sample(['a','b','c','d','e','f','g','n','A','B','C'], 5)).replace(" ","")
          people.insert({"serial":i, "zip":rstring, "insertdate":datetime.now()})
        except:
          print "Unexpected error:", sys.exc_info()[0]
        r = r + 1
                        
      if r == rps :
                        stop = datetime.now()
                        delta = stop - start

                        #used time
                        used_microsecs = delta.seconds*1000000+delta.microseconds
                        #print (used_microsecs)

                        #time to sleep
                        st =  (1000000 - delta.microseconds) / 1000000.000000
                        #st1 = round((1000000 - delta.microseconds) / 1000.000 ,5)
                        #sd_str = "{0:.6f}".format(delta.seconds + delta.microseconds)
                        #sd_str = str(delta.seconds + delta.microseconds)
                        st_str = "{0:.6f}".format(st)

                        #current RPS
                        r_rps = r*1000000/used_microsecs
                        #print (r_rps)

                        count = count + r

                        if delta.seconds < 1 :
                                print 'CURRENT RPS: '+str(rps)+' ; Total Records Insert: '+ str(count)
                                time.sleep(st)
                                print 'sleep: ' + st_str

                        else :
                                print 'lower than TARGETED RPS: '+str(rps)+', used time:'+str(delta.seconds)+' second(s),'+str(delta.microseconds)+'ms'
                                print 'CURRENT RPS: '+str(r_rps)+' ; Total Records Insert: '+ str(count)
                                print

                        r = 0
                        start = datetime.now()

                #j = j + 1

                #time.sleep(1)
   except ValueError:
    print "except.......!!"
    #print j
    time.sleep(1)

#continue

conn.close()

