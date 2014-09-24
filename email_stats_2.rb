require 'rubygems'
require 'open-uri'
require 'rethinkdb'
require 'date'
require 'net/http'
require 'uri'
require 'json'
include RethinkDB::Shortcuts


r.connect(:host=>"162.242.238.193", :port=>28015).repl

uri = URI.parse('http://www.knowtify.io/api/v1/contacts/add')
req = Net::HTTP::Post.new(uri.path)

users = r.db('authentication').table('users').run


contacts = []
summaries = []
today = Time.now.strftime('%Y-%m-%d')
deadline = (Time.now + (3*7*24*60*60)).strftime('%Y-%m-%d')
yesterday = (Time.now - (24*60*60)).strftime('%Y-%m-%d')

users.each{ |user| 

  user_deadlines = []
  user_updates = []
  recommended = []
  user_news = []


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
  
  email_news = r.db('jurispect').table('email_news').filter{ |news| news['creation_time'].eq(today)}.run
  email_news.each{ |article|
    news_article = {:title=>article['title'], :link=>article['link'], :source=>article['source']}
    user_news.push(news_article)
  }

  result = {:name=>user['first_name'], :email=>user['email'],  :data=> { Deadlines: user_deadlines, Updates: user_updates, Recomended: recommended, News: user_news}}
 
  contacts.push(result)


}
p contacts
post_params = {:contacts => contacts}

req.body = JSON.generate(post_params)
req["Content-Type"] = "application/json"
req["Authorization"] = 'Token token="14c9821031f134cd1f8a8b74bb974b28"'

http = Net::HTTP.new(uri.host, uri.port)
response = http.start { |htt| htt.request(req) }

p response


file_name = "daily_stats"+today+".xls"

File.open(file_name, "w+") do |f|
  contacts.each { |element| f.puts(element)}
end



