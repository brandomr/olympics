import urllib.request
from bs4 import BeautifulSoup
import csv
import codecs


def remove_non_ascii_1(text):
    return ''.join([i if ord(i) < 128 else ' ' for i in text])



f = open('sports_list_output.csv', 'w')

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

    table = soup.find('table', {'class': ' stats_table suppress_all'})

    for row in table.findAll("tr"):
        cells = row.findAll("td")
        year = str(year)
        sport = cells[0].find(text=True)
        write_to_file = "Winter," + year + "," + sport + '\n'
        write_to_file = remove_non_ascii_1(write_to_file)
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

    table = soup.find('table', {'class': ' stats_table suppress_all'})

    for row in table.findAll("tr"):
        cells = row.findAll("td")
        year = str(year)
        sport = cells[0].find(text=True)
        write_to_file = "Summer," + year + "," + sport + '\n'
        write_to_file = remove_non_ascii_1(write_to_file)
        f.write(write_to_file)

f.close()

