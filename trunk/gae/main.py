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

class Company(db.Model):
    name = db.StringProperty(required=True)
    duns = db.IntegerProperty(required=True)
    awards = db.ListProperty(str,required=True)
    jobs = db.IntegerProperty(required=True)
    totalReceived = db.IntegerProperty(required=True)
    
    def __str__(self):
        data = {"NAME" : self.name,
                "DUNS" : self.duns,
                "AWARDS": map(lambda id: lookupAward(id), self.awards),
                "JOBS" : self.jobs,
                "RCVD" : self.totalReceived}
        return json.dumps(data)

class Award(db.Model):
    lat = db.FloatProperty()
    lon = db.FloatProperty()
    id = db.StringProperty(required=True)
    amount = db.IntegerProperty(required=True)
    funding_agency = db.StringProperty(required=True)
    recipient_duns = db.IntegerProperty(required=True)
    description = db.TextProperty()
    
    def __str__(self):
        data = {"LAT" : lat,
                "LON" : lon,
                "ID" : id,
                "AMT" : amount,
                "FUNDING_AGCY" : funding_agency,
                "RECIP_DUNS" : repient_duns,
                "DESC" : description}
        return json.dumps(data)

def lookupAward(id):
    award = Award.gql("WHERE id = :1", id)
    return str(award)

class AdminHandler(webapp.RequestHandler):
    def get(self):
        self.response.out.write("""
<html>
<body>
<form action="/admin" method="post">
<input type="text" name="name">
<input type="text" name="duns">
<input type="text" name="awards">
<input type="text" name="jobs">
<input type="text" name="received">
<input type="submit" value="Enter Company">
</body>
</html>
""")
    def post(self):
        name = self.request.get("name")
        duns = long(self.request.get("duns"))
        awards = map(lambda x: x.strip(), self.request.get("awards").split(","))
        jobs = int(self.request.get("jobs"))
        recvd = long(self.request.get("received"))
        c = Company(name=name, duns=duns, awards=awards, jobs=jobs, totalReceived=recvd)
        self.response.out.write(c)
        c.put()
        

class DetailHandler(webapp.RequestHandler):
    def get(self):
        company_id = long(self.request.get("company"))
        matches = Company.gql("WHERE duns = :1", company_id)
        self.response.out.write(matches[0])
        

class MainHandler(webapp.RequestHandler):
    def get(self):
        self.response.out.write('Hello world!')

def main():
    application = webapp.WSGIApplication([('/', MainHandler),
                                         ('/admin', AdminHandler),
                                         ('/detail', DetailHandler)],
                                         debug=True)
    util.run_wsgi_app(application)

if __name__ == '__main__':
    main()
