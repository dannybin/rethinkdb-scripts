require 'rubygems'
require 'open-uri'
require 'rethinkdb'
require 'time'
include RethinkDB::Shortcuts


r.connect(:host=>"162.242.238.193", :port=>28015).repl


doc_array = r.db('jurispect').table('documents').pluck("id", "docket_ids").run

doc_array.each{ |doc| 
 
 docket_arr = []

 dockets = doc['docket_ids']
 doc_id = doc['id']

 dockets.each{ |docket|

   docket = docket.sub('and', ',')

   if docket.include? ','
    inner_dockets = docket.split(',')
    
    inner_dockets.each{ |docket_num|
      
      inner_docket = docket_num.strip
      if inner_docket.include? 'Amendment Nos. '
        docket_arr.push(inner_docket.sub('Amendment Nos. ', ''))
      elsif inner_docket.include? 'Amendment No. '
        docket_arr.push(inner_docket.sub('Amendment No. ', ''))
      elsif inner_docket.include? 'Amendment '
        docket_arr.push(inner_docket.sub('Amendment ', ''))
      elsif inner_docket.include? 'Amendment'
        docket_arr.push(inner_docket.sub('Amendment', ''))
      elsif inner_docket.include? 'Amdt. No. '
        docket_arr.push(inner_docket.sub('Amdt. No. ', ''))
      elsif inner_docket.include? 'Document Number '
        docket_arr.push(inner_docket.sub('Document Number ', ''))
      elsif inner_docket.include? 'Directorate Identifier '
        docket_arr.push(inner_docket.sub('Directorate Identifier ', ''))
      elsif inner_docket.include? 'E-Docket ID No. '
        docket_arr.push(inner_docket.sub('E-Docket ID No. ', ''))
      elsif inner_docket.include? 'File No. '
        docket_arr.push(inner_docket.sub('File No. ', ''))
      elsif inner_docket.include? 'File Nos. '
        docket_arr.push(inner_docket.sub('File Nos. ', ''))
      elsif inner_docket.include? 'File no. '
        docket_arr.push(inner_docket.sub('File no. ', ''))
      elsif inner_docket.include? 'File Number '
        docket_arr.push(inner_docket.sub('File Number ', ''))
      elsif inner_docket.include? 'I.D. No. '
        docket_arr.push(inner_docket.sub('I.D. No. ', ''))
      elsif inner_docket.include? 'I.D. '
        docket_arr.push(inner_docket.sub('I.D. ', ''))
      elsif inner_docket.include? 'I.D.'
        docket_arr.push(inner_docket.sub('I.D.', ''))
      elsif inner_docket.include? 'Internal Agency . '
        docket_arr.push(inner_docket.sub('Internal Agency . ', ''))
      elsif inner_docket.include? 'Internal Agency Docket No. '
        docket_arr.push(inner_docket.sub('Internal Agency Docket No. ', ''))
      elsif inner_docket.include? 'Internal Agency  '
        docket_arr.push(inner_docket.sub('Internal Agency  ', ''))
      elsif inner_docket.include? 'MB Docket No. '
        docket_arr.push(inner_docket.sub('MB Docket No. ', ''))
      elsif inner_docket.include? 'MB Docket Nos. '
        docket_arr.push(inner_docket.sub('MB Docket Nos. ', ''))
      elsif inner_docket.include? 'MB '
        docket_arr.push(inner_docket.sub('MB ', ''))
      elsif inner_docket.include? 'MM Docket No. '
        docket_arr.push(inner_docket.sub('MM Docket No. ', ''))
      elsif inner_docket.include? 'MM Docket Nos. '
        docket_arr.push(inner_docket.sub('MM Docket Nos. ', ''))
      elsif inner_docket.include? 'MM . '
        docket_arr.push(inner_docket.sub('MM . ', ''))
      elsif inner_docket.include? 'MM '
        docket_arr.push(inner_docket.sub('MM ', ''))
      elsif inner_docket.include? 'Notice No. '
        docket_arr.push(inner_docket.sub('Notice No. ', ''))
      elsif inner_docket.include? 'Notice '
        docket_arr.push(inner_docket.sub('Notice ', ''))
      elsif inner_docket.include? 'Order No. '
        docket_arr.push(inner_docket.sub('Order No. ', ''))
      elsif inner_docket.include? 'Re: '
        docket_arr.push(inner_docket.sub('Re: ', ''))
      elsif inner_docket.include? 'Ref. '
        docket_arr.push(inner_docket.sub('Ref. ', ''))
      elsif inner_docket.include? 'Ref: '
        docket_arr.push(inner_docket.sub('Ref: ', ''))
      elsif inner_docket.include? 'Release Nos. '
        docket_arr.push(inner_docket.sub('Release Nos. ', ''))
      elsif inner_docket.include? 'Release No. '
        docket_arr.push(inner_docket.sub('Release No. ', ''))
      elsif inner_docket.include? 'SATS No. '
        docket_arr.push(inner_docket.sub('SATS No. ', ''))
      elsif inner_docket.include? 'SATS No.: '
        docket_arr.push(inner_docket.sub('ATS No.: ', ''))
      elsif inner_docket.include? 'SATS No: '
        docket_arr.push(inner_docket.sub('SATS No: ', ''))
      elsif inner_docket.include? 'SATS Nos. '
        docket_arr.push(inner_docket.sub('SATS Nos. ', ''))
      elsif inner_docket.include? 'SATS Number '
        docket_arr.push(inner_docket.sub('ASATS Number ', ''))
      elsif inner_docket.include? 'Special Conditions No. '
        docket_arr.push(inner_docket.sub('Special Conditions No. ', ''))
      elsif inner_docket.include? 'Special Condition '
        docket_arr.push(inner_docket.sub('Special Condition ', ''))
      elsif inner_docket.include? 'SIP NO. '
        docket_arr.push(inner_docket.sub('SIP NO. ', ''))
      elsif inner_docket.include? 'Docket ID No. '
        docket_arr.push(inner_docket.sub('Docket ID No. ', ''))
      elsif inner_docket.include? 'Docket ID. '
        docket_arr.push(inner_docket.sub('Docket ID. ', ''))
      elsif inner_docket.include? 'Docket ID: '
        docket_arr.push(inner_docket.sub('Docket ID: ', ''))
      elsif inner_docket.include? 'Docket ID '
        docket_arr.push(inner_docket.sub('Docket ID ', ''))
      elsif inner_docket.include? 'Docket No.: '
        docket_arr.push(inner_docket.sub('Docket No.: ', ''))
      elsif inner_docket.include? 'Docket No. '
        docket_arr.push(inner_docket.sub('Docket No. ', ''))
      elsif inner_docket.include? 'Docket No.'
        docket_arr.push(inner_docket.sub('Docket No.', ''))
      elsif inner_docket.include? 'Docket No: '
        docket_arr.push(inner_docket.sub('Docket No: ', ''))
      elsif inner_docket.include? 'Docket Nos. '
        docket_arr.push(inner_docket.sub('Docket Nos. ', ''))
      elsif inner_docket.include? 'Docket Numbers '
        docket_arr.push(inner_docket.sub('Docket Numbers ', ''))
      elsif inner_docket.include? 'Docket Number: '
        docket_arr.push(inner_docket.sub('Docket Number: ', ''))
      elsif inner_docket.include? 'Docket Number '
        docket_arr.push(inner_docket.sub('Docket Number ', ''))
      elsif inner_docket.include? 'Dockets '
        docket_arr.push(inner_docket.sub('Dockets ', ''))
      elsif inner_docket.include? 'Docket: '
        docket_arr.push(inner_docket.sub('Docket: ', ''))
      elsif inner_docket.include? 'Docket '
        docket_arr.push(inner_docket.sub('Docket ', ''))
      elsif inner_docket.include? 'Dockets No. '
        docket_arr.push(inner_docket.sub('Dockets No. ', ''))
      elsif inner_docket.include? 'Dockets Nos. '
        docket_arr.push(inner_docket.sub('Dockets Nos. ', ''))
      elsif inner_docket.include? 'Document No. '
        docket_arr.push(inner_docket.sub('Document No. ', ''))
      elsif inner_docket.include? 'Document No.: '
        docket_arr.push(inner_docket.sub('Document No.: ', ''))
      elsif inner_docket.include? 'Doc. No. '
        docket_arr.push(inner_docket.sub('oc. No. ', ''))
      elsif inner_docket.include? 'Doc. # '
        docket_arr.push(inner_docket.sub('Doc. # ', ''))
      elsif inner_docket.include? 'Doc. #'
        docket_arr.push(inner_docket.sub('Doc. #', ''))
      elsif inner_docket.include? 'Doc. '
        docket_arr.push(inner_docket.sub('Doc. ', ''))
      elsif inner_docket.include? 'Doc. '
        docket_arr.push(inner_docket.sub('Doc. ', ''))
      elsif inner_docket.include? 'Doc. '
        docket_arr.push(inner_docket.sub('Doc. ', ''))
      elsif inner_docket.include? 'Doc. '
        docket_arr.push(inner_docket.sub('Doc. ', ''))
      elsif inner_docket.include? 'No. '
        docket_arr.push(inner_docket.sub('No. ', ''))
      elsif inner_docket.include? 'No.'
        docket_arr.push(inner_docket.sub('No.', ''))
      elsif inner_docket.include? ': '
        docket_arr.push(inner_docket.sub(': ', ''))
      elsif inner_docket.include? '. '
        docket_arr.push(inner_docket.sub('. ', ''))
      else
        docket_arr.push(inner_docket)
      end
    }
   elsif
      if docket.include? 'Amendment Nos. '
        docket_arr.push(docket.sub('Amendment Nos. ', ''))
      elsif docket.include? 'Amendment No. '
        docket_arr.push(docket.sub('Amendment No. ', ''))
      elsif docket.include? 'Amendment '
        docket_arr.push(docket.sub('Amendment ', ''))
      elsif docket.include? 'Amendment'
        docket_arr.push(docket.sub('Amendment', ''))
      elsif docket.include? 'Amdt. No. '
        docket_arr.push(docket.sub('Amdt. No. ', ''))
      elsif docket.include? 'Document Number '
        docket_arr.push(docket.sub('Document Number ', ''))
      elsif docket.include? 'Directorate Identifier '
        docket_arr.push(docket.sub('Directorate Identifier ', ''))
      elsif docket.include? 'E-Docket ID No. '
        docket_arr.push(docket.sub('E-Docket ID No. ', ''))
      elsif docket.include? 'File No. '
        docket_arr.push(docket.sub('File No. ', ''))
      elsif docket.include? 'File Nos. '
        docket_arr.push(docket.sub('File Nos. ', ''))
      elsif docket.include? 'File no. '
        docket_arr.push(docket.sub('File no. ', ''))
      elsif docket.include? 'File Number '
        docket_arr.push(docket.sub('File Number ', ''))
      elsif docket.include? 'I.D. No. '
        docket_arr.push(docket.sub('I.D. No. ', ''))
      elsif docket.include? 'I.D. '
        docket_arr.push(docket.sub('I.D. ', ''))
      elsif docket.include? 'I.D.'
        docket_arr.push(docket.sub('I.D.', ''))
      elsif docket.include? 'Internal Agency . '
        docket_arr.push(docket.sub('Internal Agency . ', ''))
      elsif docket.include? 'Internal Agency Docket No. '
        docket_arr.push(docket.sub('Internal Agency Docket No. ', ''))
      elsif docket.include? 'Internal Agency  '
        docket_arr.push(docket.sub('Internal Agency  ', ''))
      elsif docket.include? 'MB Docket No. '
        docket_arr.push(docket.sub('MB Docket No. ', ''))
      elsif docket.include? 'MB Docket Nos. '
        docket_arr.push(docket.sub('MB Docket Nos. ', ''))
      elsif docket.include? 'MB '
        docket_arr.push(docket.sub('MB ', ''))
      elsif docket.include? 'MM Docket No. '
        docket_arr.push(docket.sub('MM Docket No. ', ''))
      elsif docket.include? 'MM Docket Nos. '
        docket_arr.push(docket.sub('MM Docket Nos. ', ''))
      elsif docket.include? 'MM . '
        docket_arr.push(docket.sub('MM . ', ''))
      elsif docket.include? 'MM '
        docket_arr.push(docket.sub('MM ', ''))
      elsif docket.include? 'Notice No. '
        docket_arr.push(docket.sub('Notice No. ', ''))
      elsif docket.include? 'Notice '
        docket_arr.push(docket.sub('Notice ', ''))
      elsif docket.include? 'Order No. '
        docket_arr.push(docket.sub('Order No. ', ''))
      elsif docket.include? 'Re: '
        docket_arr.push(docket.sub('Re: ', ''))
      elsif docket.include? 'Ref. '
        docket_arr.push(docket.sub('Ref. ', ''))
      elsif docket.include? 'Ref: '
        docket_arr.push(docket.sub('Ref: ', ''))
      elsif docket.include? 'Release Nos. '
        docket_arr.push(docket.sub('Release Nos. ', ''))
      elsif docket.include? 'Release No. '
        docket_arr.push(docket.sub('Release No. ', ''))
      elsif docket.include? 'SATS No. '
        docket_arr.push(docket.sub('SATS No. ', ''))
      elsif docket.include? 'SATS No.: '
        docket_arr.push(docket.sub('ATS No.: ', ''))
      elsif docket.include? 'SATS No: '
        docket_arr.push(docket.sub('SATS No: ', ''))
      elsif docket.include? 'SATS Nos. '
        docket_arr.push(docket.sub('SATS Nos. ', ''))
      elsif docket.include? 'SATS Number '
        docket_arr.push(docket.sub('ASATS Number ', ''))
      elsif docket.include? 'Special Conditions No. '
        docket_arr.push(docket.sub('Special Conditions No. ', ''))
      elsif docket.include? 'Special Condition '
        docket_arr.push(docket.sub('Special Condition ', ''))
      elsif docket.include? 'SIP NO. '
        docket_arr.push(docket.sub('SIP NO. ', ''))
      elsif docket.include? 'Docket ID No. '
        docket_arr.push(docket.sub('Docket ID No. ', ''))
      elsif docket.include? 'Docket ID. '
        docket_arr.push(docket.sub('Docket ID. ', ''))
      elsif docket.include? 'Docket ID: '
        docket_arr.push(docket.sub('Docket ID: ', ''))
      elsif docket.include? 'Docket ID '
        docket_arr.push(docket.sub('Docket ID ', ''))
      elsif docket.include? 'Docket No.: '
        docket_arr.push(docket.sub('Docket No.: ', ''))
      elsif docket.include? 'Docket No. '
        docket_arr.push(docket.sub('Docket No. ', ''))
      elsif docket.include? 'Docket No.'
        docket_arr.push(docket.sub('Docket No.', ''))
      elsif docket.include? 'Docket No: '
        docket_arr.push(docket.sub('Docket No: ', ''))
      elsif docket.include? 'Docket Nos. '
        docket_arr.push(docket.sub('Docket Nos. ', ''))
      elsif docket.include? 'Docket Numbers '
        docket_arr.push(docket.sub('Docket Numbers ', ''))
      elsif docket.include? 'Docket Number: '
        docket_arr.push(docket.sub('Docket Number: ', ''))
      elsif docket.include? 'Docket Number '
        docket_arr.push(docket.sub('Docket Number ', ''))
      elsif docket.include? 'Dockets '
        docket_arr.push(docket.sub('Dockets ', ''))
      elsif docket.include? 'Docket: '
        docket_arr.push(docket.sub('Docket: ', ''))
      elsif docket.include? 'Docket '
        docket_arr.push(docket.sub('Docket ', ''))
      elsif docket.include? 'Dockets No. '
        docket_arr.push(docket.sub('Dockets No. ', ''))
      elsif docket.include? 'Dockets Nos. '
        docket_arr.push(docket.sub('Dockets Nos. ', ''))
      elsif docket.include? 'Document No. '
        docket_arr.push(docket.sub('Document No. ', ''))
      elsif docket.include? 'Document No.: '
        docket_arr.push(docket.sub('Document No.: ', ''))
      elsif docket.include? 'Doc. No. '
        docket_arr.push(docket.sub('oc. No. ', ''))
      elsif docket.include? 'Doc. # '
        docket_arr.push(docket.sub('Doc. # ', ''))
      elsif docket.include? 'Doc. #'
        docket_arr.push(docket.sub('Doc. #', ''))
      elsif docket.include? 'Doc. '
        docket_arr.push(docket.sub('Doc. ', ''))
      elsif docket.include? 'Doc. '
        docket_arr.push(docket.sub('Doc. ', ''))
      elsif docket.include? 'Doc. '
        docket_arr.push(docket.sub('Doc. ', ''))
      elsif docket.include? 'Doc. '
        docket_arr.push(docket.sub('Doc. ', ''))
      elsif docket.include? 'No. '
        docket_arr.push(docket.sub('No. ', ''))
      elsif docket.include? 'No.'
        docket_arr.push(docket.sub('No.', ''))
      elsif docket.include? ': '
        docket_arr.push(docket.sub(': ', ''))
      elsif docket.include? '. '
        docket_arr.push(docket.sub('. ', ''))
      else
        docket_arr.push(docket)
      end
   end
  
 } 

 r.db('jurispect').table('documents').get(doc_id).update({:docket_ids=>docket_arr}).run
}
