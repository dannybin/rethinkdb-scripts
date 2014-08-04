require 'rubygems'
require 'open-uri'
require 'rethinkdb'
require 'time'
include RethinkDB::Shortcuts


r.connect(:host=>"162.242.238.193", :port=>28015).repl
user_data = r.db('authentication').table('users').pluck("id", "agencies", "topics").run

today = Time.now.strftime('%Y-%m-%d')
last_week = (Time.now - (7*24*60*60)).strftime('%Y-%m-%d')

results = []
user_data.each{ |user| 
  user_id = user['id']
  stats = {} 
  dates = []
  user_stats = []

  user['agencies'].each{ |agency|
    rule_count = 0
    pr_count = 0
    date = ""


    reg_data = r.db('jurispect').table('documents').get_all(agency, :index=>'agency_id')
                .filter{ |doc| (doc['publication_date'] > last_week)}
                .pluck('id','publication_date','type','significant','agencies').group('publication_date').run   

    reg_data.each{ |data|
      date = data[0]
      data[1].each{ |reg|
      if(reg['type'] == 'Rule')
        rule_count += 1
      end
      if(reg['type'] == 'Proposed Rule')
        pr_count +=1
      end
      }

      if(dates.include? date)
        user_stats.each{ |el|
          if(el['date'] == date)
            el['pr'] += pr_count
            el['rule'] += rule_count
          end
        }
      else
        dates.push(date)
        stats ={:date=>date, :pr=>pr_count, :rule=>rule_count}
        user_stats.push(stats)
      end
    } 
  }
  
  result = {:user_id=>user_id, :new_articles=>user_stats}
  results.push(result)
}

p results

file_name = "ingestor_stats"+today

File.open(file_name, "w+") do |f|
  results.each { |element| f.puts(element)}
end

