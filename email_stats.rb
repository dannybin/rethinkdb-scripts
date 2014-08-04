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
  user_agencies = []
  user_deadlines = []
  user_updates = []
  num_follows = 0
  num_updates = 0
  msg = ""

  follows = r.db('jurispect').table('actions').filter({origin: user['id']}).run


  follows.each{ |follow|
    docId= follow['destination']

    reg_data = r.db('jurispect').table('documents').get(docId).pluck('comments_close_on', 'effective_on', 'dates', 'docket_ids', 'publication_date', 'id').run

    if(reg_data['comments_close_on'] && reg_data['comments_close_on'] >= today && reg_data['comments_close_on'] <= deadline)
      user_deadlines.push(reg_data['dates']+" for "+reg_data['id'])
    
    elsif(reg_data['effective_on'] && reg_data['effective_on'] >= today && reg_data['effective_on'] <= deadline)
      user_deadlines.push(reg_data['dates']+" for "+reg_data['id'])
    end
    num_follows +=1

    reg_data['docket_ids'].each{ |docket_id|

      update_reg = r.db('jurispect').table('documents').get_all(docket_id, :index => 'docket_ids').filter{ |doc|
                     doc['publication_date'].gt(reg_data['id'])}.run
      
      curr_updates = update_reg.count
      num_updates = num_updates + curr_updates

      if( curr_updates > 0 ) 
        msg = "There are "+curr_updates.to_s+" updates under docket "+ docket_id+" since the publication of the regulation "+reg_data['id']

        user_updates.push(msg)
      end
    }
  }
  
  user['agencies'].each{ |agencyId|
    
    agency_name = r.db('jurispect').table('agencies').get(agencyId).pluck('name').run
    user_agencies.push(agency_name['name'])
  }

  user_industry = r.db('jurispect').table('industries').get(user['industry']).pluck('title').run

    result = {Email: user['email'], Following: num_follows, Deadline_Count: user_deadlines.count, Deadlines: user_deadlines, Update_Count: num_updates,
              Updates: user_updates, Topics: user['topics'], Agencies: user_agencies, Industry: user_industry['title']}
 
  output.push(result)


}

p output

file_name = "daily_stats"+today+".xls"

File.open(file_name, "w+") do |f|
  output.each { |element| f.puts(element)}
end



