require 'rubygems'
require 'open-uri'
require 'rethinkdb'
require 'date'
include RethinkDB::Shortcuts


r.connect(:host=>"162.242.238.193", :port=>28015).repl


users = r.db('authentication').table('users').run

output = []
summaries = []
today = Time.now.strftime('%Y-%m-%d')
deadline = (Time.now + (3*7*24*60*60)).strftime('%Y-%m-%d')
yesterday = (Time.now - (24*60*60)).strftime('%Y-%m-%d')

users.each{ |user| 

  user_deadlines = []
  user_updates = []
  recommended = []
  num_updates = 0
  msg = ""

  follows = r.db('jurispect').table('actions').filter({origin: user['id']}).run


  follows.each{ |follow|
    docId= follow['destination']

    reg_data = r.db('jurispect').table('documents').get(docId).pluck('comments_close_on', 'effective_on', 'dates', 'docket_ids', 'publication_date', 'id', 'title', 'agencies').run

    if(reg_data['comments_close_on'] && reg_data['comments_close_on'] >= today && reg_data['comments_close_on'] <= deadline)
      link = 'http://tag.jurispect.com/#/document/' + reg_data['id']
      deadline_data = {:title=>reg_data['title'], :link=>link, :agency=>reg_data['agencies'][0]['name'], :type=>'Comments Due Date'}
      user_deadlines.push(deadline_data)
     
    elsif(reg_data['effective_on'] && reg_data['effective_on'] >= today && reg_data['effective_on'] <= deadline)
      link = 'http://tag.jurispect.com/#/document/' + reg_data['id']
      deadline_data = {:title=>reg_data['title'], :link=>link, :agency=>reg_data['agencies'][0]['name'], :type=>'Effective Date'}
      user_deadlines.push(deadline_data)
    end


    reg_data['docket_ids'].each{ |docket_id|

      update_reg = r.db('jurispect').table('documents').get_all(docket_id, :index => 'docket_ids').filter{ |doc|
                     (doc['publication_date'].gt(reg_data['publication_date'])) & (doc['publication_date'].gt(yesterday))}.run
      
      
      update_reg.each { |update|
        link = 'http://tag.jurispect.com/#/document/' + update['id']
        update_data = {:title=>update['title'], :link=>link, :agency=>update['agencies'][0]}
        user_updates.push(update_data)
      }

    }

  }

  user['agencies'].each{ |agency|
    new_agency_data = r.db('jurispect').table('documents').get_all(agency, :index=> 'agency_id').filter{ |doc|
                      doc['publication_date'].gt(yesterday)}.run

    agency_name = r.db('jurispect').table('agencies').get(agency).pluck('name').run

    new_agency_data.each { |data|
      link = 'http://tag.jurispect.com/#/document/' + data['id']
      new_agency_regs = {:title=>data['title'], :link=>link, :agency=>agency_name}
      recommended.push(new_agency_regs)
    }

  }
  

  result = {Name: user['first_name'], Email: user['email'],  data: { Deadlines: user_deadlines, Updates: user_updates, Recomended: recommended} }
 
  output.push(result)


}

p output

file_name = "daily_stats"+today+".xls"

File.open(file_name, "w+") do |f|
  output.each { |element| f.puts(element)}
end



