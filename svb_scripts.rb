require 'rubygems'
require 'open-uri'
require 'rethinkdb'
require 'date'

include RethinkDB::Shortcuts


r.connect(:host=>"162.242.238.193", :port=>28015).repl

doj_result = []
fcpa_result = []
ftc_result = []
coppa_result = []
canspam_result = []
ffiec_result = []
hud_result = []
cftc_result = []
fdic_result = []
cfpb_result = []
frb_result = []
sec_result = []


DOJ_ALL = r.db('jurispect').table('documents').get_all(268, :index => 'agency_id').filter{ |doc| doc['publication_date'].gt('2010-01-01')}.order_by(r.asc('publication_date')).run

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

  if(summary)
    if((summary.include? 'assets of') || (summary.include? 'exemption threshold') )
      result = [id]
    end
  end

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  doj_result.push(result)
}

File.open('svb_doj.xls', "w+") do |f|
  doj_result.each { |element| f.puts(element)}
end



FTC_ALL = r.db('jurispect').table('documents').get_all(192, :index => 'agency_id').filter{ |doc| doc['publication_date'].gt('2010-01-01')}.order_by(r.asc('publication_date')).run

FTC_ALL.each{ |doc|
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

  if(summary)
    if((summary.include? 'assets of') || (summary.include? 'exemption threshold') )
      result = [id]
    end
  end

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  ftc_result.push(result)
}

File.open('svb_ftc.xls', "w+") do |f|
  ftc_result.each { |element| f.puts(element)}
end







SEC_ALL = r.db('jurispect').table('documents').get_all(466, :index => 'agency_id').filter{ |doc| doc['publication_date'].gt('2010-01-01')}.order_by(r.asc('publication_date')).run

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

  if(summary)
    if((summary.include? 'assets of') || (summary.include? 'exemption threshold') )
      result = [id]
    end
  end

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  sec_result.push(result)
}

File.open('svb_sec.xls', "w+") do |f|
  sec_result.each { |element| f.puts(element)}
end







FFIEC_ALL = r.db('jurispect').table('documents').get_all(168, :index => 'agency_id').filter{ |doc| doc['publication_date'].gt('2010-01-01')}.order_by(r.asc('publication_date')).run

FFIEC_ALL.each{ |doc|
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

  if(summary)
    if((summary.include? 'assets of') || (summary.include? 'exemption threshold') )
      result = [id]
    end
  end

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  ffiec_result.push(result)
}

File.open('svb_ffiec.xls', "w+") do |f|
  ffiec_result.each { |element| f.puts(element)}
end




HUD_ALL = r.db('jurispect').table('documents').get_all(228, :index => 'agency_id').filter{ |doc| doc['publication_date'].gt('2010-01-01')}.order_by(r.asc('publication_date')).run

HUD_ALL.each{ |doc|
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

  if(summary)
    if((summary.include? 'assets of') || (summary.include? 'exemption threshold') )
      result = [id]
    end
  end

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  hud_result.push(result)
}

File.open('svb_hud.xls', "w+") do |f|
  hud_result.each { |element| f.puts(element)}
end





CFTC_ALL = r.db('jurispect').table('documents').get_all(77, :index => 'agency_id').filter{ |doc| doc['publication_date'].gt('2010-01-01')}.order_by(r.asc('publication_date')).run

CFTC_ALL.each{ |doc|
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

  if(summary)
    if((summary.include? 'assets of') || (summary.include? 'exemption threshold') )
      result = [id]
    end
  end

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  cftc_result.push(result)
}

File.open('svb_cftc.xls', "w+") do |f|
  cftc_result.each { |element| f.puts(element)}
end




FDIC_ALL = r.db('jurispect').table('documents').get_all(164, :index => 'agency_id').filter{ |doc| doc['publication_date'].gt('2010-01-01')}.order_by(r.asc('publication_date')).run

FDIC_ALL.each{ |doc|
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

  if(summary)
    if((summary.include? 'assets of') || (summary.include? 'exemption threshold') )
      result = [id]
    end
  end

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  fdic_result.push(result)
}

File.open('svb_fdic.xls', "w+") do |f|
  fdic_result.each { |element| f.puts(element)}
end





CFPB_ALL = r.db('jurispect').table('documents').get_all(573, :index => 'agency_id').filter{ |doc| doc['publication_date'].gt('2010-01-01')}.order_by(r.asc('publication_date')).run

CFPB_ALL.each{ |doc|
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

  if(summary)
    if((summary.include? 'assets of') || (summary.include? 'exemption threshold') )
      result = [id]
    end
  end

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  cfpb_result.push(result)
}

File.open('svb_cfpb.xls', "w+") do |f|
  cfpb_result.each { |element| f.puts(element)}
end




FRB_ALL = r.db('jurispect').table('documents').get_all(188, :index => 'agency_id').filter{ |doc| doc['publication_date'].gt('2010-01-01')}.order_by(r.asc('publication_date')).run

FRB_ALL.each{ |doc|
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

  if(summary)
    if((summary.include? 'assets of') || (summary.include? 'exemption threshold') )
      result = [id]
    end
  end

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  frb_result.push(result)
}

File.open('svb_frb.xls', "w+") do |f|
  frb_result.each { |element| f.puts(element)}
end






FCPA = r.db('jurispect').table('documents').filter{ |doc| doc['text_content'].match('Foreign Corrupt Practices Act')}.filter{ |doc| doc['publication_date'].gt('2010-01-01')}.order_by(r.asc('publication_date')).run
FCPA_short = r.db('jurispect').table('documents').filter{ |doc| doc['text_content'].match('FCPA')}.filter{ |doc| doc['publication_date'].gt('2010-01-01')}.order_by(r.asc('publication_date')).run

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

  if(summary)
    if((summary.include? 'assets of') || (summary.include? 'exemption threshold') )
      result = [id]
    end
  end

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

  if(summary)
    if((summary.include? 'assets of') || (summary.include? 'exemption threshold') )
      result = [id]
    end
  end

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  fcpa_result.push(result)
}

File.open('svb_fcpa.xls', "w+") do |f|
  fcpa_result.each { |element| f.puts(element)}
end






COPPA = r.db('jurispect').table('documents').filter{ |doc| doc['text_content'].match('COPPA')}.filter{ |doc| doc['publication_date'].gt('2010-01-01')}.order_by(r.asc('publication_date')).run
COPPA_full = r.db('jurispect').table('documents').filter{ |doc| doc['text_content'].match('Children\'s Online Privacy Protection Act')}.filter{ |doc| doc['publication_date'].gt('2010-01-01')}.order_by(r.asc('publication_date')).run

COPPA.each{ |doc|
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

  if(summary)
    if((summary.include? 'assets of') || (summary.include? 'exemption threshold') )
      result = [id]
    end
  end

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  coppa_result.push(result)
}

COPPA_full.each{ |doc|
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

  if(summary)
    if((summary.include? 'assets of') || (summary.include? 'exemption threshold') )
      result = [id]
    end
  end

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  coppa_result.push(result)
}

File.open('svb_coppa.xls', "w+") do |f|
  coppa_result.each { |element| f.puts(element)}
end





CANSPAM = r.db('jurispect').table('documents').filter{ |doc| doc['text_content'].match('CAN-SPAM')}.filter{ |doc| doc['publication_date'].gt('2010-01-01')}.order_by(r.asc('publication_date')).run
CANSPAM_full = r.db('jurispect').table('documents').filter{ |doc| doc['text_content'].match('Controlling the Assault of Non-Solicited Pornography And Marketing Act')}.filter{ |doc| doc['publication_date'].gt('2010-01-01')}.order_by(r.asc('publication_date')).run

CANSPAM.each{ |doc|
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

  if(summary)
    if((summary.include? 'assets of') || (summary.include? 'exemption threshold') )
      result = [id]
    end
  end

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  canspam_result.push(result)
}

CANSPAM_full.each{ |doc|
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

  if(summary)
    if((summary.include? 'assets of') || (summary.include? 'exemption threshold') )
      result = [id]
    end
  end

  result = [title, summary, pdf_url, id, type, agency, publication_date, important_date, effective_date, docket_ids, cfr, fr]
  canspam_result.push(result)
}

File.open('svb_canspam.xls', "w+") do |f|
  canspam_result.each { |element| f.puts(element)}
end

