require 'rubygems'
require 'open-uri'
require 'rethinkdb'
require 'date'
include RethinkDB::Shortcuts


r.connect(:host=>"162.242.238.193", :port=>28015).repl


users = r.db('authentication').table('users').run

today = Time.now.strftime('%Y-%m-%d')
three_weeks_deadline = (Time.now + (3*7*24*60*60)).strftime('%Y-%m-%d')
one_week_deadline = (Time.now + (7*24*60*60)).strftime('%Y-%m-%d')
yesterday = (Time.now - (24*60*60)).strftime('%Y-%m-%d')
now = (Time.now.to_i)*1000

users.each{ |user| 
  follows = r.db('jurispect').table('actions').filter({"origin" => user['id']}).run


  follows.each{ |follow|
    docId= follow['destination']

    reg_data = r.db('jurispect').table('documents').get(docId).pluck('comments_close_on', 'effective_on', 'dates', 'docket_ids', 'publication_date', 'id', 'title', 'agencies', 'type').run

    if(reg_data['comments_close_on'] && reg_data['comments_close_on'] >= today && (reg_data['comments_close_on'] == three_weeks_deadline || reg_data['comments_close_on'] == one_week_deadline))
      link = 'http://tag.jurispect.com/#/document/' + reg_data['id']
      message ='You have an upcoming deadline of comment due date for '+ reg_data['type'] + ' '+ reg_data['id']
      notification = {:creation_time=>now, :message=>message, :show=>true}
      new_notification = r.db('jurispect').table('notifications').insert(notification).run
      notification_id = new_notification['generated_keys'][0]
      notifications_with_id = {:notification_id=>notification_id,:creation_time=>now, :message=>message, :show=>true}
      r.db('authentication').table('users').get(user['id']).update{|doc| {'notifications' => doc['notifications'].append(notifications_with_id)} }.run
    elsif(reg_data['effective_on'] && reg_data['effective_on'] >= today && (reg_data['effective_on'] == three_weeks_deadline || reg_data['effective_on'] == one_week_deadline))
      link = 'http://tag.jurispect.com/#/document/' + reg_data['id']
      message ='You have an upcoming deadline of effective date for '+ reg_data['type'] + ' '+ reg_data['id']
      notification = {:creation_time=>now, :message=>message, :show=>true}
      new_notification = r.db('jurispect').table('notifications').insert(notification).run
      notification_id = new_notification['generated_keys'][0]
      notifications_with_id = {:notification_id=>notification_id,:creation_time=>now, :message=>message, :show=>true}
      r.db('authentication').table('users').get(user['id']).update{|doc| {'notifications' => doc['notifications'].append(notifications_with_id)} }.run
    end


    reg_data['docket_ids'].each{ |docket_id|

      update_reg = r.db('jurispect').table('documents').get_all(docket_id, :index => 'docket_ids').filter{ |doc|
                     (doc['publication_date'].gt(reg_data['publication_date'])) & (doc['publication_date'].gt(yesterday))}.run
      
      
      update_reg.each { |update|
        link = 'http://tag.jurispect.com/#/document/' + update['id']
        message ='You have a new update on '+ update['type'] + ' '+ update['id']
        notification = {:creation_time=>now, :message=>message, :show=>true}
        new_notification = r.db('jurispect').table('notifications').insert(notification).run
        notification_id = new_notification['generated_keys'][0]
        notifications_with_id = {:notification_id=>notification_id,:creation_time=>now, :message=>message, :show=>true}
        r.db('authentication').table('users').get(user['id']).update{|doc| {'otifications'=> doc['notifications'].append(notifications_with_id)} }.run
      }

    }

  }

  user['agencies'].each{ |agency|
    new_agency_data = r.db('jurispect').table('documents').get_all(agency, :index=> 'agency_id').filter{ |doc|
                      doc['publication_date'].gt(yesterday)}.run

    agency_name = r.db('jurispect').table('agencies').get(agency).pluck('name').run

    new_agency_data.each { |data|
      link = 'http://tag.jurispect.com/#/document/' + data['id']
      message = agency_name['name'] + ' has published a new article.'
      notification = {:creation_time=>now, :message=>message, :show=>true}
      new_notification = r.db('jurispect').table('notifications').insert(notification).run
      notification_id = new_notification['generated_keys'][0]
      notifications_with_id = {:notification_id=>notification_id,:creation_time=>now, :message=>message, :show=>true}
      r.db('authentication').table('users').get(user['id']).update{|doc| {'notifications'=> doc['notifications'].append(notifications_with_id)} }.run
    }

  }
  
}





