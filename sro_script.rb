require 'rubygems'
require 'open-uri'
require 'rethinkdb'
require 'time'
include RethinkDB::Shortcuts


r.connect(:host=>"162.242.238.193", :port=>28015).repl


SROs = r.db('jurispect').table('documents').filter({:type => 'Notice'}).run

SROs.each{ |sro| 
  agencies = []
  docId = sro.id
  
  if sro.toc_subject.include? "Proposed Rule"
    type = "Proposed Rule"
  else
    type = "Rule"
  end
  
  sro_name = sro.toc_toc.downcase
  
  if(sro_name.include? "bats exchange")
    agency = {:id=>9001,:name=>'BATS Exchange',:raw_name=>'BATS Exchange', :url=>'http://batstrading.com', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "bats y-exchange")
    agency = {:id=>9002,:name=>'BATS Y-Exchange',:raw_name=>'BATS Y-Exchange)', :url=>'http://www.batstrading.com/byx/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  elsif(sro_name.include? "bats yexchange")
    agency = {:id=>9002,:name=>'BATS Y-Exchange',:raw_name=>'BATS Y-Exchange)', :url=>'http://www.batstrading.com/byx/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  elsif(sro_name.include? "batsy exchange")
    agency = {:id=>9002,:name=>'BATS Y-Exchange',:raw_name=>'BATS Y-Exchange)', :url=>'http://www.batstrading.com/byx/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "board of trade of the city of chicago")
    agency = {:id=>9003,:name=>'Chicago Board of Trade',:raw_name=>'Chicago Board of Trade)', :url=>'http://www.cmegroup.com/company/cbot.html', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "boston stock exchange clearing")
    agency = {:id=>9004,:name=>'Boston Stock Exchange Clearing Corp',:raw_name=>'Boston Stock Exchange Clearing Corp', :url=>'http://nasdaqomxbx.cchwallstreet.com/NASDAQOMXBX/Main/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  elsif(sro_name.include? "boston stock clearing")
    agency = {:id=>9004,:name=>'Boston Stock Exchange Clearing Corp',:raw_name=>'Boston Stock Exchange Clearing Corp', :url=>'http://nasdaqomxbx.cchwallstreet.com/NASDAQOMXBX/Main/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "boston stock exchange")
    agency = {:id=>9005,:name=>'Boston Stock Exchange (BX)',:raw_name=>'Boston Stock Exchange (BX)', :url=>'http://nasdaqomxbx.cchwallstreet.com/NASDAQOMXBX/Main/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "box options exchange")
    agency = {:id=>9006,:name=>'BOX Options Exchange',:raw_name=>'BOX Options Exchange', :url=>'http://boxexchange.com/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "c2 options exchange")
    agency = {:id=>9007,:name=>'C2 Options Exchange',:raw_name=>'C2 Options Exchange', :url=>'http://www.c2exchange.com/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "cboe futures exchange")
    agency = {:id=>9008,:name=>'CBOE Futures Exchange',:raw_name=>'CBOE Futures Exchange', :url=>'http://cfe.cboe.com/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "chicago board options exchange")
    agency = {:id=>9009,:name=>'Chicago Board Options Exchange',:raw_name=>'Chicago Board Options Exchange', :url=>'http://www.cboe.com/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "chicago mercantile exchange")
    agency = {:id=>9010,:name=>'Chicago Mercantile Exchange',:raw_name=>'Chicago Mercantile Exchange', :url=>'http://www.cmegroup.com/', :parent_id=>466, :json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "chicago stock exchange")
    agency = {:id=>9011,:name=>'Chicago Stock Exchange',:raw_name=>'Chicago Stock Exchange', :url=>'http://www.chx.com/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "depository trust")
    agency = {:id=>9012,:name=>'The Depository Trust Company',:raw_name=>'The Depository Trust Company', :url=>'http://www.dtcc.com/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  elsif(sro_name.include? "deposit trust")
    agency = {:id=>9012,:name=>'The Depository Trust Company',:raw_name=>'The Depository Trust Company', :url=>'http://www.dtcc.com/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "edga exchange")
    agency = {:id=>9013,:name=>'EDGA Exchange',:raw_name=>'EDGA Exchange', :url=>'http://www.directedge.com/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "edgx exchange")
    agency = {:id=>9014,:name=>'EDGX Exchange',:raw_name=>'EDGX Exchange', :url=>'http://www.directedge.com/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "financial industry regulatory authority")
    agency = {:id=>9015,:name=>'Financial Institutions Regulatory Authority',:raw_name=>'Financial Institutions Regulatory Authority', :url=>'http://www.finra.org/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "fixed income clearing")
    agency = {:id=>9016,:name=>'Fixed Income Clearing Corp',:raw_name=>'Fixed Income Clearing Corp', :url=>'https://www.nyse.com/markets/nyse-mkthttp://www.dtcc.com/about/businesses-and-subsidiaries/ficc.aspx', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "ice clear credit")
    agency = {:id=>9017,:name=>'ICE Clear Credit',:raw_name=>'ICE Clear Credit', :url=>'https://www.theice.com/clear-credit', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
   
  if(sro_name.include? "ice clear europe")
    agency = {:id=>9018,:name=>'ICE Clear Europe',:raw_name=>'ICE Clear Europe', :url=>'https://www.theice.com/clear-europe', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end 
    
  if(sro_name.include? "ise gemini")
    agency = {:id=>9020,:name=>'ISE Gemini Exchange',:raw_name=>'ISE Gemini Exchange', :url=>'http://www.ise.com/options/ise-gemini/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  elsif(sro_name.include? "topaz exchange")
    agency = {:id=>9020,:name=>'ISE Gemini Exchange',:raw_name=>'ISE Gemini Exchange', :url=>'http://www.ise.com/options/ise-gemini/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "miami international securities exchange")
    agency = {:id=>9021,:name=>'Miami International Stock Exchange',:raw_name=>'Miami International Stock Exchange', :url=>'http://www.miaxoptions.com/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  elsif(sro_name.include? "international securities exchange")
    agency = {:id=>9019,:name=>'International Securities Exchange',:raw_name=>'International Securities Exchange', :url=>'http://www.ise.com/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  elsif(sro_name.include? "national stock exchange")
    agency = {:id=>9029,:name=>'National Stock Exchange',:raw_name=>'National Stock Exchange', :url=>'http://www.nsx.com/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
   
  if(sro_name.include? "municipal securities rulemaking board")
    agency = {:id=>9022,:name=>'Municipal Securities Rulemaking Board',:raw_name=>'Municipal Securities Rulemaking Board', :url=>'http://www.msrb.org/', :parent_id=>466,:json_url=>''}  
    agencies.push(agency)
  end
     
  if(sro_name.include? "nasdaq omx bx")
    agency = {:id=>9023,:name=>'NASDAQ OMX BX',:raw_name=>'NASDAQ OMX BX', :url=>'http://nasdaqomxbx.cchwallstreet.com/NASDAQOMXBX/Main/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  elsif(sro_name.include? "nasdaq omx phlx")
    agency = {:id=>9024,:name=>'NASDAQ OMX PHLX',:raw_name=>'NASDAQ OMX PHLX', :url=>'http://www.nasdaqtrader.com/micro.aspx?id=phlx', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  elsif(sro_name.include? "philadelphia stock exchange")
    agency = {:id=>9024,:name=>'NASDAQ OMX PHLX',:raw_name=>'NASDAQ OMX PHLX)', :url=>'https://www.nyse.com/markets/nyse-mkt', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  elsif(sro_name.include? "nasdaq")
    agency = {:id=>9025,:name=>'NASDAQ',:raw_name=>'NASDAQ', :url=>'http://www.nasdaq.com/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "national association of securities dealers")
    agency = {:id=>9026,:name=>'National Association of Securities Dealers (FINRA)',:raw_name=>'National Association of Securities Dealers (FINRA)', :url=>'http://www.finra.org/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "national futures association")
    agency = {:id=>9027,:name=>'National Futures Association',:raw_name=>'National Futures Association', :url=>'http://www.nfa.futures.org/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "national securities clearing")
    agency = {:id=>9028,:name=>'National Securities Clearing Corp',:raw_name=>'National Securities Clearing Corp', :url=>'http://www.dtcc.com/about/businesses-and-subsidiaries/nscc.aspx', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "new york stock exchange")
    agency = {:id=>9030,:name=>'New York Stock Exchange',:raw_name=>'New York Stock Exchange', :url=>'https://www.nyse.com/index', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
   
  if(sro_name.include? "nyse alternext us")
    agency = {:id=>9031,:name=>'NYSE Alternext (NYSE MKT)',:raw_name=>'NYSE Alternext (NYSE MKT)', :url=>'http://www1.nyse.com/equities/nysealternextequities/1204155563797.html', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
    
  if(sro_name.include? "nyse amex")
    agency = {:id=>9032,:name=>'NYSE Amex (NYSE MKT)',:raw_name=>'NYSE Amex (NYSE MKT)', :url=>'https://www.nyse.com/markets/nyse-mkt', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  elsif(sro_name.include? "nyse mkt")
    agency = {:id=>9032,:name=>'NYSE MKT)',:raw_name=>'NYSE MKT', :url=>'https://www.nyse.com/markets/nyse-mkt', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  elsif(sro_name.include? "american stock exchange")
    agency = {:id=>9032,:name=>'NYSE MKT',:raw_name=>'NYSE MKT', :url=>'https://www.nyse.com/markets/nyse-mkt', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
    
  if(sro_name.include? "nyse arca")
    agency = {:id=>9033,:name=>'NYSE Arca',:raw_name=>'NYSE Arca', :url=>'https://www.nyse.com/markets/nyse-arca', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
    
  if(sro_name.include? "one chicago")
    agency = {:id=>9035,:name=>'One Chicago',:raw_name=>'One Chicago', :url=>'http://www.onechicago.com/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  elsif(sro_name.include? "onechicago")
    agency = {:id=>9035,:name=>'One Chicago',:raw_name=>'One Chicago', :url=>'http://www.onechicago.com/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
   
  if(sro_name.include? "options clearing corp")
    agency = {:id=>9036,:name=>'Options Clearing Corp',:raw_name=>'Options Clearing Corp', :url=>'http://www.optionsclearing.com/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  
  if(sro_name.include? "stock clearing corp. of philadelphia")
    agency = {:id=>9038,:name=>'Stock Clearing Corp of Philadelphia',:raw_name=>'Stock Clearing Corp of Philadelphia', :url=>'http://nasdaqomxphlx.cchwallstreet.com/nasdaqomxphlx/sccp/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  elsif(sro_name.include? "stock clearing corporation of philadelphia")
    agency = {:id=>9038,:name=>'Stock Clearing Corp of Philadelphia',:raw_name=>'Stock Clearing Corp of Philadelphia', :url=>'http://nasdaqomxphlx.cchwallstreet.com/nasdaqomxphlx/sccp/', :parent_id=>466,:json_url=>''}
    agencies.push(agency)
  end
  

  r.db('jurispect').table('documents').get(docId).update({:type=>type, :agencies=>agencies}).run

}
