#! /usr/bin/python2.3
# vim:sw=8:ts=8:et:nowrap

import sys
import os
import urllib
import urlparse
import string
import re
import xml.sax

# In Debian package python2.3-egenix-mxdatetime
import mx.DateTime

import miscfuncs

toppath = miscfuncs.toppath

# Generates an xml file with all the links into the daydebates, written questions, etc.
# The output file is used as a basis for planning the larger scale scraping.
# This prog is not yet reliable for all cases.

# this only does the commons index.
# Lords index is a completely different format.

# An index page is a page with links to a set of days,
#   NOT an index page into the pages for a single day.

# url for commons index
urlcmindex = "http://www.publications.parliament.uk/pa/cm/cmhansrd.htm"
# index file which is created
pwcmindex = os.path.join(toppath, "cmindex.xml")

# scrape limit date
earliestdate = '2001-06-01' # start of 2001 parliament
#earliestdate = '1994-05-01'

# regexps for decoding the data on an index page
monthnames = 'January|February|March|April|May|June|July|August|September|October|November|December'
# the chunk [A-Za-z<> ] catches the text "Questions tabled during the recess
# and answered on" on http://www.publications.parliament.uk/pa/cm/cmvol390.htm
redatename = '<b>[A-Za-z<> ]*?\s*(\S+\s+\d+\s+(?:%s)\s+\d+)\s*</b>' % monthnames
relink = '<a\s+href="([^"]*)">(?:<b>)?([^<]*)(?:</b>)?</a>(?i)'
redateindexlinks = re.compile('%s|%s' % (redatename, relink))

# map from (date, type) to (URL-first, URL-index)
# e.g. ("2003-02-01", "wrans") to ("http://...", "http://...")
# URL-first is the first (index) page for the day,
# URL-index is the refering page which linked to the day
reses = {}

# this pulls out all the direct links on this particular page
def CmIndexFromPage(urllinkpage):
	urlinkpage = urllib.urlopen(urllinkpage)
	srlinkpage = urlinkpage.read()
	urlinkpage.close()

	# remove comments because they sometimes contain wrong links
	srlinkpage = re.sub('<!--[\s\S]*?-->', ' ', srlinkpage)

	# <b>Wednesday 5 November 2003</b>
	#<td colspan=2><font size=+1><b>Wednesday 5 November 2003</b></font></td>
	# <a href="../cm199900/cmhansrd/vo000309/debindx/00309-x.htm">Oral Questions and Debates</a>
	datelinks = redateindexlinks.findall(srlinkpage)

	# read the dates and links in order, and associate last date with each matching link
	sdate = ''
	for link in datelinks:
		if link[0]:
			odate = re.sub('\s', ' ', link[0])
			sdate = mx.DateTime.DateTimeFrom(odate).date
			continue

		# the link types by name
		if not re.search('debate|westminster|written(?i)', link[2]):
			continue

		if re.search('Chronology', link[2]):
			# print "Chronology:", link
			continue

		# get rid of the new index pages
		if re.search('/indexes/', link[1]):
			continue

		if not sdate:
			raise Exception, 'No date for link in: ' + urllinkpage
		if sdate < earliestdate:
			continue

		# take out spaces and linefeeds we don't want
		uind = urlparse.urljoin(urllinkpage, re.sub('\s', '', link[1]))
		typ = string.strip(re.sub('\s\s+', ' ', link[2]))

		# check for repeats where the URLs differ
		if (sdate, typ) in reses:

			rc = reses[(sdate, typ)]
			otheruind = rc[0]
			if otheruind == uind:
				continue

			# sometimes they have old links to the cm edition as
			# well as the vo edition, we pick the newer vo ones
			test1 = uind.replace('cmhansrd/cm', 'cmhansrd/vo')
			test2 = otheruind.replace('cmhansrd/cm', 'cmhansrd/vo')
			if test1 != test2:
				raise Exception, 'Repeated link to %s %s\nurl1: %s\nurl2: %s\nindex1: %s\nindex2: %s' % (sdate, typ, uind, otheruind, urllinkpage, rc[1])

			# case of two URLs the same only vo/cm differ like this:
			# (which is a bug in Hansard, should never happen)
			#http://www.publications.parliament.uk/pa/cm200203/cmhansrd/vo031006/index/31006-x.htm
			#http://www.publications.parliament.uk/pa/cm200203/cmhansrd/cm031006/index/31006-x.htm
			# we replace both with just the vo edition:
			#print "done replace of these two URLs into the vo one\nurl1: %s\nurl2: %s" % (uind, otheruind)
			uind = test1

		reses[(sdate, typ)] = (uind, urllinkpage)
		#print sdate, uind

# Find all the index pages from the front index page by recursing into the months
# and then the years and volumes pages
def CmAllIndexPages(urlindex):

	# all urls pages which have links into day debates are put into this list
	# except the first one, which will have been looked at
	res = [ ]

	urindex = urllib.urlopen(urlindex)
	srindex = urindex.read()
	urindex.close()

	# extract the per month volumes
	# <a href="cmhn0310.htm"><b>October</b></a>
	monthindexp = '<a href="([^"]*)"><b>(?:%s)</b>(?i)' %  monthnames
	monthlinks = re.findall(monthindexp, srindex)
	for monthl in monthlinks:
		res.append(urlparse.urljoin(urlindex, re.sub('\s', '', monthl)))

	# extract the year links to volumes
	# <a href="cmse9495.htm"><b>Session 1994-95</b></a>
	# sessions before 94 have the bold tag the wrong way round,
	# but we don't want to go that far back now anyhow.
	yearvollinks = re.findall('<a href="([^"]*)"><b>session[^<]*</b></a>(?i)', srindex);

	# extract the volume links
	for yearvol in yearvollinks:
		urlyearvol = urlparse.urljoin(urlindex, re.sub('\s', '', yearvol))
		uryearvol = urllib.urlopen(urlyearvol)
		sryearvol = uryearvol.read()
		uryearvol.close()

		# <a href="cmvol352.htm"><b>Volume 352</b>
		vollinks = re.findall('<a href="([^"]*)"><b>volume[^<]*</b>(?i)', sryearvol)
		for vol in vollinks:
			res.append(urlparse.urljoin(urlyearvol, re.sub('\s', '', vol)))
	return res


def WriteXML(fout, urllist):
	fout.write('<?xml version="1.0" encoding="ISO-8859-1"?>\n')
	fout.write("<publicwhip>\n\n")

	# avoid printing duplicates
	for i in range(len(urllist)):
		r = urllist[i]
		if (i == 0) or (r != urllist[i-1]):
			if r[0] >= earliestdate:
				fout.write('<cmdaydeb date="%s" type="%s" url="%s"/>\n' % r)

	fout.write("\n</publicwhip>\n")


# gets the old file so we can compare the head values
class LoadOldIndex(xml.sax.handler.ContentHandler):
	def __init__(self, lpwcmindex):
		self.res = []
		if not os.path.isfile(lpwcmindex):
			return
		parser = xml.sax.make_parser()
		parser.setContentHandler(self)
		parser.parse(lpwcmindex)

	def startElement(self, name, attr):
		if name == "cmdaydeb":
			ddr = (attr["date"], attr["type"], attr["url"])
			self.res.append(ddr)

	def CompareHeading(self, urllisthead):
		if not self.res:
			return False

		for i in range(len(urllisthead)):
			if (i >= len(self.res)) or (self.res[i] != urllisthead[i]):
				#print i
				return False
		return True



###############
# main function
###############
def UpdateHansardIndex(force):
        global reses
        reses = {}
        
	# get front page (which we will compare against)
	CmIndexFromPage(urlcmindex)
        urllisth = map(lambda r: r + (reses[r][0],), reses.keys())
	urllisth.sort()
	urllisth.reverse()

	# compare this leading term against the old index
	oldindex = LoadOldIndex(pwcmindex)
	if oldindex.CompareHeading(urllisth) and not force:
		#print ' Head appears the same, no new list '
		return

	# extend our list to all the pages
	cres = CmAllIndexPages(urlcmindex)
	for cr in cres:
		CmIndexFromPage(cr)
        urllisth = map(lambda r: r + (reses[r][0],), reses.keys())
	urllisth.sort()
	urllisth.reverse()

	fpwcmindex = open(pwcmindex, "w");
	WriteXML(fpwcmindex, urllisth)
	fpwcmindex.close()

