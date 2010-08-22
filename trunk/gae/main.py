#!/usr/bin/env python
#
# Copyright 2007 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
from google.appengine.ext import webapp
from google.appengine.ext.webapp import util
from google.appengine.ext import db
try:
    import json
except ImportError:
    from django.utils import simplejson as json
import logging

"""
class Company(db.Model):
    name = db.StringProperty(required=True)
    duns = db.IntegerProperty()
    awards = db.ListProperty(str,)
    jobs = db.IntegerProperty()
    totalReceived = db.IntegerProperty()
    """ 
class Job(db.Model):
    recipient_role = db.StringProperty(choices=set(["P", "S", "PV", "SV"]))
    year = db.IntegerProperty()
    qtr = db.IntegerProperty()
    recipient_duns = db.IntegerProperty()
    recipient_name = db.StringProperty()
    recipient_zip = db.IntegerProperty()
    amount = db.FloatProperty()
    award_date = db.StringProperty()
    award_type = db.StringProperty()
    award_desc = db.TextProperty()
    project_name = db.StringProperty()
    project_desc = db.TextProperty()
    funding_agency = db.StringProperty()
    award_key = db.StringProperty()
    pop_lat = db.FloatProperty()
    pop_lon = db.FloatProperty()
    pop_addr = db.StringProperty()
    pop_state = db.StringProperty()
    pop_city = db.StringProperty()
    pop_cd = db.StringProperty()
    jobs_list = db.TextProperty()
    jobs_count = db.FloatProperty()
    
    def __str__(self):
        data = {"YR" : self.year, "QTR" : self.qtr,
                "RECIP_DUNS" : self.recipient_duns, 
                "RECIP_NAME" : self.recipient_name,
                "AMT" : self.amount, "DATE": self.award_date,
                "AWD_TYPE" : self.award_type, "AWD_DESC" : self.award_desc,
                "PROJ_NAME" : self.project_name,
                "PROJ_DESC" : self.project_desc,
                "FUNDING_AGCY" : self.funding_agency,
                "AWD_KEY" : str(self.key()),
                "LAT" : self.pop_lat, "LON" : self.pop_lon,
                "ADDR" : self.pop_addr, "ST" : self.pop_state,
                "CITY" :  self.pop_city, "CD" : self.pop_cd,
                "JOBS_LIST" : self.jobs_list, "JOBS_COUNT" : self.jobs_count}
        inf = float(1e3000)
        for key in data:
            if data[key] == inf:
                data[key] = -1
        return json.dumps(data)

class AdminHandler(webapp.RequestHandler):
    def get(self):
        pass
    def post(self):
        pass

class DetailHandler(webapp.RequestHandler):
    def get(self):
        types = {"G" : "Grant", "L" : "Loan", "C" : "Contract"}
        id = db.Key(self.request.get("key"))
        job = Job.get(id)
        agcy = get_agency_name(job.funding_agency)
        puts = self.response.out.write
        puts("<html><body>")
        puts("<h1>%s</h1><br />" % job.recipient_name)
        puts("<b>Amount: $%.2f</b><p>" % job.amount)
        puts("<b>Award Date: </b>%s<p>" % job.award_date)
        puts("<b>Award Type:</b> %s<p>" % types[job.award_type])
        puts("<b>Funding agency:</b> %s<p>" % agcy)
        puts("<b>Award description:</b> %s<p>" % job.award_desc)
        puts("</body></html>")

agencies = {'1148': 'Office of Homeland Security', '89GO': 'Golden Field Office', '8620': 'Assistant Secretary for Community Planning and Development', '7300': 'Small Business Administration', '4700': 'General Services Administration', '4900': 'National Science Foundation', '7051': 'Office of the Under Secretary for Management', '7590': 'Administration for Children and Families', '9561': 'Recovery Accountability and Transparency Board', '12c2': 'Forest Service', '12c3': 'Natural Resources Conservation Service', '5920': 'National Endowment for the Arts', '8900': 'Department of Energy', '8635': 'Assistant Secretary for Public and Indian Housing', '2700': 'Federal Communications Commission', '12C2': 'Forest Service', '12C3': 'Natural Resources Conservation Service', '9700': 'Department of Defense (except military departments)', '1700': 'Department of the Navy', '9131': 'Federal Student Aid', '7523': 'Centers for Disease Control and Prevention', '9577': 'Corporation for National and Community Service', '7527': 'Indian Health Service', '7528': 'Agency for Healthcare Research and Quality', '7529': 'National Institutes of Health', '96CE': 'U.S. Army Corps of Engineers - civil program financing only', '2066': 'Community Development Financial Institutions', '1325': 'Economic Development Administration', '8602': 'Deputy Secretary of Housing and Urban Development', '8600': 'Department of Housing and Urban Development', '6900': 'Department of Transportation', '9146': 'Office of Elementary and Secondary Education', '9144': 'Impact Aid Programs', '21CE': 'U.S. Army Corps of Engineers, except civil program financing', '1714': 'Office of Naval Research', '7013': 'Transportation Security Administration', '7526': 'Health Resources and Services Administration', '1400': 'Department of the Interior', '7530': 'Centers for Medicare & Medicaid Services', '1335': 'National Telecommunication and Information Administration', '1330': 'National Oceanic and Atmospheric Administration', '7022': 'Federal Emergency Management Agency', '6938': 'Maritime Administration', '1434': 'Geological Survey', '1724': 'Naval Sea Systems Command', '12000': 'Rural Housing Service', '7545': 'Administration on Aging', '9124': 'Office of Special Education and Rehabilitative Services', '1341': 'National Institute of Standards and Technology', '89BB': 'Oak Ridge Office', '6925': 'Federal Highway Administration', '7014': 'U.S. Customs and Border Protection', '6920': 'Federal Aviation Administration', '1900': 'Department of State', '1630': 'Employment and Training Administration', '1631': 'Office of Job Corps', '1422': 'Bureau of Land Management', '1425': 'Bureau of Reclamation', '1635': 'Employment Standards Administration', '4740': 'Public Buildings Service', '5700': 'Department of the Air Force', '1500': 'Department of Justice', '500': 'Government Accountability Office', '3601': 'Office of the Secretary', '3600': 'Department of Veterans Affairs', '89NE': 'National Energy Technology Laboratory', '6800': 'Environmental Protection Agency', '7008': 'U.S. Coast Guard', '8904': 'Office of the Inspector General', '7000': 'Department of Homeland Security', '6955': 'Federal Transit Administration', '97AS': 'Defense Logistics Agency', '1450': 'Indian Affairs (Assistant Secretary)', '12H2': 'Agricultural Research Service', '12f2': 'Food and Nutrition Service', '2100': 'Department of the Army', '190S': 'Office of the Secretary of State', '1200': 'Rural Utilities Service', '9100': 'Department of Education', '750S': 'Office of the Secretary of Health and Human Services', '12F3': 'Center for Nutrition Policy and Promotion', '12F2': 'Food and Nutrition Service', '1': 'Congress, generally, no additional specification available', '8925': 'Office of Science', '1443': 'National Park Service.', '8921': 'Assistant Secretary for Energy Efficiency and Renewable Energy', '120000': 'Rural Business Cooperative Service', '1560': 'Bureau of Alcohol, Tobacco, Firearms and Explosives', '1448': 'U.S. Fish and Wildlife Service', '892L': 'Office of Electricity Delivery and Energy Reliability', '8000': 'National Aeronautics and Space Administration', '570M': 'Headquarters, Air Force Reserve', '1600': 'Department of Labor', '96ce': 'U.S. Army Corps of Engineers - civil program financing only', '7500': 'Department of Health and Human Services', '7501': 'Immediate Office of the Secretary of Health and Human Services'}


def get_agency_name(code):
    if code in agencies:
        return agencies[code]
    return "Unknown"

def goodAwd(awd):
    return awd != None and awd.amount != None and awd.amount > 0 and awd.jobs_count != None and awd.jobs_count >= 0

class QueryHandler(webapp.RequestHandler):
    def get(self):
        lat = float(self.request.get("lat"))
        lon = float(self.request.get("lon"))
        tol = float(self.request.get("tol") or 50) / 100.0
        logging_on = self.request.get("logging")
        if logging_on: logging.info((lat, lon, tol))
        matches = db.GqlQuery("SELECT * FROM Job WHERE pop_lat > :1 AND pop_lat < :2", lat - tol, lat + tol)
        if logging_on:
            logging.info("finished query")
            for m in matches:
                logging.info(m)
            logging.info("starting filter")
        matches = filter(lambda awd: lon - tol < awd.pop_lon < lon + tol, matches)
        if logging_on:
            logging.info("finished filter")
            for m in matches:
                logging.info(m)
            logging.info("done")
        matches = filter(goodAwd, matches)
        self.response.out.write('{"results" : [' + ",".join(map(str,matches)) + "]}")


class MainHandler(webapp.RequestHandler):
    def get(self):
        self.response.out.write("Use /detail?company=DUNS_ID to access "
                                + "information about a company and "
                                + "contracts it has received")

def parse_int(n):
    try:
        return int(n)
    except ValueError:
        return -1

def parse_long(n):
    try:
        return long(n)
    except ValueError:
        return -1

def parse_float(n):
    try:
        return float(n)
    except ValueError:
        return -1.0

def main():
    application = webapp.WSGIApplication([('/', MainHandler),
                                          ('/admin', AdminHandler),
                                          ('/query', QueryHandler),
                                          ('/detail', DetailHandler)],
                                         debug=True)
    util.run_wsgi_app(application)

if __name__ == '__main__':
    main()
