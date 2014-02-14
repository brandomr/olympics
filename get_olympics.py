import urllib.request
from bs4 import BeautifulSoup
import csv

f = open('output.csv', 'w')

#get winter olympic data
for i in range(21):

    #read in list of winter olympics as a dict
    wint = csv.DictReader(open("winterolympics.csv"))

    winterolympics = []

    for row in wint:
        winterolympics.append(row)

    #set each i to be the year and location 
    year = (winterolympics[i]['Year'])
    locationcity = (winterolympics[i]['City'])
    locationcountry = (winterolympics[i]['Country'])


    site = 'http://www.sports-reference.com/olympics/winter/%s/' %str(year)
    page = urllib.request.urlopen(site)
    soup = BeautifulSoup(page)


    for row in soup('table', {'class': 'sortable suppress_all stats_table'})[0].tbody('tr'):
        year = str(year)
        loccity = str(locationcity)
        loccountry = str(locationcountry)
        tds = row('td')
        rk = tds[0].string
        country = tds[1].string
        gold = tds[2].string
        silver = tds[3].string
        bronze = tds[4].string
        total = tds[5].string
        write_to_file = "Winter," + year + "," + loccity + "," + loccountry + "," + rk + "," + country + "," + gold + "," + silver + "," + bronze + "," + total + '\n'
        f.write(write_to_file)



#get summer olympic data
for i in range(28):

    #read in list of summer olympics as a dict
    summ = csv.DictReader(open("summerolympics.csv"))

    summerolympics = []

    for row in summ:
        summerolympics.append(row)

    #set each i to be the year and location 
    year = (summerolympics[i]['Year'])
    locationcity = (summerolympics[i]['City'])
    locationcountry = (summerolympics[i]['Country'])


    site = 'http://www.sports-reference.com/olympics/summer/%s/' %str(year)
    page = urllib.request.urlopen(site)
    soup = BeautifulSoup(page)


    for row in soup('table', {'class': 'sortable suppress_all stats_table'})[0].tbody('tr'):
        year = str(year)
        loccity = str(locationcity)
        loccountry = str(locationcountry)
        tds = row('td')
        rk = tds[0].string
        country = tds[1].string
        gold = tds[2].string
        silver = tds[3].string
        bronze = tds[4].string
        total = tds[5].string
        write_to_file = "Summer," + year + "," + loccity + "," + loccountry + "," + rk + "," + country + "," + gold + "," + silver + "," + bronze + "," + total + '\n'
        f.write(write_to_file)


f.close()

