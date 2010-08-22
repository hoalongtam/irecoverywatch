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
        puts = self.response.out.write
        puts("<html><body>")
        puts("<h1>%s</h1><br />" % job.recipient_name)
        puts("<b>Amount: $%.2f</b><p>" % job.amount)
        puts("<b>Award Date: </b>%s<p>" % job.award_date)
        puts("<b>Award Type:</b> %s<p>" % types[job.award_type])
        puts("<b>Funding agency:</b> %s<p>" % job.funding_agency)
        puts("<b>Award description:</b> %s<p>" % job.award_desc)
        puts("</body></html>")

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
