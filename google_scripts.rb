require 'rubygems'
require 'open-uri'
require 'rethinkdb'
require 'date'

include RethinkDB::Shortcuts


r.connect(:host=>"162.242.238.193", :port=>28015).repl

fcpa_result = []
conf_min_result = []
hipaa_result = []
sec_result = []
doj_result = []
payments_result = []
bribry_result = []
cyber_security_result = []
privacy_result = []
canspam_result = []



=begin


SEC_ALL = r.db('jurispect').table('documents').get_all(466, :index => 'agency_id').run

SEC_ALL.each{ |doc|
  id = doc['id']
  summary = doc['abstract']
  publication_date = doc['publication_date']
  important_date = doc['dates']
  effective_date = doc['effective_on']
  type = doc['type']
  pdf_url = doc['pdf_url']
  docket_ids = doc['docket_ids'].join(',')
  agency = doc['agencies'][0]['name']
  title = doc['title']
  cfr = doc['cfr_references'].join(';')
  fr = doc['citation'] 

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  sec_result.push(result)
}

File.open('google_sec.xls', "w+") do |f|
  sec_result.each { |element| f.puts(element)}
end




DOJ_ALL = r.db('jurispect').table('documents').get_all(268, :index => 'agency_id').run

DOJ_ALL.each{ |doc|
  id = doc['id']
  summary = doc['abstract']
  publication_date = doc['publication_date']
  important_date = doc['dates']
  effective_date = doc['effective_on']
  type = doc['type']
  pdf_url = doc['pdf_url']
  docket_ids = doc['docket_ids'].join(',')
  agency = doc['agencies'][0]['name']
  title = doc['title']
  cfr = doc['cfr_references'].join(';')
  fr = doc['citation'] 

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  doj_result.push(result)
}

File.open('google_doj.xls', "w+") do |f|
  doj_result.each { |element| f.puts(element)}
end




FCPA = r.db('jurispect').table('documents').filter{ |doc| doc['text_content'].match('Foreign Corrupt Practices Act')}.order_by(r.asc('publication_date')).without('text_content').run
FCPA_short = r.db('jurispect').table('documents').filter{ |doc| doc['text_content'].match('FCPA')}.order_by(r.asc('publication_date')).without('text_content').run

FCPA.each{ |doc|
  id = doc['id']
  summary = doc['abstract']
  publication_date = doc['publication_date']
  important_date = doc['dates']
  effective_date = doc['effective_on']
  type = doc['type']
  pdf_url = doc['pdf_url']
  docket_ids = doc['docket_ids'].join(',')
  agency = doc['agencies'][0]['name']
  title = doc['title']
  cfr = doc['cfr_references'].join(';')
  fr = doc['citation']  

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  fcpa_result.push(result)
}

FCPA_short.each{ |doc|
  id = doc['id']
  summary = doc['abstract']
  publication_date = doc['publication_date']
  important_date = doc['dates']
  effective_date = doc['effective_on']
  type = doc['type']
  pdf_url = doc['pdf_url']
  docket_ids = doc['docket_ids'].join(',')
  agency = doc['agencies'][0]['name']
  title = doc['title']
  cfr = doc['cfr_references'].join(';')
  fr = doc['citation']  

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  fcpa_result.push(result)
}

File.open('google_fcpa.xls', "w+") do |f|
  fcpa_result.each { |element| f.puts(element)}
end






CONF_MIN = r.db('jurispect').table('documents').filter{ |doc| doc['text_content'].match('conflict minerals')}.order_by(r.asc('publication_date')).without('text_content').run

CONF_MIN.each{ |doc|
  id = doc['id']
  summary = doc['abstract']
  publication_date = doc['publication_date']
  important_date = doc['dates']
  effective_date = doc['effective_on']
  type = doc['type']
  pdf_url = doc['pdf_url']
  docket_ids = doc['docket_ids'].join(',')
  agency = doc['agencies'][0]['name']
  title = doc['title']
  cfr = doc['cfr_references'].join(';')
  fr = doc['citation']  

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  conf_min_result.push(result)
}


File.open('google_conf_min.xls', "w+") do |f|
  conf_min_result.each { |element| f.puts(element)}
end





HIPAA= r.db('jurispect').table('documents').filter{ |doc| doc['text_content'].match('HIPAA')}.order_by(r.asc('publication_date')).without('text_content').run
HIPAA_full = r.db('jurispect').table('documents').filter{ |doc| doc['text_content'].match('Health Insurance Portability and Accountability Act')}.order_by(r.asc('publication_date')).without('text_content').run

HIPAA.each{ |doc|
  id = doc['id']
  summary = doc['abstract']
  publication_date = doc['publication_date']
  important_date = doc['dates']
  effective_date = doc['effective_on']
  type = doc['type']
  pdf_url = doc['pdf_url']
  docket_ids = doc['docket_ids'].join(',')
  agency = doc['agencies'][0]['name']
  title = doc['title']
  cfr = doc['cfr_references'].join(';')
  fr = doc['citation']  

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  hipaa_result.push(result)
}

HIPAA_full.each{ |doc|
  id = doc['id']
  summary = doc['abstract']
  publication_date = doc['publication_date']
  important_date = doc['dates']
  effective_date = doc['effective_on']
  type = doc['type']
  pdf_url = doc['pdf_url']
  docket_ids = doc['docket_ids'].join(',')
  agency = doc['agencies'][0]['name']
  title = doc['title']
  cfr = doc['cfr_references'].join(';')
  fr = doc['citation']  

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  hipaa_result.push(result)
}

File.open('google_hipaa.xls', "w+") do |f|
  hipaa_result.each { |element| f.puts(element)}
end




ELEC_PAY = r.db('jurispect').table('documents').filter{ |doc| doc['text_content'].match('electronic payment')}.order_by(r.asc('publication_date')).without('text_content').run

ELEC_PAY.each{ |doc|
  id = doc['id']
  summary = doc['abstract']
  publication_date = doc['publication_date']
  important_date = doc['dates']
  effective_date = doc['effective_on']
  type = doc['type']
  pdf_url = doc['pdf_url']
  docket_ids = doc['docket_ids'].join(',')
  agency = doc['agencies'][0]['name']
  title = doc['title']
  cfr = doc['cfr_references'].join(';')
  fr = doc['citation']  

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  payments_result.push(result)
}

MOBL_PAY = r.db('jurispect').table('documents').filter{ |doc| doc['text_content'].match('mobile payment')}.order_by(r.asc('publication_date')).without('text_content').run

MOBL_PAY.each{ |doc|
  id = doc['id']
  summary = doc['abstract']
  publication_date = doc['publication_date']
  important_date = doc['dates']
  effective_date = doc['effective_on']
  type = doc['type']
  pdf_url = doc['pdf_url']
  docket_ids = doc['docket_ids'].join(',')
  agency = doc['agencies'][0]['name']
  title = doc['title']
  cfr = doc['cfr_references'].join(';')
  fr = doc['citation']  

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  payments_result.push(result)
}



File.open('google_payments.xls', "w+") do |f|
  payments_result.each { |element| f.puts(element)}
end





BRIBRY= r.db('jurispect').table('documents').filter{ |doc| doc['text_content'].match('bribery')}.order_by(r.asc('publication_date')).without('text_content').run

begin
BRIBRY.each{ |doc|
  id = doc['id']
  summary = doc['abstract']
  publication_date = doc['publication_date']
  important_date = doc['dates']
  effective_date = doc['effective_on']
  type = doc['type']
  pdf_url = doc['pdf_url']
  docket_ids = doc['docket_ids'].join(',')
  agency = doc['agencies'][0]['name']
  title = doc['title']
  cfr = doc['cfr_references'].join(';')
  fr = doc['citation']  

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  bribry_result.push(result)
}
rescue
end


File.open('google_bribery.xls', "w+") do |f|
  bribry_result.each { |element| f.puts(element)}
end





CY_SECURITY= r.db('jurispect').table('documents').filter{ |doc| doc['text_content'].match('cybersecurity')}.without('text_content').run

CY_SECURITY.each{ |doc|
  id = doc['id']
  summary = doc['abstract']
  publication_date = doc['publication_date']
  important_date = doc['dates']
  effective_date = doc['effective_on']
  type = doc['type']
  pdf_url = doc['pdf_url']
  docket_ids = doc['docket_ids'].join(',')
  agency = doc['agencies'][0]['name']
  title = doc['title']
  cfr = doc['cfr_references'].join(';')
  fr = doc['citation']  

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  cyber_security_result.push(result)
}



File.open('google_cyber_security.xls', "w+") do |f|
  cyber_security_result.each { |element| f.puts(element)}
end

=end


PRIVACY = r.db('jurispect').table('documents').filter{ |doc| doc['text_content'].match('privacy')}.without('text_content').run

begin
PRIVACY.each{ |doc|
  id = doc['id']
  summary = doc['abstract']
  publication_date = doc['publication_date']
  important_date = doc['dates']
  effective_date = doc['effective_on']
  type = doc['type']
  pdf_url = doc['pdf_url']
  docket_ids = doc['docket_ids'].join(',')
  agency = doc['agencies'][0]['name']
  title = doc['title']
  cfr = doc['cfr_references'].join(';')
  fr = doc['citation']  

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  privacy_result.push(result)
}
rescue
end


File.open('google_privacy.xls', "w+") do |f|
  privacy_result.each { |element| f.puts(element)}
end



