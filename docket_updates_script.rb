require 'rubygems'
require 'open-uri'
require 'rethinkdb'
require 'time'
include RethinkDB::Shortcuts


r.connect(:host=>"162.242.238.193", :port=>28015).repl

#today = Time.now.strftime('%Y-%m-%d')
today = "2014-11-20"

new_documents = r.db('jurispect').table('documents').get_all(today, :index=>'publication_date').pluck("id", "docket_ids", "publication_date").run

new_documents.each{ |doc| 
  r.db('jurispect').table('documents').get(doc['id']).update({:docket_updates=> []}).run
  if(doc['docket_ids'])
    doc['docket_ids'].each{ |docket_id|
      docket_documents = r.db('jurispect').table('documents').get_all(docket_id, :index=>'docket_ids').filter{|row| row['publication_date'].lt(doc['publication_date'])}.pluck('id', 'docket_updates').run
      
      docket_documents.each{ |id|
        p id['id']
        if(!id['docket_updates'].include? doc['id'])
          p doc['id']
          p id['docket_updates']
          updated_documents = id['docket_updates'].push(doc['id'])
          p updated_documents
          r.db('jurispect').table('documents').get(id['id']).update({:docket_updates=> updated_documents}).run
        end
      }    
    }
  end
}
