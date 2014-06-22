# !/usr/bin/evn python
# -*- coding: utf8 -*-
'''
1. get data source url from a file, 
2. load url data and save them to database
'''

import re
import  sys
import csv
import json
import urllib2
import traceback
from cls.DataDB import * 
sys.path.append("lib/coordinate")
#from sample import *
from pygeocoding.api import *
import time

# read data's url from file, return data_Name to url dictionary
def readURLFile(file_name):
	data_url = {}
	with open( file_name ) as inputFile:
		content = inputFile.readlines()
		for line in content:
			line = line.split(" ")
			data_url[ line[0] ] = line[1]
	return data_url

# load data from file
def loadData(file_dir):
		
	input_File = open(file_dir, 'r')

	if file_dir[-4:] == "json":
		data = JsonReader( input_File )
	elif file_dir[-3:] == "csv":
		data = CSVReader( input_File )
	else:
		return None
	
	return input_File, data

# get data by read url
def getData(url):
	# make sure that we can get data from server
	try:
		response = urllib2.urlopen( url )
	except urllib2.HTTPError, e:
		print "Cannot retrieve URL: HTTP Error Code", e.code
		sys.exit(0)
	except urllib2.URLError, e:
		print "Cannot retrieve URL: " + e.reason[1]
		sys.exit(0)
	except ValueError, e:
		print "URL value ERROR"
		sys.exit(0)
	return response

def JsonReader( raw_data ):

	# convert to json format
	data = json.load( raw_data, encoding = ('utf-8') )	
	return data

def CSVReader( raw_data ):

	# convert to csv format
	data = csv.reader( raw_data )	
	return data


def insertJson( mydb, table_name, data ):
	for datum in data:
		key_list = []
		data_list = []
		for key in datum:
			if key.lower() == "address":
				key_list.append("lat")
				key_list.append("lng")
				if not datum[key]:
					break
				#datum[key] = datum[key]
				lat, lng = converToCor( datum[key].encode('utf8') )
				if lat == "Error":
					break
				data_list.append(lat)
				data_list.append(lng)
			key_list.append(key.lower())
			data_list.append(datum[key])	
		if lat != "Error":
			mydb.insertData( table_name, key_list, data_list)


def insertCSV( mydb, table_name, data ):
	
	key_list = []
	first = True 
	for datum in data:
		data_list = []
		for col in datum:
			if not first:
				data_list.append(  col )		
				if len(data_list) == 3:
					lat, lng = converToCor( col )
					if lat == "Error":
						break
			else:
				key_list.append(  col )
		if not first:
			data_list.append(lat)
			data_list.append(lng)
			mydb.insertData( table_name, key_list, data_list)
		else:
			if 'lat' not in key_list:
				key_list.append('lat')	
				key_list.append('lng')	
			key_list[0] = "area"
			first = False

# filter data by city 
def filterByCity(data, city):
	
	# unicode zh-tw string to 'utf-8' for find value in data
	tw_road_area = unicode("土地區段位置或建物區門牌", "utf-8")
	
	# regular expression compile pattern for reuse in following search
	pattern = re.compile( city )

	city_data = []
	# start to match data
	for datum in data:
		# check that data's key is same to our json format
		if tw_road_area in datum:
			if datum[tw_road_area] and\
				pattern.search( datum[tw_road_area].encode("utf8") ):
				city_data.append( datum )
		else: 
			print "Error json format is not match!" 
			sys.exit(0)

	# return city_data
	return city_data


def converToCor(addr):
	try:
		map_data = LookUp(address=addr)
	except LookUpError, e:
		print "Error", e
		return "Error", e
	except ValueError, e:
		print "Error",e
		return "Error", e
	lat =  map_data.result['results'][0]['geometry']['location']['lat']
	lng =  map_data.result['results'][0]['geometry']['location']['lng']
	print lat, lng
	time.sleep(1.5)
	return lat, lng



if __name__=='__main__':
	# database object
	#mydb = DataDB( 'localhost', 'mydb', 'root', 'axszdc', 'utf8', "" )
	#mydb = DataDB( 'PostgreSQL' , 'localhost', 'Whatshouse_development', 'hacker', 'password1', 'utf8', "")
	mydb = DataDB( 'PostgreSQL', 'ec2-23-21-101-129.compute-1.amazonaws.com', 'ddssc8n1eqsnl3', 'iwurgjyzhlmsuj', '5L_bFoFDh_slRqrhq1l0pPmwJW', 'utf8', '5432')
	
	if len( sys.argv ) == 3:
		input_File, data = loadData(sys.argv[1])
		if sys.argv[1][-3:] == "csv":
			insertCSV( mydb, sys.argv[2],  data)
		elif sys.argv[1][-4:] == "json":
			insertJson( mydb, sys.argv[2], data )
	else:
		# get url_list from file
		#rep_data_url = readURLFile( "input_data/real_price_url" )
		#json_data_url = readURLFile( "input_data/json_url" )
		#csv_data_url = readURLFile( "input_data/csv_url" )
		# insert real_price data to database

		'''
		for data_name in rep_data_url:
			raw_data = getData( rep_data_url[ data_name ] )
			data = JsonReader( raw_data )
			city_data = filterByCity( data, "臺南市" )
			for datum in city_data:
				insertReadPriceData( data_name, datum, mydb )'''
		
		# json format data: create data table and insert data to database
		'''for data_name in json_data_url:
			raw_data = getData( json_data_url[ data_name ] )
			data = JsonReader( raw_data )
			mydb.createTable( data_name, data[0].keys() )
			for datum in data:
				if "CountryName" in datum and datum["CountryName"] == unicode("臺南市", "utf-8"):
					mydb.insertData( data_name, datum.keys(), datum.values() )'''
		'''
		# csv format data: create data table and insert data to database
		for data_name in csv_data_url:
			raw_data = getData( csv_data_url[ data_name ] )
			data = CSVReader( raw_data )
			for datum in data:
				for col in datum:
					print col,
				print'''
	input_File.close()

	# disconnect database
	mydb.close()
