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

class Company(db.Model):
    name = db.StringProperty(required=True)
    duns = db.IntegerProperty(required=True)
    awards = db.ListProperty(required=True)
    jobs = db.IntegerProperty(required=True)
    totalReceived = db.IntegerProperty(required=True)

class Award(db.Model):
    lat = db.FloatProperty()
    long = db.FloatProperty()
    id = db.StringProperty(required=True)
    amount = db.IntegerProperty(required=True)
    funding_agency = db.StringProperty(required=True)
    recipient_duns = db.IntegerProperty(required=True)
    description = db.TextProperty()

class AdminHandler(webapp.RequestHandler):
    def get(self):
        self.response.out.write("""
<html>
<body>
<form action="/admin" method="post">
<input type="text" name="name">

<input type="text" name="duns">
<input type="submit" value="Enter Company">
</body>
</html>
"""

class DetailHandler(webapp.RequestHandler):
    def get(self):
        #company_id = self.request.get("company")
        #matches = Company.gql("WHERE duns = :1", company_id)
        pass


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
