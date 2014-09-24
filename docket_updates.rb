require 'rubygems'
require 'open-uri'
require 'rethinkdb'
require 'time'
include RethinkDB::Shortcuts


r.connect(:host=>"162.242.238.193", :port=>28015).repl
r.db("jurispect").table("cfr_topics").run


documents = r.db('jurispect').table('documents').pluck("id", "docket_ids", "publication_date").run

documents.each{ |doc| 
  updated_documents = []
  if(doc['docket_ids'])
    doc['docket_ids'].each{ |docket_id|
      docket_documents = r.db('jurispect').table('documents').get_all(docket_id, :index=>'docket_ids').filter{|row| row['publication_date'].gt(doc['publication_date'])}.pluck('id').run
      
      docket_documents.each{ |id|
        if(!updated_documents.include? id['id'])
          updated_documents.push(id['id'])
        end
      }    
    }
  end

  if(!updated_documents.empty?)
    r.db('jurispect').table('documents').get(doc['id']).update({:docket_updates=>updated_documents}).run
  end
 
 p updated_documents
}
