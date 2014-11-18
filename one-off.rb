require 'rubygems'
require 'open-uri'
require 'rethinkdb'
require 'time'
include RethinkDB::Shortcuts


r.connect(:host=>"162.242.238.193", :port=>28015).repl


#add topic mapping to industries
docs = r.db('jurispect').table('documents').pluck( 'agencies', 'topics').run

docs.each{ |item|
  topics = item['topics']
  agencies = item['agencies']
  if(agencies.length>0 && topics.length>0)
    agencies.each{ |agency|
      agency_id = agency['id']
      if(agency_id)
        industries = r.db('jurispect').table('industries').get_all(agency_id, :index=>'agency_id').pluck('id')['id'].run
        industries.each{ |industry|
          curr_topics = r.db('jurispect').table('industries').get(industry).pluck('topics')['topics'].run
          
          topics.each{ |topic|
            if(!curr_topics.include? topic)
              curr_topics.push(topic)
            end

          }
          p curr_topics
          r.db('jurispect').table('industries').get(industry).update({:topics=>curr_topics}).run
        }
      end
    }
  end

}


=begin

#convert news time format 
news = r.db('jurispect').table('news').filter{ |doc| (doc['creation_time'].eq('2014-09-23').not()) & (doc['creation_time'].eq('2014-09-24').not() ) & (doc['creation_time'].eq('2014-09-25').not() )}.pluck('id', 'creation_time').run
news.each{ |item|

  new_time = item['creation_time'].strftime("%Y-%m-%d")
  id = item['id']

  r.db('jurispect').table('news').get(id).update({:creation_time=>new_time}).run

  p new_time
}



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
=end