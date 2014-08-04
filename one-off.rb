require 'rubygems'
require 'open-uri'
require 'rethinkdb'
require 'time'
include RethinkDB::Shortcuts


r.connect(:host=>"162.242.238.193", :port=>28015).repl
r.db("jurispect").table("cfr_topics").run


cfr_array = r.db('jurispect').table('cfr_topics').pluck("part", "title", "topics").run

cfr_array.each{ |cfr| 
  parts = []
  titles= []
  matched_reg = []
  cfr_part = r.db('jurispect').table('documents').get_all(cfr['part'], :index =>'cfr_part').pluck('id').run
  
  cfr_part.each{ |part|
    parts.push(part['id'])
  }

  cfr_title = r.db('jurispect').table('documents').get_all(cfr['title'], :index =>'cfr_title').pluck('id').run

  cfr_title.each{ |title|
    titles.push(title['id'])
  }
 

 matched_reg = parts & titles

 matched_reg.each{ |reg|

  curr_topics = r.db('jurispect').table('documents').get(reg).pluck('topics').run

  all_topics = curr_topics['topics'] | cfr['topics']

  r.db('jurispect').table('documents').get(reg).update({:topics=>all_topics}).run
 }

}
